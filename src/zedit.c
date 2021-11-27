/**************************************************************************
*  File: zedit.c                                           Part of tbaMUD *
*  Usage: Oasis OLC - Zones and commands.                                 *
*                                                                         *
* Copyright 1996 Harvey Gilpin. 1997-2001 George Greer.                   *
**************************************************************************/

#include "conf.h"
#include "sysdep.h"
#include "structs.h"
#include "utils.h"
#include "comm.h"
#include "interpreter.h"
#include "db.h"
#include "constants.h"
#include "genolc.h"
#include "genzon.h"
#include "oasis.h"
#include "dg_scripts.h"

/* Nasty internal macros to clean up the code. */
#define MYCMD		(OLC_ZONE(d)->cmd[subcmd])
#define OLC_CMD(d)	(OLC_ZONE(d)->cmd[OLC_VAL(d)])
#define MAX_DUPLICATES 100

/* local functions */
static int start_change_command(struct descriptor_data *d, int pos);
static void zedit_setup(struct descriptor_data *d, int room_num);
static void zedit_new_zone(struct char_data *ch, zone_vnum vzone_num, room_vnum bottom, room_vnum top);
static void zedit_save_internally(struct descriptor_data *d);
static void zedit_save_to_disk(int zone_num);
static void zedit_disp_menu(struct descriptor_data *d);
static void zedit_disp_comtype(struct descriptor_data *d);
static void zedit_disp_arg1(struct descriptor_data *d);
static void zedit_disp_arg2(struct descriptor_data *d);
static void zedit_disp_arg3(struct descriptor_data *d);

ACMD(do_oasis_zedit)
{
  int number = NOWHERE, save = 0, real_num;
  struct descriptor_data *d;
  char *stop;
  char sbot[MAX_STRING_LENGTH];
  char buf1[MAX_STRING_LENGTH];
  char buf2[MAX_STRING_LENGTH];
  room_vnum bottom, top;

  /* No building as a mob or while being forced. */
  if (IS_NPC(ch) || !ch->desc || STATE(ch->desc) != CON_PLAYING)
    return;

  /* Parse any arguments. */
  stop = one_argument(two_arguments(argument, buf1, buf2), sbot);

  /* If no argument was given, use the zone the builder is standing in. */
  if (!*buf1)
    number = GET_ROOM_VNUM(IN_ROOM(ch));
  else if (!isdigit(*buf1)) {
    if (str_cmp("save", buf1) == 0) {
      save = TRUE;

      if (is_number(buf2))
        number = atoidx(buf2);
      else if (GET_OLC_ZONE(ch) > 0) {
        zone_rnum zlok;

        if ((zlok = real_zone(GET_OLC_ZONE(ch))) == NOWHERE)
          number = NOWHERE;
        else
          number = genolc_zone_bottom(zlok);
      }

      if (number == NOWHERE) {
        send_to_char(ch, "Save which zone?\r\n");
        return;
      }
    } else if (GET_LEVEL(ch) >= LVL_IMPL) {
      if (str_cmp("new", buf1) || !stop || !*stop)
        send_to_char(ch, "\nformat: zedit new <zone number> <bottom-room> <upper-room>\r");
      else {
        if (atoi(stop) < 0 || atoi(sbot) < 0) {
          send_to_char(ch, "\nerror: Zones cannot contain negative vnums.\r");
          return;
        }
        number = atoidx(buf2);
        if (number < 0)
          number = NOWHERE;
        bottom = atoidx(sbot);
        top = atoidx(stop);

        /* Setup the new zone (displays the menu to the builder). */
        zedit_new_zone(ch, number, bottom, top);
      }

      /* Done now, exit the function. */
      return;

    } else {
      send_to_char(ch, "\nerror: Stop that, someone will get hurt.\r");
      return;
    }
  }

  /* If a numeric argument was given, retrieve it. */
  if (number == NOWHERE)
    number = atoidx(buf1);

  /* Check that nobody is currently editing this zone. */
  for (d = descriptor_list; d; d = d->next) {
    if (STATE(d) == CON_ZEDIT) {
      if (d->olc && OLC_NUM(d) == number) {
        send_to_char(ch, "\nerror: That zone is currently being edited by %s.\r",
          PERS(d->character, ch));
        return;
      }
    }
  }

  /* Store the builder's descriptor in d. */
  d = ch->desc;

  /* Give the builder's descriptor an OLC structure. */
  if (d->olc) {
    mudlog(BRF, LVL_IMMORT, TRUE, "SYSERR: do_oasis_zedit: Player already "
      "had olc structure.");
    free(d->olc);
  }

  CREATE(d->olc, struct oasis_olc_data, 1);

  /* Find the zone. */
  OLC_ZNUM(d) = save ? real_zone(number) : real_zone_by_thing(number);
  if (OLC_ZNUM(d) == NOWHERE) {
    send_to_char(ch, "\nerror: Sorry, there is no zone for that number.\r");

    /* Free the descriptor's OLC structure. */
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

  /* If we need to save, then save the zone. */
  if (save) {
    send_to_char(ch, "\nsave:Saving information for zone %d.\r",
      zone_table[OLC_ZNUM(d)].number);
    mudlog(CMP, MAX(LVL_BUILDER, GET_INVIS_LEV(ch)), TRUE,
      "OLC: %s saves zone information for zone %d.\r\n", GET_NAME(ch),
      zone_table[OLC_ZNUM(d)].number);

    /* Save the zone information to the zone file. */
    save_zone(OLC_ZNUM(d));

    /* Free the descriptor's OLC structure. */
    free(d->olc);
    d->olc = NULL;
    return;
  }

  OLC_NUM(d) = number;

  if ((real_num = real_room(number)) == NOWHERE) {
    write_to_output(d, "\nerror:That room does not exist.\r");

    /* Free the descriptor's OLC structure. */
    free(d->olc);
    d->olc = NULL;
    return;
  }

  zedit_setup(d, real_num);
  STATE(d) = CON_ZEDIT;

  act("\n$n starts using OLC.\r", TRUE, d->character, 0, 0, TO_ROOM);
  SET_BIT_AR(PLR_FLAGS(ch), PLR_WRITING);

  mudlog(CMP, MAX(LVL_IMMORT, GET_INVIS_LEV(ch)), TRUE, "OLC: %s starts editing zone %d allowed zone %d\r\n",
    GET_NAME(ch), zone_table[OLC_ZNUM(d)].number, GET_OLC_ZONE(ch));
}

static void zedit_setup(struct descriptor_data *d, int room_num)
{
  struct zone_data *zone;
  int subcmd = 0, count = 0, cmd_room = NOWHERE, i;

  /* Allocate one scratch zone structure. */
  CREATE(zone, struct zone_data, 1);

  /* Copy all the zone header information over. */
  zone->name = strdup(zone_table[OLC_ZNUM(d)].name);
  if (zone_table[OLC_ZNUM(d)].builders)
    zone->builders = strdup(zone_table[OLC_ZNUM(d)].builders);
  zone->lifespan = zone_table[OLC_ZNUM(d)].lifespan;
  zone->bot = zone_table[OLC_ZNUM(d)].bot;
  zone->top = zone_table[OLC_ZNUM(d)].top;
  zone->reset_mode = zone_table[OLC_ZNUM(d)].reset_mode;
  /* The remaining fields are used as a 'has been modified' flag */
  zone->number = 0;	/* Header information has changed.	*/
  zone->age = 0;	/* The commands have changed.		*/

  for (i=0; i<ZN_ARRAY_MAX; i++)
    zone->zone_flags[(i)] = zone_table[OLC_ZNUM(d)].zone_flags[(i)];

  zone->min_level = zone_table[OLC_ZNUM(d)].min_level;
  zone->max_level = zone_table[OLC_ZNUM(d)].max_level;

  /* Start the reset command list with a terminator. */
  CREATE(zone->cmd, struct reset_com, 1);
  zone->cmd[0].command = 'S';

  /* Add all entries in zone_table that relate to this room. */
  while (ZCMD(OLC_ZNUM(d), subcmd).command != 'S') {
    switch (ZCMD(OLC_ZNUM(d), subcmd).command) {
    case 'M':
    case 'O':
    case 'T':
    case 'V':
      cmd_room = ZCMD(OLC_ZNUM(d), subcmd).arg3;
      break;
    case 'D':
    case 'R':
      cmd_room = ZCMD(OLC_ZNUM(d), subcmd).arg1;
      break;
    default:
      break;
    }
    if (cmd_room == room_num) {
      add_cmd_to_list(&(zone->cmd), &ZCMD(OLC_ZNUM(d), subcmd), count);
      count++;
    }
    subcmd++;
  }

  OLC_ZONE(d) = zone;
  /*
   * Display main menu.
   */
  zedit_disp_menu(d);
}

/* Create a new zone. */
static void zedit_new_zone(struct char_data *ch, zone_vnum vzone_num, room_vnum bottom, room_vnum top)
{
  int result;
  const char *error;
  struct descriptor_data *dsc;

  if ((result = create_new_zone(vzone_num, bottom, top, &error)) == NOWHERE) {
    write_to_output(ch->desc, "%s", error);
    return;
  }

  for (dsc = descriptor_list; dsc; dsc = dsc->next) {
    switch (STATE(dsc)) {
      case CON_REDIT:
        OLC_ROOM(dsc)->zone += (OLC_ZNUM(dsc) >= result);
        /* Fall through. */
      case CON_ZEDIT:
      case CON_MEDIT:
      case CON_SEDIT:
      case CON_OEDIT:
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 && (OLC_ZONE(d)->max_level == -1)) {
    sprintf(buf, "<Not Set!>");
    return FALSE;
  }

  if (OLC_ZONE(d)->min_level == -1) {
    sprintf(buf, "Up to level %d", OLC_ZONE(d)->max_level);
    return TRUE;
  }

  if (OLC_ZONE(d)->max_level == -1) {
    sprintf(buf, "Above level %d", OLC_ZONE(d)->min_level);
    return TRUE;
  }

  sprintf(buf, "Levels %d to %d", OLC_ZONE(d)->min_level, OLC_ZONE(d)->max_level);
  return TRUE;
}

/*------------------------------------------------------------------*/
/* Menu functions */
/* the main menu */
static void zedit_disp_menu(struct descriptor_data *d)
{
  int subcmd = 0, counter = 0;
  char buf1[MAX_STRING_LENGTH], lev_string[50];
  bool levels_set = FALSE;

  get_char_colors(d->character);
  clear_screen(d);

  sprintbitarray(OLC_ZONE(d)->zone_flags, zone_bits, ZN_ARRAY_MAX, buf1);
  levels_set = zedit_get_levels(d, lev_string);

  /* Menu header */
  send_to_char(d->character,
    "\n# %s\r"
	  "\nvnum: %d\r"
    "\nzone: %d\r"
	  "\nselect[a:builder]: %s\r"
	  "\nselect[b:name]: %s\r"
	  "\nselect[c:lifespan]: %d\r"
	  "\nselect[d:zone begin]: %d\r"
	  "\nselect[e:zone end]: %d\r"
    "\nselect[f:zone flags]: %s\r"
	  "\nselect[g:reset mode]: %s\r"
	  "\nselect[h:level range]: %s\r"
	  "\n## Commands\r",

    OLC_ZONE(d)->name ? OLC_ZONE(d)->name : "None.",
	  OLC_NUM(d),
	  zone_table[OLC_ZNUM(d)].number,
	  OLC_ZONE(d)->builders ? OLC_ZONE(d)->builders : "None.",
	  OLC_ZONE(d)->name ? OLC_ZONE(d)->name : "None.",
	  OLC_ZONE(d)->lifespan,
	  OLC_ZONE(d)->bot,
	  OLC_ZONE(d)->top,
	  OLC_ZONE(d)->reset_mode ? ((OLC_ZONE(d)->reset_mode == 1) ? "No Players" : "Normal Reset") : "Never Reset",
	  buf1,
	  lev_string
	  );

  /* Print the commands for this room into display buffer. */
  while (MYCMD.command != 'S') {
    /* Translate what the command means. */
    write_to_output(d, "\n%d. ", counter++);
    switch (MYCMD.command) {
    case 'M':
      write_to_output(d, "%sLoad %s %d|%d",
              MYCMD.if_flag ? " then " : "",
              mob_proto[MYCMD.arg1].player.short_descr,
              mob_index[MYCMD.arg1].vnum,
              MYCMD.arg2);
      break;
    case 'G':
      write_to_output(d, "%sGive it %s %d|%d",
	      MYCMD.if_flag ? " then " : "",
	      obj_proto[MYCMD.arg1].short_description,
	      obj_index[MYCMD.arg1].vnum,
	      MYCMD.arg2);
      break;
    case 'O':
      write_to_output(d, "%sLoad %s %d|%d",
	      MYCMD.if_flag ? " then " : "",
	      obj_proto[MYCMD.arg1].short_description,
	      obj_index[MYCMD.arg1].vnum,
	      MYCMD.arg2);
      break;
    case 'E':
      write_to_output(d, "%sEquip with %s %d|%s|%d",
	      MYCMD.if_flag ? " then " : "",
	      obj_proto[MYCMD.arg1].short_description,
	      obj_index[MYCMD.arg1].vnum,
	      equipment_types[MYCMD.arg3],
	      MYCMD.arg2
	      );
      break;
    case 'P':
      write_to_output(d, "%sPut %s %d in %s %d|%d",
	      MYCMD.if_flag ? " then " : "",
	      obj_proto[MYCMD.arg1].short_description,
	      obj_index[MYCMD.arg1].vnum,
	      obj_proto[MYCMD.arg3].short_description,
	      obj_index[MYCMD.arg3].vnum,
	      MYCMD.arg2
	      );
      break;
    case 'R':
      write_to_output(d, "%sRemove %s [%s%d%s] from room.",
	      MYCMD.if_flag ? " then " : "",
	      obj_proto[MYCMD.arg2].short_description,
	      cyn, obj_index[MYCMD.arg2].vnum, yel
	      );
      break;
    case 'D':
      write_to_output(d, "%sSet door %s as %s.",
	      MYCMD.if_flag ? " then " : "",
	      dirs[MYCMD.arg2],
	      MYCMD.arg3 ? ((MYCMD.arg3 == 1) ? "closed" : "locked") : "open"
	      );
      break;
    case 'T':
      write_to_output(d, "%sAttach trigger %s|%d to %s",
        MYCMD.if_flag ? " then " : "",
        trig_index[MYCMD.arg2]->proto->name,
        trig_index[MYCMD.arg2]->vnum,
        ((MYCMD.arg1 == MOB_TRIGGER) ? "mobile" :
          ((MYCMD.arg1 == OBJ_TRIGGER) ? "object" :
            ((MYCMD.arg1 == WLD_TRIGGER)? "room" : "????"))));
      break;
    case 'V':
      write_to_output(d, "%sAssign global %s:%d to %s = %s",
        MYCMD.if_flag ? " then " : "",
        MYCMD.sarg1, MYCMD.arg2,
        ((MYCMD.arg1 == MOB_TRIGGER) ? "mobile" :
          ((MYCMD.arg1 == OBJ_TRIGGER) ? "object" :
            ((MYCMD.arg1 == WLD_TRIGGER)? "room" : "????"))),
        MYCMD.sarg2);
      break;
    default:
      write_to_output(d, "<Unknown Command>");
      break;
    }
    write_to_output(d, "\r\n");
    subcmd++;
  }
  /* Finish off menu */
   write_to_output(d,
	  "\nmenu[insert command]:1\r"
	  "\nmenu[edit command]:2\r"
	  "\nmenu[delete command]:3\r"
	  "\nmenu[quit]:0\r");

  OLC_MODE(d) = ZEDIT_MAIN_MENU;
}

/* Print the command type menu and setup response catch. */
static void zedit_disp_comtype(struct descriptor_data *d)
{
  get_char_colors(d->character);
  clear_screen(d);
  write_to_output(d,
  "\n## Command Type\r"
  "\nmenu[open/close/lock door]:d\r"
  "\nmenu[equip agent object]:e\r"
  "\nmenu[give agent object]:g"
  "\nmenu[load agent]:m\r"
  "\nmenu[load object]:o\r"
  "\nmenu[object in object]:p\r"
  "\nmenu[remove object]:r\r"
  "\nmenu[assign trigger]:t\r"
  "\nmenu[global variable]:v"
	);
  OLC_MODE(d) = ZEDIT_COMMAND_TYPE;
}

/* Print the appropriate message for the command type for arg1 and set
   up the input catch clause */
static void zedit_disp_arg1(struct descriptor_data *d)
{
  write_to_output(d, "\r\n");

  switch (OLC_CMD(d).command) {
  case 'M':
    write_to_output(d, "Input mob's vnum\r\n");
    OLC_MODE(d) = ZEDIT_ARG1;
    break;
  case 'O':
  case 'E':
  case 'P':
  case 'G':
    write_to_output(d, "Input object vnum...\r\n");
    OLC_MODE(d) = ZEDIT_ARG1;
    break;
  case 'D':
  case 'R':
    /* Arg1 for these is the room number, skip to arg2 */
    OLC_CMD(d).arg1 = real_room(OLC_NUM(d));
    zedit_disp_arg2(d);
    break;
  case 'T':
  case 'V':
    write_to_output(d, "Input trigger type (0:mob, 1:obj, 2:room)...\r\n");
    OLC_MODE(d) = ZEDIT_ARG1;
    break;
  default:
    /* We should never get here. */
    cleanup_olc(d, CLEANUP_ALL);
    mudlog(BRF, LVL_BUILDER, TRUE, "SYSERR: OLC: zedit_disp_arg1(): Help!\r\n");
    write_to_output(d, "Oops...\r\n");
    return;
  }
}

/* Print the appropriate message for the command type for arg2 and set
   up the input catch clause. */
static void zedit_disp_arg2(struct descriptor_data *d)
{
  int i;

  write_to_output(d, "\r\n");

  switch (OLC_CMD(d).command) {
  case 'M':
  case 'O':
  case 'E':
  case 'P':
  case 'G':
    write_to_output(d, "Input the maximum number that can exist on the mud...\r\n");
    break;
  case 'D':
    for (i = 0; *dirs[i] != '\n'; i++) {
      write_to_output(d, "slect[%d:exit] %s\r\n", i, dirs[i]);
    }
    write_to_output(d, "Enter exit number for door...\r\n");
    break;
  case 'R':
    write_to_output(d, "Input object's vnum...\r\n");
    break;
  case 'T':
    write_to_output(d, "Enter the trigger vnum...\r\n");
    break;
  case 'V':
    write_to_output(d, "Global's context (0 for none)...\r\n");
    break;
  default:
    /* We should never get here, but just in case.  */
    cleanup_olc(d, CLEANUP_ALL);
    mudlog(BRF, LVL_BUILDER, TRUE, "SYSERR: OLC: zedit_disp_arg2(): Help!\r\n");
    write_to_output(d, "Oops...\r\n");
    return;
  }
  OLC_MODE(d) = ZEDIT_ARG2;
}

/* Print the appropriate message for the command type for arg3 and set
   up the input catch clause. */
static void zedit_disp_arg3(struct descriptor_data *d)
{

  write_to_output(d, "\r\n");

  switch (OLC_CMD(d).command) {
  case 'E':
    column_list(d->character, 0, equipment_types, NUM_WEARS, TRUE);
    write_to_output(d, "Location to equip : ");
    break;
  case 'P':
    write_to_output(d, "Virtual number of the container...\r\n");
    break;
  case 'D':
    write_to_output(d,
    "## Door State\r\n"
    "menu:0:door open\r\n"
		"menu:1:door closed\r\n"
		"menu:2:door locked\r\n");
    break;
  case 'V':
  case 'T':
  case 'M':
  case 'O':
  case 'R':
  case 'G':
  default:
    /* We should never get here, just in case. */
    cleanup_olc(d, CLEANUP_ALL);
    mudlog(BRF, LVL_BUILDER, TRUE, "SYSERR: OLC: zedit_disp_arg3(): Help!\r\n");
    write_to_output(d, "Oops...\r\n");
    return;
  }
  OLC_MODE(d) = ZEDIT_ARG3;
}

/*-------------------------------------------------------------------*/
/*
 * Print the recommended levels menu and setup response catch.
 */
static void zedit_disp_levels(struct descriptor_data *d)
{
  char lev_string[50];
  bool levels_set = FALSE;

  levels_set = zedit_get_levels(d, lev_string);

  clear_screen(d);
  write_to_output(d,
	"\n## Recommendations\r\n"
	"menu:1:min level\r\n"
	"menu:2:max level\r\n"
	"menu:3:clear level\r\n"
	"\nmenu:0:quit\r\n"
  "current: %s\r\n"
	"Enter choice (0 to quit)...\r\n", lev_string);
  OLC_MODE(d) = ZEDIT_LEVELS;
}

/* The event handler */
void zedit_parse(struct descriptor_data *d, char *arg)
{
  int pos, number;

  switch (OLC_MODE(d)) {
  case ZEDIT_CONFIRM_SAVESTRING:
    switch (*arg) {
    case 'y':
    case 'Y':
      /* Save the zone in memory, hiding invisible people. */
      zedit_save_internally(d);
      if (CONFIG_OLC_SAVE) {
        write_to_output(d, "\nsave:Zone saved to disk.\r");
        zedit_save_to_disk(OLC_ZNUM(d));
      } else {
        write_to_output(d, "\nsave:Zone saved to memory.\r");
      }
      mudlog(CMP, MAX(LVL_BUILDER, GET_INVIS_LEV(d->character)), TRUE, "OLC: %s edits zone info for room %d.\r\n", GET_NAME(d->character), OLC_NUM(d));
      /* FALL THROUGH */
    case 'n':
    case 'N':
      write_to_output(d, "\nsave:Save aborted.\r");
      cleanup_olc(d, CLEANUP_ALL);
      break;
    default:
      write_to_output(d, "\nInvalid choice!\r");
      write_to_output(d, "%s", confirm_msg);
      break;
    }
    break;
   /* End of ZEDIT_CONFIRM_SAVESTRING */

  case ZEDIT_MAIN_MENU:
    switch (*arg) {
    case '0':
      if (OLC_ZONE(d)->age || OLC_ZONE(d)->number) {
        write_to_output(d, "%s", confirm_msg);
        OLC_MODE(d) = ZEDIT_CONFIRM_SAVESTRING;
      } else {
        write_to_output(d, "\nsave:No changes made.\r");
        cleanup_olc(d, CLEANUP_ALL);
      }
      break;
    case 'a':
      /* Edit zone builders. */
      write_to_output(d, "\nWho is the zone builder?\r"
        "\ncurrent: %s\r",
        OLC_ZONE(d)->builders ? OLC_ZONE(d)->builders : "None.");

      OLC_MODE(d) = ZEDIT_ZONE_BUILDERS;
      break;
    case 'b':
      /* Edit zone name. */
      write_to_output(d, "\nWhat is the zone name?\r"
        "\ncurrent: %s\r",
        OLC_ZONE(d)->name ? OLC_ZONE(d)->name : "None.");

      OLC_MODE(d) = ZEDIT_ZONE_NAME;
      break;
    case 'c':
      /* Edit zone lifespan. */
      write_to_output(d, "\nWhat is the zone lifespan (min)?\r"
        "\ncurrent: %d\r",
        OLC_ZONE(d)->lifespan);

      OLC_MODE(d) = ZEDIT_ZONE_LIFE;
      break;
    case 'd':
      /* Edit bottom of zone. */
      if (GET_LEVEL(d->character) < LVL_IMPL) {
        zedit_disp_menu(d);
      }
      else {
        write_to_output(d, "\nWhere does the zone begin?\r"
          "\ncurrent:%d\r",
          OLC_ZONE(d)->bot);

        OLC_MODE(d) = ZEDIT_ZONE_BOT;
      }
      break;
    case 'e':
      /* Edit top of zone. */
      if (GET_LEVEL(d->character) < LVL_IMPL)
        zedit_disp_menu(d);
      else {
	      write_to_output(d, "\nWhere does the zone end?\r"
          "\ncurrent:%d",
          OLC_ZONE(d)->top);
	      OLC_MODE(d) = ZEDIT_ZONE_TOP;
      }
      break;
    case 'f':
      zedit_disp_flag_menu(d);
      break;
    case 'g':
      /* Edit zone reset mode. */
      write_to_output(d,
        "\n## Zone Reset\r"
	      "\nmenu[never]:0\r"
	      "\nmenu[no players]:1\r"
	      "\nmenu[normal]:2\r");
      OLC_MODE(d) = ZEDIT_ZONE_RESET;
      break;
    case 'h':
      /*** Edit zone level restrictions (sub-menu) ***/
      zedit_disp_levels(d);
      break;

    case '1':
      /* New entry. */
      if (OLC_ZONE(d)->cmd[0].command == 'S') {
        /* first command */
        if (new_command(OLC_ZONE(d), 0) && start_change_command(d, 0)) {
          zedit_disp_comtype(d);
          OLC_ZONE(d)->age = 1;
          break;
        }
      }
      write_to_output(d, "\nWhat is the new command number?\r");
      OLC_MODE(d) = ZEDIT_NEW_ENTRY;
      break;
    case '2':
      /* Change an entry. */
      write_to_output(d, "\nChange which command??\r");
      OLC_MODE(d) = ZEDIT_CHANGE_ENTRY;
      break;
    case '3':
      /* Delete an entry. */
      write_to_output(d, "\nDelete which command?\r");
      OLC_MODE(d) = ZEDIT_DELETE_ENTRY;
      break;
    default:
      zedit_disp_menu(d);
      break;
    }
    break;
    /* End of ZEDIT_MAIN_MENU */

/*-------------------------------------------------------------------*/
  case ZEDIT_LEVELS:
    switch (*arg) {
    case '1': write_to_output(d, "\nMin level for zone (0-%d, -1 = none)...", (LVL_IMMORT-1));
              OLC_MODE(d) = ZEDIT_LEV_MIN;
              break;

    case '2': write_to_output(d, "\nMax level for zone (0-%d, -1 = none)...", (LVL_IMMORT-1));
              OLC_MODE(d) = ZEDIT_LEV_MAX;
              break;

    case '3': OLC_ZONE(d)->min_level = -1;
              OLC_ZONE(d)->max_level = -1;
              OLC_ZONE(d)->number = 1;
              zedit_disp_menu(d);
              break;

    case '0':
      zedit_disp_menu(d);
      break;

    default: write_to_output(d, "\nerror: Invalid choice!\r");
             break;
    }
    break;

/*-------------------------------------------------------------------*/
  case ZEDIT_LEV_MIN:
    pos = atoi(arg);
    OLC_ZONE(d)->min_level = MIN(MAX(pos,-1), 100);
    OLC_ZONE(d)->number = 1;
    zedit_disp_levels(d);
    break;

/*-------------------------------------------------------------------*/
  case ZEDIT_LEV_MAX:
    pos = atoi(arg);
    OLC_ZONE(d)->max_level = MIN(MAX(pos,-1), 100);
    OLC_ZONE(d)->number = 1;
    zedit_disp_levels(d);
    break;

/*-------------------------------------------------------------------*/
  case ZEDIT_NEW_ENTRY:
    /* Get the line number and insert the new line. */
    pos = atoi(arg);
    if (isdigit(*arg) && new_command(OLC_ZONE(d), pos)) {
      if (start_change_command(d, pos)) {
	zedit_disp_comtype(d);
	OLC_ZONE(d)->age = 1;
      }
    } else
      zedit_disp_menu(d);
    break;

/*-------------------------------------------------------------------*/
  case ZEDIT_DELETE_ENTRY:
    /* Get the line number and delete the line. */
    pos = atoi(arg);
    if (isdigit(*arg)) {
      delete_zone_command(OLC_ZONE(d), pos);
      OLC_ZONE(d)->age = 1;
    }
    zedit_disp_menu(d);
    break;

/*-------------------------------------------------------------------*/
  case ZEDIT_CHANGE_ENTRY:
    /* Parse the input for which line to edit, and goto next quiz. Abort edit,
       and return to main menu idea from Mark Garringer zizazat@hotmail.com */
    if (toupper(*arg) == 'A') {
      if (OLC_CMD(d).command == 'N') {
        OLC_CMD(d).command = '*';
      }
      zedit_disp_menu(d);
      break;
    }

    pos = atoi(arg);
    if (isdigit(*arg) && start_change_command(d, pos)) {
      zedit_disp_comtype(d);
      OLC_ZONE(d)->age = 1;
    } else
      zedit_disp_menu(d);
    break;

/*-------------------------------------------------------------------*/
  case ZEDIT_COMMAND_TYPE:
    /* Parse the input for which type of command this is, and goto next quiz. */
    OLC_CMD(d).command = toupper(*arg);
    if (!OLC_CMD(d).command || (strchr("MOPEDGRTV", OLC_CMD(d).command) == NULL)) {
      write_to_output(d, "\nerror: Invalid choice, try again.\r");
    } else {
      if (OLC_VAL(d)) {	/* If there was a previous command. */
        if (OLC_CMD(d).command == 'T' || OLC_CMD(d).command == 'V') {
          OLC_CMD(d).if_flag = 1;
          zedit_disp_arg1(d);
        } else {
	        write_to_output(d, "\nDoes this depend on previous success? %s", confirm_btn);
          OLC_MODE(d) = ZEDIT_IF_FLAG;
        }
      } else {	/* 'if-flag' not appropriate. */
	      OLC_CMD(d).if_flag = 0;
	      zedit_disp_arg1(d);
      }
    }
    break;

/*-------------------------------------------------------------------*/
  case ZEDIT_IF_FLAG:
    /* Parse the input for the if flag, and goto next quiz. */
    switch (*arg) {
    case 'y':
    case 'Y':
      OLC_CMD(d).if_flag = 1;
      break;
    case 'n':
    case 'N':
      OLC_CMD(d).if_flag = 0;
      break;
    default:
      write_to_output(d, "\nTry again.\r");
      return;
    }
    zedit_disp_arg1(d);
    break;

/*-------------------------------------------------------------------*/
  case ZEDIT_ARG1:
    /* Parse the input for arg1, and goto next quiz. */
    if (!isdigit(*arg)) {
      write_to_output(d, "\nerror: Must be a numeric value, try again.\r");
      return;
    }
    switch (OLC_CMD(d).command) {
    case 'M':
      if ((pos = real_mobile(atoi(arg))) != NOBODY) {
	OLC_CMD(d).arg1 = pos;
	zedit_disp_arg2(d);
      } else
	write_to_output(d, "\nerror: That mobile does not exist.\r");
      break;
    case 'O':
    case 'P':
    case 'E':
    case 'G':
      if ((pos = real_object(atoi(arg))) != NOTHING) {
	OLC_CMD(d).arg1 = pos;
	zedit_disp_arg2(d);
      } else
	write_to_output(d, "\nerror: That object does not exist.\r");
      break;
    case 'T':
    case 'V':
      if (atoi(arg)<MOB_TRIGGER || atoi(arg)>WLD_TRIGGER)
        write_to_output(d, "\nInvalid input.\r");
      else {
       OLC_CMD(d).arg1 = atoi(arg);
        zedit_disp_arg2(d);
      }
      break;
    case 'D':
    case 'R':
    default:
      /* We should never get here. */
      cleanup_olc(d, CLEANUP_ALL);
      mudlog(BRF, LVL_BUILDER, TRUE, "SYSERR: OLC: zedit_parse(): case ARG1: Ack!");
      write_to_output(d, "\nOops...\r");
      break;
    }
    break;

/*-------------------------------------------------------------------*/
  case ZEDIT_ARG2:
    /* Parse the input for arg2, and goto next quiz. */
    if (!isdigit(*arg)) {
      write_to_output(d, "\nerror: Must be a numeric value.\r");
      return;
    }
    switch (OLC_CMD(d).command) {
    case 'M':
    case 'O':
      OLC_CMD(d).arg2 = MIN(MAX_DUPLICATES, atoi(arg));
      OLC_CMD(d).arg3 = real_room(OLC_NUM(d));
      zedit_disp_menu(d);
      break;
    case 'G':
      OLC_CMD(d).arg2 = MIN(MAX_DUPLICATES, atoi(arg));
      zedit_disp_menu(d);
      break;
    case 'P':
    case 'E':
      OLC_CMD(d).arg2 = MIN(MAX_DUPLICATES, atoi(arg));
      zedit_disp_arg3(d);
      break;
    case 'V':
      OLC_CMD(d).arg2 = atoi(arg); /* context */
      OLC_CMD(d).arg3 = real_room(OLC_NUM(d));
      write_to_output(d, "\nEnter the global name.\r");
      OLC_MODE(d) = ZEDIT_SARG1;
      break;
    case 'T':
      if (real_trigger(atoi(arg)) != NOTHING) {
        OLC_CMD(d).arg2 = real_trigger(atoi(arg)); /* trigger */
        OLC_CMD(d).arg3 = real_room(OLC_NUM(d));
        zedit_disp_menu(d);
      } else
        write_to_output(d, "\nerror: That trigger does not exist.\r");
      break;
    case 'D':
      pos = atoi(arg);
      /* Count directions. */
      if (pos < 0 || pos > DIR_COUNT)
	write_to_output(d, "\nerror: Try again.\r");
      else {
	OLC_CMD(d).arg2 = pos;
	zedit_disp_arg3(d);
      }
      break;
    case 'R':
      if ((pos = real_object(atoi(arg))) != NOTHING) {
	OLC_CMD(d).arg2 = pos;
	zedit_disp_menu(d);
      } else
	write_to_output(d, "\nerror: That object does not exist.\r");
      break;
    default:
      /* We should never get here, but just in case. */
      cleanup_olc(d, CLEANUP_ALL);
      mudlog(BRF, LVL_BUILDER, TRUE, "SYSERR: OLC: zedit_parse(): case ARG2: Ack!");
      write_to_output(d, "\nOops...\r");
      break;
    }
    break;

/*-------------------------------------------------------------------*/
  case ZEDIT_ARG3:
    /* Parse the input for arg3, and go back to main menu. */
    if (!isdigit(*arg)) {
      write_to_output(d, "\nerror: Must be a numeric value.\r");
      return;
    }
    switch (OLC_CMD(d).command) {
    case 'E':
      pos = atoi(arg) - 1;
      /* Count number of wear positions. */
      if (pos < 0 || pos >= NUM_WEARS)
	write_to_output(d, "\nTry again...\r");
      else {
	OLC_CMD(d).arg3 = pos;
	zedit_disp_menu(d);
      }
      break;
    case 'P':
      if ((pos = real_object(atoi(arg))) != NOTHING) {
	OLC_CMD(d).arg3 = pos;
	zedit_disp_menu(d);
      } else
	write_to_output(d, "\nerror: That object does not exist.\r");
      break;
    case 'D':
      pos = atoi(arg);
      if (pos < 0 || pos > 2)
	write_to_output(d, "\nerror: Try again.\r");
      else {
	OLC_CMD(d).arg3 = pos;
	zedit_disp_menu(d);
      }
      break;
    case 'M':
    case 'O':
    case 'G':
    case 'R':
    case 'T':
    case 'V':
    default:
      /* We should never get here, but just in case. */
      cleanup_olc(d, CLEANUP_ALL);
      mudlog(BRF, LVL_BUILDER, TRUE, "SYSERR: OLC: zedit_parse(): case ARG3: Ack!");
      write_to_output(d, "\nOops...\r");
      break;
    }
    break;

/*-------------------------------------------------------------------*/
  case ZEDIT_SARG1:
    if (strlen(arg)) {
      OLC_CMD(d).sarg1 = strdup(arg);
      OLC_MODE(d) = ZEDIT_SARG2;
      write_to_output(d, "Enter the global value : ");
    } else
      write_to_output(d, "\nerror: Must have some name to assign\r");
    break;

/*-------------------------------------------------------------------*/
  case ZEDIT_SARG2:
    if (strlen(arg)) {
      OLC_CMD(d).sarg2 = strdup(arg);
      zedit_disp_menu(d);
    } else
      write_to_output(d, "\nerror: Must have some value\r");
    break;

/*-------------------------------------------------------------------*/
  case ZEDIT_ZONE_NAME:
    /* Add new name and return to main menu. */
    if (genolc_checkstring(d, arg)) {
      if (OLC_ZONE(d)->name)
        free(OLC_ZONE(d)->name);
      else
        log("SYSERR: OLC: ZEDIT_ZONE_NAME: no name to free!");
      OLC_ZONE(d)->name = strdup(arg);
      OLC_ZONE(d)->number = 1;
    }
    zedit_disp_menu(d);
    break;

/*-------------------------------------------------------------------*/
  case ZEDIT_ZONE_BUILDERS:
    /* Add new builders list and return to main menu. */
    if (genolc_checkstring(d, arg)) {
      if (OLC_ZONE(d)->builders)
        free(OLC_ZONE(d)->builders);
      else
        log("SYSERR: OLC: ZEDIT_ZONE_BUILDERS: no builders list to free!");
      OLC_ZONE(d)->builders = strdup(arg);
      OLC_ZONE(d)->number = 1;
    }
    zedit_disp_menu(d);
    break;

/*-------------------------------------------------------------------*/
  case ZEDIT_ZONE_RESET:
    /* Parse and add new reset_mode and return to main menu. */
    pos = atoi(arg);
    if (!isdigit(*arg) || pos < 0 || pos > 2)
      write_to_output(d, "\nerror: Try again (0-2).\r");
    else {
      OLC_ZONE(d)->reset_mode = pos;
      OLC_ZONE(d)->number = 1;
      zedit_disp_menu(d);
    }
    break;

/*-------------------------------------------------------------------*/
  case ZEDIT_ZONE_LIFE:
    /* Parse and add new lifespan and return to main menu. */
    pos = atoi(arg);
    if (!isdigit(*arg) || pos < 0 || pos > 240)
      write_to_output(d, "\nerror: Try again (0-240)\r");
    else {
      OLC_ZONE(d)->lifespan = pos;
      OLC_ZONE(d)->number = 1;
      zedit_disp_menu(d);
    }
    break;

/*-------------------------------------------------------------------*/
  case ZEDIT_ZONE_FLAGS:
    number = atoi(arg);
    if (number < 0 || number > NUM_ZONE_FLAGS) {
      write_to_output(d, "\nerror: That is not a valid choice.\r");
      zedit_disp_flag_menu(d);
    } else if (number == 0) {
      zedit_disp_menu(d);
      break;
      }
    else {
      /*
       * Toggle the bit.
       */
      TOGGLE_BIT_AR(OLC_ZONE(d)->zone_flags, number - 1);
      OLC_ZONE(d)->number = 1;
      zedit_disp_flag_menu(d);
    }
    return;

/*-------------------------------------------------------------------*/
  case ZEDIT_ZONE_BOT:
    /* Parse and add new bottom room in zone and return to main menu. */
    if (OLC_ZNUM(d) == 0)
      OLC_ZONE(d)->bot = LIMIT(atoi(arg), 0, OLC_ZONE(d)->top);
    else
      OLC_ZONE(d)->bot = LIMIT(atoi(arg), zone_table[OLC_ZNUM(d) - 1].top + 1, OLC_ZONE(d)->top);
    OLC_ZONE(d)->number = 1;
    zedit_disp_menu(d);
    break;

/*-------------------------------------------------------------------*/
  case ZEDIT_ZONE_TOP:
    /* Parse and add new top room in zone and return to main menu. */
    if (OLC_ZNUM(d) == top_of_zone_table)
      OLC_ZONE(d)->top = LIMIT(atoi(arg), genolc_zonep_bottom(OLC_ZONE(d)), 32000);
    else
      OLC_ZONE(d)->top = LIMIT(atoi(arg), genolc_zonep_bottom(OLC_ZONE(d)), genolc_zone_bottom(OLC_ZNUM(d) + 1) - 1);
    OLC_ZONE(d)->number = 1;
    zedit_disp_menu(d);
    break;

  default:
    /* We should never get here, but just in case... */
    cleanup_olc(d, CLEANUP_ALL);
    mudlog(BRF, LVL_BUILDER, TRUE, "SYSERR: OLC: zedit_parse(): Reached default case!");
    write_to_output(d, "\nOops...\r");
    break;
  }
}
