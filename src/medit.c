/**************************************************************************
*  File: medit.c                                           Part of tbaMUD *
*  Usage: Oasis OLC - Agents.                                            *
*                                                                         *
* Copyright 1996 Harvey Gilpin. 1997-2001 George Greer.                   *
**************************************************************************/

#include "conf.h"
#include "sysdep.h"
#include "structs.h"
#include "utils.h"
#include "interpreter.h"
#include "comm.h"
#include "spells.h"
#include "db.h"
#include "shop.h"
#include "genolc.h"
#include "genmob.h"
#include "genzon.h"
#include "genshp.h"
#include "oasis.h"
#include "handler.h"
#include "constants.h"
#include "class.h"
#include "improved-edit.h"
#include "dg_olc.h"
#include "screen.h"
#include "fight.h"
#include "modify.h"      /* for smash_tilde */

/* local functions */
static void medit_setup_new(struct descriptor_data *d);
static void init_mobile(struct char_data *mob);
static void medit_save_to_disk(zone_vnum zone_num);
static void medit_disp_positions(struct descriptor_data *d);
static void medit_disp_gender(struct descriptor_data *d);
static void medit_disp_class(struct descriptor_data *d);
static void medit_disp_race(struct descriptor_data *d);
static void medit_disp_attack_types(struct descriptor_data *d);
static bool medit_illegal_mob_flag(int fl);
static int  medit_get_mob_flag_by_number(int num);
static void medit_disp_mob_flags(struct descriptor_data *d);
static void medit_disp_aff_flags(struct descriptor_data *d);
static void medit_disp_menu(struct descriptor_data *d);

/*  utility functions */
ACMD(do_oasis_medit)
{
  int number = NOBODY, save = 0, real_num;
  struct descriptor_data *d;
  char buf1[MAX_STRING_LENGTH];
  char buf2[MAX_STRING_LENGTH];

  /* No building as a mob or while being forced. */
  if (IS_NPC(ch) || !ch->desc || STATE(ch->desc) != CON_PLAYING)
    return;

  /* Parse any arguments */
  two_arguments(argument, buf1, buf2);

  if (!*buf1) {
    send_to_char(ch, "\nalert:Specify a Agent VNUM to edit.\r");
    return;
  } else if (!isdigit(*buf1)) {
    if (str_cmp("save", buf1) != 0) {
      send_to_char(ch, "\nalert:Yikes! Stop that, someone will get hurt!\r");
      return;
    }

    save = TRUE;

    if (is_number(buf2))
      number = atoi(buf2);
    else if (GET_OLC_ZONE(ch) > 0) {
      zone_rnum zlok;

      if ((zlok = real_zone(GET_OLC_ZONE(ch))) == NOWHERE)
        number = NOWHERE;
      else
        number = genolc_zone_bottom(zlok);
    }

    if (number == NOWHERE) {
      send_to_char(ch, "\nSave which zone?\r");
      return;
    }
  }

  /* If a numeric argument was given (like a room number), get it. */
  if (number == NOBODY)
    number = atoi(buf1);

  if (number < IDXTYPE_MIN || number > IDXTYPE_MAX) {
    send_to_char(ch, "\nalert:That Agent VNUM can't exist.\r");
    return;
  }

  /* Check that whatever it is isn't already being edited. */
  for (d = descriptor_list; d; d = d->next) {
    if (STATE(d) == CON_MEDIT) {
      if (d->olc && OLC_NUM(d) == number) {
        send_to_char(ch, "\nalert:That Agent is currently being edited by %s.\r",
          GET_NAME(d->character));
        return;
      }
    }
  }

  d = ch->desc;

  /* Give descriptor an OLC structure. */
  if (d->olc) {
    mudlog(BRF, LVL_IMMORT, TRUE, "SYSERR: do_oasis_medit: Player already had olc structure.");
    free(d->olc);
  }

  CREATE(d->olc, struct oasis_olc_data, 1);

  /* Find the zone. */
  OLC_ZNUM(d) = save ? real_zone(number) : real_zone_by_thing(number);
  if (OLC_ZNUM(d) == NOWHERE) {
    send_to_char(ch, "\nalert:Sorry, there is no zone for that number!\r");
    free(d->olc);
    d->olc = NULL;
    return;
  }

  /* Everyone but IMPLs can only edit zones they have been assigned. */
  if (!can_edit_zone(ch, OLC_ZNUM(d))) {
    send_cannot_edit(ch, zone_table[OLC_ZNUM(d)].number);
    /* Free the OLC structure. */
    free(d->olc);
    d->olc = NULL;
    return;
  }

  /* If save is TRUE, save the Agents. */
  if (save) {
    send_to_char(ch, "\nsave:Saving all Agents in zone %d.\r",
      zone_table[OLC_ZNUM(d)].number);
    mudlog(CMP, MAX(LVL_BUILDER, GET_INVIS_LEV(ch)), TRUE,
      "OLC: %s saves Agent info for zone %d.",
      GET_NAME(ch), zone_table[OLC_ZNUM(d)].number);

    /* Save the Agents. */
    save_mobiles(OLC_ZNUM(d));

    /* Free the olc structure stored in the descriptor. */
    free(d->olc);
    d->olc = NULL;
    return;
  }

  OLC_NUM(d) = number;

  /* If this is a new Agent, setup a new one, otherwise, setup the
     existing Agent. */
  if ((real_num = real_mobile(number)) == NOBODY)
    medit_setup_new(d);
  else
    medit_setup_existing(d, real_num);

  medit_disp_menu(d);
  STATE(d) = CON_MEDIT;

  /* Display the OLC messages to the players in the same room as the
     builder and also log it. */
  act("$n starts using OLC.", TRUE, d->character, 0, 0, TO_ROOM);
  SET_BIT_AR(PLR_FLAGS(ch), PLR_WRITING);

  mudlog(CMP, MAX(LVL_IMMORT, GET_INVIS_LEV(ch)), TRUE,"OLC: %s starts editing zone %d allowed zone %d",
    GET_NAME(ch), zone_table[OLC_ZNUM(d)].number, GET_OLC_ZONE(ch));
}

static void medit_save_to_disk(zone_vnum foo)
{
  save_mobiles(real_zone(foo));
}

static void medit_setup_new(struct descriptor_data *d)
{
  struct char_data *mob;

  char avatarstr[MAX_STRING_LENGTH], agentstr[MAX_STRING_LENGTH];

  /* create default strings with agent number in them; */
  sprintf(avatarstr, "%d/main:avatar", OLC_NUM(d));
  sprintf(agentstr, "%d/main:look", OLC_NUM(d));

  /* Allocate a scratch Agent structure. */
  CREATE(mob, struct char_data, 1);

  init_mobile(mob);

  GET_MOB_RNUM(mob) = NOBODY;
  /* Set up some default strings. */
  GET_ALIAS(mob) = strdup("[KEYWORDS]");
  GET_SDESC(mob) = strdup("[NAME]");
  GET_LDESC(mob) = strdup(avatarstr);
  GET_DDESC(mob) = strdup(agentstr);
  SCRIPT(mob) = NULL;
  mob->proto_script = OLC_SCRIPT(d) = NULL;

  OLC_MOB(d) = mob;
  /* Has changed flag. (It hasn't so far, we just made it.) */
  OLC_VAL(d) = FALSE;
  OLC_ITEM_TYPE(d) = MOB_TRIGGER;
}

void medit_setup_existing(struct descriptor_data *d, int rmob_num)
{
  struct char_data *mob;

  /* Allocate a scratch mobile structure. */
  CREATE(mob, struct char_data, 1);

  copy_mobile(mob, mob_proto + rmob_num);

  OLC_MOB(d) = mob;
  OLC_ITEM_TYPE(d) = MOB_TRIGGER;
  dg_olc_script_copy(d);
  /*
   * The edited mob must not have a script.
   * It will be assigned to the updated mob later, after editing.
   */
  SCRIPT(mob) = NULL;
  OLC_MOB(d)->proto_script = NULL;
}

/* Ideally, this function should be in db.c, but I'll put it here for portability. */
static void init_mobile(struct char_data *mob)
{
  clear_char(mob);

  GET_HIT(mob) = GET_MANA(mob) = 1;
  GET_MAX_MANA(mob) = GET_MAX_MOVE(mob) = 100;
  GET_NDD(mob) = GET_SDD(mob) = 1;
  GET_WEIGHT(mob) = 200;
  GET_HEIGHT(mob) = 198;

  mob->real_abils.str = mob->real_abils.intel = mob->real_abils.wis = 11;
  mob->real_abils.dex = mob->real_abils.con = mob->real_abils.cha = 11;
  mob->aff_abils = mob->real_abils;

  GET_SAVE(mob, SAVING_PARA)   = 0;
  GET_SAVE(mob, SAVING_ROD)    = 0;
  GET_SAVE(mob, SAVING_PETRI)  = 0;
  GET_SAVE(mob, SAVING_BREATH) = 0;
  GET_SAVE(mob, SAVING_SPELL)  = 0;

  SET_BIT_AR(MOB_FLAGS(mob), MOB_ISNPC);
  mob->player_specials = &dummy_mob;
}

/* Save new/edited mob to memory. */
void medit_save_internally(struct descriptor_data *d)
{
  int i;
  mob_rnum new_rnum;
  struct descriptor_data *dsc;
  struct char_data *mob;

  i = (real_mobile(OLC_NUM(d)) == NOBODY);

  if ((new_rnum = add_mobile(OLC_MOB(d), OLC_NUM(d))) == NOBODY) {
    log("medit_save_internally: add_mobile failed.");
    return;
  }

  /* Update triggers and free old proto list */
  if (mob_proto[new_rnum].proto_script &&
      mob_proto[new_rnum].proto_script != OLC_SCRIPT(d))
    free_proto_script(&mob_proto[new_rnum], MOB_TRIGGER);

  mob_proto[new_rnum].proto_script = OLC_SCRIPT(d);

  /* this takes care of the mobs currently in-game */
  for (mob = character_list; mob; mob = mob->next) {
    if (GET_MOB_RNUM(mob) != new_rnum)
      continue;

    /* remove any old scripts */
    if (SCRIPT(mob))
      extract_script(mob, MOB_TRIGGER);

    free_proto_script(mob, MOB_TRIGGER);
    copy_proto_script(&mob_proto[new_rnum], mob, MOB_TRIGGER);
    assign_triggers(mob, MOB_TRIGGER);
  }
  /* end trigger update */

  if (!i)	/* Only renumber on new Agents. */
    return;

  /* Update keepers in shops being edited and other mobs being edited. */
  for (dsc = descriptor_list; dsc; dsc = dsc->next) {
    if (STATE(dsc) == CON_SEDIT)
      S_KEEPER(OLC_SHOP(dsc)) += (S_KEEPER(OLC_SHOP(dsc)) != NOTHING && S_KEEPER(OLC_SHOP(dsc)) >= new_rnum);
    else if (STATE(dsc) == CON_MEDIT)
      GET_MOB_RNUM(OLC_MOB(dsc)) += (GET_MOB_RNUM(OLC_MOB(dsc)) != NOTHING && GET_MOB_RNUM(OLC_MOB(dsc)) >= new_rnum);
  }

  /* Update other people in zedit too. From: C.Raehl 4/27/99 */
  for (dsc = descriptor_list; dsc; dsc = dsc->next)
    if (STATE(dsc) == CON_ZEDIT)
      for (i = 0; OLC_ZONE(dsc)->cmd[i].command != 'S'; i++)
        if (OLC_ZONE(dsc)->cmd[i].command == 'M')
          if (OLC_ZONE(dsc)->cmd[i].arg1 >= new_rnum)
            OLC_ZONE(dsc)->cmd[i].arg1++;
}

/* Menu functions
   Display positions. (sitting, standing, etc) */
static void medit_disp_positions(struct descriptor_data *d)
{
  int i, count = 0;
  /*get_char_colors(d->character);*/
  clear_screen(d);
  write_to_output(d, "\n## Position\r"
    "\n::begin:buttons\r");
  for (i = 0; i < NUM_POSITIONS; i++) {
    write_to_output(d, "\nbmud[%s]:%d\r", position_types[i], ++count);
  }
  write_to_output(d, "\n::end:buttons\r");
}

/* Display the gender of the Agent. */
static void medit_disp_gender(struct descriptor_data *d)
{
  int i, count = 0;
  // get_char_colors(d->character);
  clear_screen(d);
  write_to_output(d, "\n## Gender\r"
    "\n::begin:buttons\r");
  for (i = 0; i < NUM_GENDERS; i++) {
    write_to_output(d, "\nbmud[%s]:%d\r", genders[i], ++count);
  }
  write_to_output(d, "\n::end:buttons\r");
}

/* Display the race of the Agent. */
static void medit_disp_race(struct descriptor_data *d)
{
  int i, count = 0;
  // get_char_colors(d->character);
  clear_screen(d);
  write_to_output(d, "\n## Race\r"
    "\n::begin:buttons\r");
  for (i = 0; i < NUM_RACES; i++) {
    write_to_output(d, "\nbmud[%s]:%d\r", races[i], ++count);
  }
  write_to_output(d, "\n::end:buttons\r");
}

/* Display the class of the Agent. */
static void medit_disp_class(struct descriptor_data *d)
{
  int i, count = 0;
  // get_char_colors(d->character);
  clear_screen(d);
  write_to_output(d, "\n## Class\r"
    "\n::begin:buttons\r");
  for (i = 0; i < NUM_CLASSES; i++) {
    write_to_output(d, "\nbmud[%s]:%d\r", class_types[i], ++count);
  }
  write_to_output(d, "\n::end:buttons\r");
}

/* Display attack types menu. */
static void medit_disp_attack_types(struct descriptor_data *d)
{
  int i;

  /*get_char_colors(d->character);*/
  clear_screen(d);
  write_to_output(d, "\n## Attack Type\r"
    "\n::begin:buttons\r");
  for (i = 0; i < NUM_ATTACK_TYPES; i++) {
    write_to_output(d, "\nbmud[%s]:%d\r", attack_hit_text[i].singular, i);
  }
  write_to_output(d, "\n::end:buttons\r");
}

/* Find mob flags that shouldn't be set by builders */
static bool medit_illegal_mob_flag(int fl)
{
  int i;

  /* add any other flags you dont want them setting */
  const int illegal_flags[] = {
    MOB_ISNPC,
    MOB_NOTDEADYET,
  };

  const int num_illegal_flags = sizeof(illegal_flags)/sizeof(int);


  for (i=0; i < num_illegal_flags;i++)
    if (fl == illegal_flags[i])
      return (TRUE);

  return (FALSE);

}

/* Due to illegal mob flags not showing in the mob flags list,
   we need this to convert the list number back to flag value */
static int medit_get_mob_flag_by_number(int num)
{
  int i, count = 0;
  for (i = 0; i < NUM_MOB_FLAGS; i++) {
    if (medit_illegal_mob_flag(i)) continue;
    if ((++count) == num) return i;
  }
  /* Return 'illegal flag' value */
  return -1;
}

/* Display mob-flags menu. */
static void medit_disp_mob_flags(struct descriptor_data *d)
{
  int i, count = 0;
  char flags[MAX_STRING_LENGTH];

  /*get_char_colors(d->character);*/
  clear_screen(d);
  write_to_output(d, "\n## Persona\r"
    "\n::begin:buttons\r");
  /* Mob flags has special handling to remove illegal flags from the list */
  for (i = 0; i < NUM_MOB_FLAGS; i++) {
    if (medit_illegal_mob_flag(i)) continue;
    write_to_output(d, "\nbmud[%s]:%d\r", action_bits[i], ++count);
  }

  sprintbitarray(MOB_FLAGS(OLC_MOB(d)), action_bits, AF_ARRAY_MAX, flags);
  write_to_output(d, "\n::end:buttons\r"
    "\nflags: %s\r"
    "\nmenu[done]:0\r", flags);
}

/* Display affection flags menu. */
static void medit_disp_aff_flags(struct descriptor_data *d)
{
  char flags[MAX_STRING_LENGTH];
  int i, count = 0;

  /*get_char_colors(d->character);*/
  clear_screen(d);

  write_to_output(d, "\n## Affinity Flags\r"
    "\n::begin:buttons\r");
    /* +1/-1 antics needed because AFF_FLAGS doesn't start at 0. */
  for (i = 1; i < NUM_AFF_FLAGS; i++) {
    write_to_output(d, "\nbmud[%s]:%d\r", affected_bits[i], ++count);
  }

  /*column_list(d->character, 0, affected_bits + 1, NUM_AFF_FLAGS - 1, TRUE);*/

  sprintbitarray(AFF_FLAGS(OLC_MOB(d)), affected_bits, AF_ARRAY_MAX, flags);
  write_to_output(d, "\n::end:buttons\r"
    "\nflags: %s\r"
    "\nmenu[done]:0\r", flags);
  }

/* Display main menu. */
static void medit_disp_menu(struct descriptor_data *d)
{
  struct char_data *mob;
  char flags[MAX_STRING_LENGTH], flag2[MAX_STRING_LENGTH];

  mob = OLC_MOB(d);
  get_char_colors(d->character);
  clear_screen(d);

  write_to_output(d,
  "\n# Agent: %d\r"
  "\nselect[a:name]: %s\r"
  "\nselect[b:gender]:%s\r"
  "\nselect[c:race]:%s\r"
  "\nselect[d:class]:%s\r"
  "\nselect[e:keywords]:%s\r"
  "\nselect[f:avatar]:%s\r"
  "\nselect[g:look]:%s\r",
	  OLC_NUM(d),                       // vnum
    GET_SDESC(mob),                   // name
	  genders[(int)GET_GENDER(mob)],    // gender
	  races[(int)GET_RACE(mob)],        // race
    class_types[(int)GET_CLASS(mob)],     // class
	  GET_ALIAS(mob),                   // keywords
	  GET_LDESC(mob),                   // avatar
	  GET_DDESC(mob)                    // look
	  );

  sprintbitarray(MOB_FLAGS(mob), action_bits, AF_ARRAY_MAX, flags);
  sprintbitarray(AFF_FLAGS(mob), affected_bits, AF_ARRAY_MAX, flag2);

  write_to_output(d,
	  "\nselect[h:position]:%s\r"
	  "\nselect[i:default]:%s\r"
	  "\nselect[j:attack]:%s\r"
	  "\nselect[k:persona]:%s\r"
	  "\nselect[l:affinity]:%s\r"
    "\n::begin:buttons\r"
    "\nbmud[stats]:1\r"
    "\nbmud[triggers%s]:2\r"
    "\nbmud[copy agent]:3\r"
	  "\nbmud[delete agent]:4\r"
    "\n::end:buttons\r"
	  "\nmenu[quit]:0\r",

	  position_types[(int)GET_POS(mob)],
	  position_types[(int)GET_DEFAULT_POS(mob)],
	  attack_hit_text[(int)GET_ATTACK(mob)].singular,
	  flags,
	  flag2,
    OLC_SCRIPT(d) ? "*":""
	  );

  OLC_MODE(d) = MEDIT_MAIN_MENU;
}

/* Display main menu. */
static void medit_disp_stats_menu(struct descriptor_data *d)
{
  struct char_data *mob;

  mob = OLC_MOB(d);
  get_char_colors(d->character);
  clear_screen(d);

  /* Top section - standard stats */
  write_to_output(d,
    "\n## Stats\r"
    "\nselect[a:level]:%d\r"
    "\nselect[b:auto]:Set stats...\r"
    "\n### Hit Points  (xdy+z)\r"
    "\nselect[c:hit]:%d\r"
    "\nselect[d:mana]:%d\r"
    "\nselect[e:move]:%d\r",
    GET_LEVEL(mob),
    GET_HIT(mob),
    GET_MANA(mob),
    GET_MOVE(mob)
  );

  write_to_output(d,
    "\n### Bare Hand (xdy+z)\r"
    "\nselect[f:dice]:%d\r"
    "\nselect[g:size]:%d\r"
    "\nselect[h:roll]:%d\r",
    GET_NDD(mob),
    GET_SDD(mob),
    GET_DAMROLL(mob)
  );

  write_to_output(d,
    "\n### General\r"
    "\nselect[i:armor]:%d\r"
    "\nselect[j:experience]:%d\r"
    "\nselect[k:gold]:%d\r"
    "\nselect[l:hitroll]:%d\r"
    "\nselect[m:alignment]:%d\r",
    GET_AC(mob),
    GET_EXP(mob),
    GET_GOLD(mob),
    GET_HITROLL(mob),
    GET_ALIGNMENT(mob)
  );


  if (CONFIG_MEDIT_ADVANCED) {
    /* Bottom section - non-standard stats, togglable in cedit */
    write_to_output(d,
      "\n## Advanced\r"
      "\nselect[n:strength]:%d|%d\r"
      "\nselect[o:intelligence]:%d\r"
      "\nselect[p:wisdom]:%d\r"
      "\nselect[q:dexterity]:%d\r"
      "\nselect[r:con]:%d\r"
      "\nselect[s:charisma]:%d\r"
      "\nselect[t:parlysis]:%d\r"
      "\nselect[u:rod/staves]:%d\r"
      "\nselect[v:petification]:%d\r"
      "\nselect[w:breath]:%d\r"
      "\nselect[x:spells]:%d\r",
      GET_STR(mob),
      GET_ADD(mob),
      GET_INT(mob),
      GET_WIS(mob),
      GET_DEX(mob),
      GET_CON(mob),
      GET_CHA(mob),
      GET_SAVE(mob, SAVING_PARA),
      GET_SAVE(mob, SAVING_ROD),
      GET_SAVE(mob, SAVING_PETRI),
      GET_SAVE(mob, SAVING_BREATH),
      GET_SAVE(mob, SAVING_SPELL)
    );
  }

  /* Quit to previous menu option */
  write_to_output(d, "\nmenu[done]:0\r");

  OLC_MODE(d) = MEDIT_STATS_MENU;
}

void medit_parse(struct descriptor_data *d, char *arg)
{
  int i = -1, j;
  char *oldtext = NULL;

  if (OLC_MODE(d) > MEDIT_NUMERICAL_RESPONSE) {
    i = atoi(arg);
    if (!*arg || (!isdigit(arg[0]) && ((*arg == '-') && !isdigit(arg[1])))) {
      write_to_output(d, "\nTry again.\r");
      return;
    }
  } else {	/* String response. */
    if (!genolc_checkstring(d, arg))
      return;
  }
  switch (OLC_MODE(d)) {
  case MEDIT_CONFIRM_SAVESTRING:
    /* Ensure mob has MOB_ISNPC set. */
    SET_BIT_AR(MOB_FLAGS(OLC_MOB(d)), MOB_ISNPC);
    switch (*arg) {
    case 'y':
    case 'Y':
      /* Save the mob in memory and to disk. */
      medit_save_internally(d);
      mudlog(CMP, MAX(LVL_BUILDER, GET_INVIS_LEV(d->character)), TRUE, "OLC: %s edits mob %d", GET_NAME(d->character), OLC_NUM(d));
      if (CONFIG_OLC_SAVE) {
        medit_save_to_disk(zone_table[real_zone_by_thing(OLC_NUM(d))].number);
        write_to_output(d, "\nsave:Agent saved.\r");
      } else
        write_to_output(d, "\nsave:Agent saved to memory.\r");
      cleanup_olc(d, CLEANUP_ALL);
      return;
    case 'n':
    case 'N':
      /* If not saving, we must free the script_proto list. We do so by
       * assigning it to the edited mob and letting free_mobile in
       * cleanup_olc handle it. */
      write_to_output(d, "\nsave:Agent not saved.\r");
      OLC_MOB(d)->proto_script = OLC_SCRIPT(d);
      cleanup_olc(d, CLEANUP_ALL);
      return;
    default:
      write_to_output(d, "\nInvalid choice!\r");
      write_to_output(d, "%s", confirm_btn);
      return;
    }

  case MEDIT_MAIN_MENU:
    i = 0;
    switch (*arg) {
    case '0':
      if (OLC_VAL(d)) {	/* Anything been changed? */
	      write_to_output(d, "%s", confirm_msg);
	      OLC_MODE(d) = MEDIT_CONFIRM_SAVESTRING;
        return;
      } else {
        write_to_output(d, "\nsave:Agent unchanged.\r");
        cleanup_olc(d, CLEANUP_ALL);
        return;
      }
    case '1':
      OLC_MODE(d) = MEDIT_STATS_MENU;
      medit_disp_stats_menu(d);
      return;
    case '2':
      OLC_SCRIPT_EDIT_MODE(d) = SCRIPT_MAIN_MENU;
      dg_script_menu(d);
      return;

    case '3':
      write_to_output(d, "\nCopy which Agent?\r");
      OLC_MODE(d) = MEDIT_COPY;
      return;

    case '4':
      write_to_output(d, "\n## Delete Agent\r"
        "\np:Do you wish to delete this Agent?\r"
        "%s",
        confirm_btn);
      OLC_MODE(d) = MEDIT_DELETE;
      return;

    case 'a':
      OLC_MODE(d) = MEDIT_S_DESC;
      write_to_output(d, "\nAgent name\r"
        "\ncurrent:%s\r",
        GET_SDESC(OLC_MOB(d))
      );
      return;
    case 'b':
      OLC_MODE(d) = MEDIT_GENDER;
      medit_disp_gender(d);
      return;

    case 'c':
      OLC_MODE(d) = MEDIT_RACE;
      medit_disp_race(d);
      return;

    case 'd':
      OLC_MODE(d) = MEDIT_CLASS;
      medit_disp_class(d);
      return;

    case 'e':
      OLC_MODE(d) = MEDIT_KEYWORD;
      write_to_output(d, "\nWhat are the Agent Keywords?\r"
        "\ncurrent:%s\r",
        GET_ALIAS(OLC_MOB(d))
      );
      return;

    case 'f':
      OLC_MODE(d) = MEDIT_L_DESC;
      write_to_output(d, "\nWhere is the Agent Avatar...\r"
        "\ncurrent:%s\r",
        GET_LDESC(OLC_MOB(d))
      );
      return;

    case 'g':
      OLC_MODE(d) = MEDIT_D_DESC;
      send_editor_help(d);
      write_to_output(d, "\nWhere does the Agent Look...\r");
      if (OLC_MOB(d)->player.description) {
	      write_to_output(d, "\n%s\r", OLC_MOB(d)->player.description);
	      oldtext = strdup(OLC_MOB(d)->player.description);
      }
      string_write(d, &OLC_MOB(d)->player.description, MAX_MOB_DESC, 0, oldtext);
      OLC_VAL(d) = 1;
      return;

    case 'h':
      OLC_MODE(d) = MEDIT_POS;
      medit_disp_positions(d);
      return;

    case 'i':
      OLC_MODE(d) = MEDIT_DEFAULT_POS;
      medit_disp_positions(d);
      return;

    case 'j':
      OLC_MODE(d) = MEDIT_ATTACK;
      medit_disp_attack_types(d);
      return;

    case 'k':
      OLC_MODE(d) = MEDIT_NPC_FLAGS;
      medit_disp_mob_flags(d);
      return;

    case 'l':
      OLC_MODE(d) = MEDIT_AFF_FLAGS;
      medit_disp_aff_flags(d);
      return;

    default:
      medit_disp_menu(d);
      return;
    }
    return;

  case MEDIT_STATS_MENU:
    i=0;
    switch(*arg) {
    case '0':
      medit_disp_menu(d);
      return;
    case 'a':  /* Edit level */
      OLC_MODE(d) = MEDIT_LEVEL;
      write_to_output(d, "\nWhat is the Agent level? (1 to 33)\r"
        "\ncurrent:%d\r",
        GET_LEVEL(OLC_MOB(d))
      );
      return;
    case 'b':  /* Autoroll stats */
      medit_autoroll_stats(d);
      medit_disp_stats_menu(d);
      OLC_VAL(d) = TRUE;
      return;
    case 'c':
      OLC_MODE(d) = MEDIT_NUM_HP_DICE;
      write_to_output(d, "\nWhat ar ethe hit points? (1 to 30)\r"
        "\ncurrent:%d\r",
        GET_HIT(OLC_MOB(d))
      );
      return;
    case 'd':
      OLC_MODE(d) = MEDIT_SIZE_HP_DICE;
      write_to_output(d, "\nWhat is the mana amount? (1 to 1000)\r"
        "\ncurrent:%d\r",
        GET_HIT(OLC_MOB(d))
      );
      return;
    case 'e':
      OLC_MODE(d) = MEDIT_ADD_HP;
      write_to_output(d, "\nWhat is the move amount? (1 to 30,000)\r"
        "\ncurrent:%d\r",
        GET_MOVE(OLC_MOB(d))
      );
      return;
    case 'f':
      OLC_MODE(d) = MEDIT_NDD;
      write_to_output(d, "\nWhat are the number of diece to roll? (1 to 30)\r"
        "\ncurrent:%d\r",
        GET_NDD(OLC_MOB(d))
      );
      return;
    case 'g':
      OLC_MODE(d) = MEDIT_SDD;
      write_to_output(d, "\nWhat is the size of the dice? (1 to 127)\r"
        "\ncurrent:%d\r",
        GET_SDD(OLC_MOB(d))
      );
      return;
    case 'h':
      OLC_MODE(d) = MEDIT_DAMROLL;
      write_to_output(d, "\nWhat is the damage roll? (1 to 50)\r"
        "\ncurrent:%d\r",
        GET_DAMROLL(OLC_MOB(d))
      );
      return;
    case 'i':
      OLC_MODE(d) = MEDIT_AC;
      write_to_output(d, "\nWhat is the armor level? (-200 to 200)\r"
        "\ncurrent:%d\r",
        GET_DAMROLL(OLC_MOB(d))
      );
      return;
    case 'j':
      OLC_MODE(d) = MEDIT_EXP;
      write_to_output(d, "\nWhat is the experience level? (1 to %d)\r"
        "\ncurrent:%d\r",
        MAX_MOB_EXP,
        GET_DAMROLL(OLC_MOB(d))
      );
      return;
    case 'k':
      OLC_MODE(d) = MEDIT_GOLD;
      write_to_output(d, "\nHow much gold does the agent have? (0 to %d)\r"
        "\ncurrent:%d\r",
        MAX_MOB_GOLD,
        GET_GOLD(OLC_MOB(d))
      );
      return;
    case 'l':
      OLC_MODE(d) = MEDIT_HITROLL;
      write_to_output(d, "\nwhat is the hitroll? (0 to 50)\r"
        "\ncurrent:%d\r",
        GET_HITROLL(OLC_MOB(d))
      );
      return;
    case 'm':
      OLC_MODE(d) = MEDIT_ALIGNMENT;
      write_to_output(d, "\nWhat is the agent alignement? (-1000 to 1000)\r"
        "\ncurrent:%d\r",
        GET_ALIGNMENT(OLC_MOB(d))
      );
      return;
    case 'n':
      if (!CONFIG_MEDIT_ADVANCED) {
        write_to_output(d, "\nerror:Invalid Option.\r");
        return;
      }
      OLC_MODE(d) = MEDIT_STR;
      write_to_output(d, "\nSet strength 11 to 25\r"
        "\ncurrent:%d\r",
        GET_STR(OLC_MOB(d))
      );
      return;
    case 'o':
      if (!CONFIG_MEDIT_ADVANCED) {
        write_to_output(d, "\nerror:Invalid Choice.\r");
        return;
      }
      OLC_MODE(d) = MEDIT_INT;
      write_to_output(d, "\nWhat is the intelligence level? (11 to 25)\r"
        "\ncurrent:%d\r",
        GET_INT(OLC_MOB(d))
      );
      return;
    case 'p':
      if (!CONFIG_MEDIT_ADVANCED) {
        write_to_output(d, "\nInvalid Choice!\r");
        return;
	  }
      OLC_MODE(d) = MEDIT_WIS;
      write_to_output(d, "\nWhat is the wisdom level? (11 to 25)\r"
        "\ncurrent:%d\r",
        GET_WIS(OLC_MOB(d))
      );
      return;
    case 'q':
      if (!CONFIG_MEDIT_ADVANCED) {
        write_to_output(d, "\nInvalid Choice!\r");
        return;
      }
      OLC_MODE(d) = MEDIT_DEX;
      write_to_output(d, "\nWhat is the dexterity level? (11 to 25)\r"
        "\ncurrent:%d\r",
        GET_DEX(OLC_MOB(d))
      );
      return;
    case 'r':
      if (!CONFIG_MEDIT_ADVANCED) {
        write_to_output(d, "\nInvalid Choice!");
        return;
	  }
      OLC_MODE(d) = MEDIT_CON;
      write_to_output(d, "\nWhat is the constitution level? (11 to 25)\r"
        "\ncurrent:%d\r",
        GET_CON(OLC_MOB(d))
      );
      return;
    case 's':
      if (!CONFIG_MEDIT_ADVANCED) {
        write_to_output(d, "\nInvalid Choice!\r");
        return;
	  }
      OLC_MODE(d) = MEDIT_CHA;
      write_to_output(d, "\nWhat is the charisma level? (11 to 25)\r"
        "\ncurrent:%d\r",
        GET_CHA(OLC_MOB(d))
      );
      return;
    case 't':
      if (!CONFIG_MEDIT_ADVANCED) {
        write_to_output(d, "\nInvalid Choice!\r");
        return;
	  }
      OLC_MODE(d) = MEDIT_PARA;
      write_to_output(d, "\nWhat is the saving paralysis? (0 to 100)\r"
        "\ncurrent:%d\r",
        GET_SAVE(OLC_MOB(d), SAVING_PARA)
      );
      return;
    case 'u':
      if (!CONFIG_MEDIT_ADVANCED) {
        write_to_output(d, "\nInvalid Choice!\r");
        return;
	  }
      OLC_MODE(d) = MEDIT_ROD;
      write_to_output(d, "\nWhat is the saving rod level? (0 to 100)\r"
        "\ncurrent:%d\r",
        GET_SAVE(OLC_MOB(d), SAVING_ROD)
      );
      return;
    case 'v':
      if (!CONFIG_MEDIT_ADVANCED) {
        write_to_output(d, "\nInvalid Choice!\r");
        return;
	  }
      OLC_MODE(d) = MEDIT_PETRI;
      write_to_output(d, "\nWhat is the saving petrification level? (0 to 100)\r"
        "\ncurrent:%d\r",
        GET_SAVE(OLC_MOB(d), SAVING_PETRI)
      );
      return;
    case 'w':
      if (!CONFIG_MEDIT_ADVANCED) {
        write_to_output(d, "\nInvalid Choice!\r");
        return;
	  }
      OLC_MODE(d) = MEDIT_BREATH;
      write_to_output(d, "\nWhat is the saving breath? (0 to 100)\r"
        "\ncurrent:%d",
        GET_SAVE(OLC_MOB(d), SAVING_BREATH)
      );
      return;
    case 'x':
      if (!CONFIG_MEDIT_ADVANCED) {
        write_to_output(d, "\nInvalid Choice!\r");
        return;
	  }
      OLC_MODE(d) = MEDIT_SPELL;
      write_to_output(d, "\nWhat is the saving spell level? (0 to 100)\r"
        "\ncurrent:%d\r",
        GET_SAVE(OLC_MOB(d), SAVING_SPELL)
      );
      return;
    default:
      medit_disp_stats_menu(d);
      return;
    }
    /*
    if (i == 0)
      break;
    else if (i == 1)
      write_to_output(d, "New value:\r\n");
    else if (i == -1)
      write_to_output(d, "New text:\r\n");
    else
      write_to_output(d, "Oops...\r\n");
    */
    return;

  case OLC_SCRIPT_EDIT:
    if (dg_script_edit_parse(d, arg)) return;
    break;

  case MEDIT_KEYWORD:
    smash_tilde(arg);
    if (GET_ALIAS(OLC_MOB(d)))
      free(GET_ALIAS(OLC_MOB(d)));
    GET_ALIAS(OLC_MOB(d)) = str_udup(arg);
    break;

  case MEDIT_S_DESC:
    smash_tilde(arg);
    if (GET_SDESC(OLC_MOB(d)))
      free(GET_SDESC(OLC_MOB(d)));
    GET_SDESC(OLC_MOB(d)) = str_udup(arg);
    break;

  case MEDIT_L_DESC:
    smash_tilde(arg);
    if (GET_LDESC(OLC_MOB(d)))
      free(GET_LDESC(OLC_MOB(d)));
    if (arg && *arg) {
      char buf[MAX_INPUT_LENGTH];
      snprintf(buf, sizeof(buf), "%s", arg);
      GET_LDESC(OLC_MOB(d)) = strdup(buf);
    } else
      GET_LDESC(OLC_MOB(d)) = strdup("undefined");

    break;

  case MEDIT_D_DESC:
    /*
     * We should never get here.
     */
    cleanup_olc(d, CLEANUP_ALL);
    mudlog(BRF, LVL_BUILDER, TRUE, "SYSERR: OLC: medit_parse(): Reached D_DESC case!");
    write_to_output(d, "\nOops...\r");
    break;

  case MEDIT_NPC_FLAGS:
    if ((i = atoi(arg)) <= 0)
      break;
    else if ( (j = medit_get_mob_flag_by_number(i)) == -1) {
       write_to_output(d, "\nInvalid choice!\r");
       write_to_output(d, "\nEnter mob flags:\nconfig[done]:0\r");
       return;
    } else if (j <= NUM_MOB_FLAGS) {
      TOGGLE_BIT_AR(MOB_FLAGS(OLC_MOB(d)), (j));
    }
    medit_disp_mob_flags(d);
    return;

  case MEDIT_AFF_FLAGS:
    if ((i = atoi(arg)) <= 0)
      break;
    else if (i < NUM_AFF_FLAGS)
      TOGGLE_BIT_AR(AFF_FLAGS(OLC_MOB(d)), i);

    /* Remove unwanted bits right away. */
    REMOVE_BIT_AR(AFF_FLAGS(OLC_MOB(d)), AFF_CHARM);
    REMOVE_BIT_AR(AFF_FLAGS(OLC_MOB(d)), AFF_POISON);
    REMOVE_BIT_AR(AFF_FLAGS(OLC_MOB(d)), AFF_SLEEP);
    medit_disp_aff_flags(d);
    return;

/* Numerical responses. */

  case MEDIT_GENDER:
    GET_GENDER(OLC_MOB(d)) = LIMIT(i - 1, 0, NUM_GENDERS - 1);
    break;

  case MEDIT_RACE:
    GET_RACE(OLC_MOB(d)) = LIMIT(i - 1, 0, NUM_RACES - 1);
    break;

  case MEDIT_CLASS:
    GET_CLASS(OLC_MOB(d)) = LIMIT(i - 1, 0, NUM_CLASSES - 1);
    break;

  case MEDIT_HITROLL:
    GET_HITROLL(OLC_MOB(d)) = LIMIT(i, 0, 50);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_DAMROLL:
    GET_DAMROLL(OLC_MOB(d)) = LIMIT(i, 0, 50);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_NDD:
    GET_NDD(OLC_MOB(d)) = LIMIT(i, 0, 30);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_SDD:
    GET_SDD(OLC_MOB(d)) = LIMIT(i, 0, 127);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_NUM_HP_DICE:
    GET_HIT(OLC_MOB(d)) = LIMIT(i, 0, 30);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_SIZE_HP_DICE:
    GET_MANA(OLC_MOB(d)) = LIMIT(i, 0, 1000);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_ADD_HP:
    GET_MOVE(OLC_MOB(d)) = LIMIT(i, 0, 30000);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_AC:
    GET_AC(OLC_MOB(d)) = LIMIT(i, -200, 200);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_EXP:
    GET_EXP(OLC_MOB(d)) = LIMIT(i, 0, MAX_MOB_EXP);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_GOLD:
    GET_GOLD(OLC_MOB(d)) = LIMIT(i, 0, MAX_MOB_GOLD);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_STR:
    GET_STR(OLC_MOB(d)) = LIMIT(i, 11, 25);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_INT:
    GET_INT(OLC_MOB(d)) = LIMIT(i, 11, 25);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_WIS:
    GET_WIS(OLC_MOB(d)) = LIMIT(i, 11, 25);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_DEX:
    GET_DEX(OLC_MOB(d)) = LIMIT(i, 11, 25);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_CON:
    GET_CON(OLC_MOB(d)) = LIMIT(i, 11, 25);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_CHA:
    GET_CHA(OLC_MOB(d)) = LIMIT(i, 11, 25);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_PARA:
    GET_SAVE(OLC_MOB(d), SAVING_PARA) = LIMIT(i, 0, 100);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_ROD:
    GET_SAVE(OLC_MOB(d), SAVING_ROD) = LIMIT(i, 0, 100);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_PETRI:
    GET_SAVE(OLC_MOB(d), SAVING_PETRI) = LIMIT(i, 0, 100);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_BREATH:
    GET_SAVE(OLC_MOB(d), SAVING_BREATH) = LIMIT(i, 0, 100);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_SPELL:
    GET_SAVE(OLC_MOB(d), SAVING_SPELL) = LIMIT(i, 0, 100);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_POS:
    GET_POS(OLC_MOB(d)) = LIMIT(i - 1, 0, NUM_POSITIONS - 1);
    break;

  case MEDIT_DEFAULT_POS:
    GET_DEFAULT_POS(OLC_MOB(d)) = LIMIT(i - 1, 0, NUM_POSITIONS - 1);
    break;

  case MEDIT_ATTACK:
    GET_ATTACK(OLC_MOB(d)) = LIMIT(i, 0, NUM_ATTACK_TYPES - 1);
    break;

  case MEDIT_LEVEL:
    GET_LEVEL(OLC_MOB(d)) = LIMIT(i, 1, LVL_IMPL);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_ALIGNMENT:
    GET_ALIGNMENT(OLC_MOB(d)) = LIMIT(i, -1000, 1000);
    OLC_VAL(d) = TRUE;
    medit_disp_stats_menu(d);
    return;

  case MEDIT_COPY:
    if ((i = real_mobile(atoi(arg))) != NOWHERE) {
      medit_setup_existing(d, i);
    } else
      write_to_output(d, "\nThat mob does not exist.");
    break;

  case MEDIT_DELETE:
    if (*arg == 'y' || *arg == 'Y') {
      if (delete_mobile(GET_MOB_RNUM(OLC_MOB(d))) != NOBODY)
        write_to_output(d, "\nThe Agent was deleted.");
      else
        write_to_output(d, "\nCouldn't delete the Agent!\r");

      cleanup_olc(d, CLEANUP_ALL);
      return;
    } else if (*arg == 'n' || *arg == 'N') {
      medit_disp_menu(d);
      OLC_MODE(d) = MEDIT_MAIN_MENU;
      return;
    } else
      write_to_output(d, "\nPlease answer 'Y' or 'N':\r");
    break;

  default:
    /* We should never get here. */
    cleanup_olc(d, CLEANUP_ALL);
    mudlog(BRF, LVL_BUILDER, TRUE, "SYSERR: OLC: medit_parse(): Reached default case!");
    write_to_output(d, "\nOops...");
    break;
  }

/* END OF CASE If we get here, we have probably changed something, and now want
   to return to main menu.  Use OLC_VAL as a 'has changed' flag */

  OLC_VAL(d) = TRUE;
  medit_disp_menu(d);
}

void medit_string_cleanup(struct descriptor_data *d, int terminator)
{
  switch (OLC_MODE(d)) {

  case MEDIT_D_DESC:
  default:
     medit_disp_menu(d);
     break;
  }
}

void medit_autoroll_stats(struct descriptor_data *d)
{
  int mob_lev;

  mob_lev = GET_LEVEL(OLC_MOB(d));
  mob_lev = GET_LEVEL(OLC_MOB(d)) = LIMIT(mob_lev, 1, LVL_IMPL);

  GET_MOVE(OLC_MOB(d))    = mob_lev*10;          /* hit point bonus (mobs don't use movement points */
  GET_HIT(OLC_MOB(d))     = mob_lev/5;           /* number of hitpoint dice */
  GET_MANA(OLC_MOB(d))    = mob_lev/5;           /* size of hitpoint dice   */

  GET_NDD(OLC_MOB(d))     = MAX(1, mob_lev/6);   /* number damage dice 1-5  */
  GET_SDD(OLC_MOB(d))     = MAX(2, mob_lev/6);   /* size of damage dice 2-5 */
  GET_DAMROLL(OLC_MOB(d)) = mob_lev/6;           /* damroll (dam bonus) 0-5 */

  GET_HITROLL(OLC_MOB(d)) = mob_lev/3;           /* hitroll 0-10            */
  GET_EXP(OLC_MOB(d))     = (mob_lev*mob_lev*100);
  GET_GOLD(OLC_MOB(d))    = (mob_lev*10);
  GET_AC(OLC_MOB(d))      = (100-(mob_lev*6));   /* AC 94 to -80            */

  /* 'Advanced' stats are only rolled if advanced options are enabled */
  if (CONFIG_MEDIT_ADVANCED) {
    GET_STR(OLC_MOB(d))     = LIMIT((mob_lev*2)/3, 11, 18); /* 2/3 level in range 11 to 18 */
    GET_INT(OLC_MOB(d))     = LIMIT((mob_lev*2)/3, 11, 18);
    GET_WIS(OLC_MOB(d))     = LIMIT((mob_lev*2)/3, 11, 18);
    GET_DEX(OLC_MOB(d))     = LIMIT((mob_lev*2)/3, 11, 18);
    GET_CON(OLC_MOB(d))     = LIMIT((mob_lev*2)/3, 11, 18);
    GET_CHA(OLC_MOB(d))     = LIMIT((mob_lev*2)/3, 11, 18);

    GET_SAVE(OLC_MOB(d), SAVING_PARA)   = mob_lev / 4;  /* All Saving throws */
    GET_SAVE(OLC_MOB(d), SAVING_ROD)    = mob_lev / 4;  /* set to a quarter  */
    GET_SAVE(OLC_MOB(d), SAVING_PETRI)  = mob_lev / 4;  /* of the mobs level */
    GET_SAVE(OLC_MOB(d), SAVING_BREATH) = mob_lev / 4;
    GET_SAVE(OLC_MOB(d), SAVING_SPELL)  = mob_lev / 4;
  }

}
