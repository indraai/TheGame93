/**************************************************************************
*  File: act.informative.c                                 Part of tbaMUD *
*  Usage: Player-level commands of an informative nature.                 *
*                                                                         *
*  All rights reserved.  See license for complete information.            *
*                                                                         *
*  Copyright (C) 1993, 94 by the Trustees of the Johns Hopkins University *
*  CircleMUD is based on DikuMUD, Copyright (C) 1990, 1991.               *
**************************************************************************/

#include "conf.h"
#include "sysdep.h"
#include "structs.h"
#include "utils.h"
#include "comm.h"
#include "interpreter.h"
#include "handler.h"
#include "db.h"
#include "spells.h"
#include "screen.h"
#include "constants.h"
#include "dg_scripts.h"
#include "mud_event.h"
#include "mail.h"         /**< For the has_mail function */
#include "act.h"
#include "class.h"
#include "fight.h"
#include "modify.h"
#include "asciimap.h"
#include "quest.h"

/* prototypes of local functions */
/* do_diagnose utility functions */
static void diag_char_to_char(struct char_data *i, struct char_data *ch);
/* do_look and do_examine utility functions */
//static void do_auto_exits(struct char_data *ch);
static void list_char_to_char(struct char_data *list, struct char_data *ch);
static void list_one_char(struct char_data *i, struct char_data *ch);
static void look_at_char(struct char_data *i, struct char_data *ch);
static void look_at_target(struct char_data *ch, char *arg);
static void look_in_direction(struct char_data *ch, int dir);
static void look_in_obj(struct char_data *ch, char *arg);
/* do_look, do_inventory utility functions */
static void list_obj_to_char(struct obj_data *list, struct char_data *ch, int mode, int show);
static void list_inv_to_char(struct obj_data *list, struct char_data *ch);
/* do_look, do_equipment, do_examine, do_inventory */
static void show_obj_to_char(struct obj_data *obj, struct char_data *ch, int mode);
static void show_obj_modifiers(struct obj_data *obj, struct char_data *ch);
/* do_where utility functions */
static void perform_deva_where(struct char_data *ch, char *arg);
static void perform_mortal_where(struct char_data *ch, char *arg);
static void print_object_location(int num, struct obj_data *obj, struct char_data *ch, int recur);

/* Subcommands */
/* For show_obj_to_char 'mode'.	/-- arbitrary */
#define SHOW_OBJ_LONG     0
#define SHOW_OBJ_SHORT    1
#define SHOW_OBJ_ACTION   2

static void show_obj_to_char(struct obj_data *obj, struct char_data *ch, int mode)
{
  int found = 0;
  struct char_data *temp;

  if (!obj || !ch) {
    log("SYSERR: NULL pointer in show_obj_to_char(): obj=%p ch=%p", (void *)obj, (void *)ch);
    /*  SYSERR_DESC: Somehow a NULL pointer was sent to show_obj_to_char() in
     *  either the 'obj' or the 'ch' variable.  The error will indicate which
     *  was NULL by listing both of the pointers passed to it.  This is often a
     *  difficult one to trace, and may require stepping through a debugger. */
    return;
  }

  if ((mode == 0) && obj->description) {
    if (GET_OBJ_VAL(obj, 1) != 0 || OBJ_SAT_IN_BY(obj)) {
      for (temp = OBJ_SAT_IN_BY(obj); temp; temp = NEXT_SITTING(temp)) {
        if (temp == ch)
          found++;
      }
      if (found) {
        send_to_char(ch, "\ninfo:You are %s upon %s.\r", GET_POS(ch) == POS_SITTING ? "sitting" :
        "resting", obj->short_description);
        goto end;
      }
    }
  }

  switch (mode) {
  case SHOW_OBJ_LONG:
    /* Hide objects starting with . from non-holylighted people. - Elaseth
    if (*obj->description == '.' && (IS_NPC(ch) || !PRF_FLAGGED(ch, PRF_HOLYLIGHT)))
      return;
    */
    if (!IS_NPC(ch) && PRF_FLAGGED(ch, PRF_SHOWVNUMS)) {
      send_to_char(ch, "[%d] ", GET_OBJ_VNUM(obj));
      if (SCRIPT(obj)) {
        if (!TRIGGERS(SCRIPT(obj))->next)
          send_to_char(ch, "[T%d] ", GET_TRIG_VNUM(TRIGGERS(SCRIPT(obj))));
        else
          send_to_char(ch, "[TRIGS] ");
      }
    }
    send_to_char(ch, "\nobject:%s\r", obj->description);
    break;

  case SHOW_OBJ_SHORT:
    if (!IS_NPC(ch) && PRF_FLAGGED(ch, PRF_SHOWVNUMS)) {
      send_to_char(ch, "[%d] ", GET_OBJ_VNUM(obj));
      if (SCRIPT(obj)) {
        if (!TRIGGERS(SCRIPT(obj))->next)
          send_to_char(ch, "[T%d] ", GET_TRIG_VNUM(TRIGGERS(SCRIPT(obj))));
        else
          send_to_char(ch, "[TRIGS] ");
      }
    }
    send_to_char(ch, "\nobject:%s\r", obj->short_description);
    break;

  case SHOW_OBJ_ACTION:
    switch (GET_OBJ_TYPE(obj)) {
    case ITEM_NOTE:
      if (obj->action_description) {
        char notebuf[MAX_NOTE_LENGTH + 64];

        snprintf(notebuf, sizeof(notebuf), "%s", obj->action_description);
        page_string(ch->desc, notebuf, TRUE);
      } else {
	     send_to_char(ch, "\ninfo:It's blank.\r");
      }
      return;

    case ITEM_DRINKCON:
      send_to_char(ch, "\ninfo:It looks like a drink container.\r");
      break;

    default:
      send_to_char(ch, "\ninfo:You see nothing special.\r");
      break;
    }
    break;

  default:
    log("SYSERR: Bad display mode (%d) in show_obj_to_char().", mode);
    /*  SYSERR_DESC:  show_obj_to_char() has some predefined 'mode's (argument
     *  #3) to tell it what to display to the character when it is called.  If
     *  the mode is not one of these, it will output this error, and indicate
     *  what mode was passed to it.  To correct it, you will need to find the
     *  call with the incorrect mode and change it to an acceptable mode. */
    return;
  }
  end:
  show_obj_modifiers(obj, ch);
}

static void show_obj_modifiers(struct obj_data *obj, struct char_data *ch)
{
  if (OBJ_FLAGGED(obj, ITEM_INVISIBLE))
    send_to_char(ch, " (invisible)");

  if (OBJ_FLAGGED(obj, ITEM_BLESS) && AFF_FLAGGED(ch, AFF_DETECT_ALIGN))
    send_to_char(ch, " (blessed)");

  if (OBJ_FLAGGED(obj, ITEM_MAGIC) && AFF_FLAGGED(ch, AFF_DETECT_MAGIC))
    send_to_char(ch, " (magic)");

  if (OBJ_FLAGGED(obj, ITEM_GLOW))
    send_to_char(ch, " (glow)");

  if (OBJ_FLAGGED(obj, ITEM_HUM))
    send_to_char(ch, " (humming)");

  send_to_char(ch, "\r");
}

static void list_obj_to_char(struct obj_data *list, struct char_data *ch, int mode, int show)
{
  struct obj_data *i, *j, *display;
  bool found;
  int num;

  found = FALSE;

  /* Loop through the list of objects */
  for (i = list; i; i = i->next_content) {
    num = 0;

    /* Check the list to see if we've already counted this object */
    for (j = list; j != i; j = j->next_content)
      if ((j->short_description == i->short_description && j->name == i->name) ||
          (!strcmp(j->short_description, i->short_description) && !strcmp(j->name, i->name)))
        break; /* found a matching object */
    if (j != i)
      continue; /* we counted object i earlier in the list */

    /* Count matching objects, including this one */
    for (display = j = i; j; j = j->next_content)
      /* This if-clause should be exactly the same as the one in the loop above */
      if ((j->short_description == i->short_description && j->name == i->name) ||
          (!strcmp(j->short_description, i->short_description) && !strcmp(j->name, i->name)))
        if (CAN_SEE_OBJ(ch, j)) {
          ++num;
          /* If the original item can't be seen, switch it for this one */
          if (display == i && !CAN_SEE_OBJ(ch, display))
            display = j;
        }

    /* When looking in room, hide objects starting with '.', except for holylight */
    if (num > 0 && (mode != SHOW_OBJ_LONG)) {
      send_to_char(ch, "\ntalk:#adv object:thegame %s\r", display->description);
      // show_obj_to_char(display, ch, mode);
      // if (num != 1)
      //   send_to_char(ch, " (%i)", num);
      // send_to_char(ch, "\r");
      found = TRUE;
    }
  }
  if (!found && show)
    send_to_char(ch, "\nobject:Nothing.\r");
}
static void list_inv_to_char(struct obj_data *list, struct char_data *ch)
{
  struct obj_data *i, *j, *display;
  bool found;
  int num;

  found = FALSE;

  /* Loop through the list of objects */
  for (i = list; i; i = i->next_content) {
    num = 0;

    /* Check the list to see if we've already counted this object */
    for (j = list; j != i; j = j->next_content)
      if ((j->short_description == i->short_description && j->name == i->name) ||
          (!strcmp(j->short_description, i->short_description) && !strcmp(j->name, i->name)))
        break; /* found a matching object */
    if (j != i)
      continue; /* we counted object i earlier in the list */

    /* Count matching objects, including this one */
    for (display = j = i; j; j = j->next_content)
      /* This if-clause should be exactly the same as the one in the loop above */
      if ((j->short_description == i->short_description && j->name == i->name) ||
          (!strcmp(j->short_description, i->short_description) && !strcmp(j->name, i->name)))
        if (CAN_SEE_OBJ(ch, j)) {
          ++num;
          /* If the original item can't be seen, switch it for this one */
          if (display == i && !CAN_SEE_OBJ(ch, display))
            display = j;
        }

    if (num > 0) {
      send_to_char(ch, "\ninventory:%s\r", display->short_description);
      found = TRUE;
    }
  }
  if (!found)
    send_to_char(ch, "\ninventory:Nothing.\r");
}

static void diag_char_to_char(struct char_data *i, struct char_data *ch)
{
  struct {
    byte percent;
    const char *text;
  } diagnosis[] = {
    { 100, "is in excellent condition."			},
    {  90, "has a few scratches."			},
    {  75, "has some small wounds and bruises."		},
    {  50, "has quite a few wounds."			},
    {  30, "has some big nasty wounds and scratches."	},
    {  15, "looks pretty hurt."				},
    {   0, "is in awful condition."			},
    {  -1, "is down for the count."	},
  };
  int percent, ar_index;
  const char *pers = PERS(i, ch);

  if (GET_MAX_HIT(i) > 0)
    percent = (100 * GET_HIT(i)) / GET_MAX_HIT(i);
  else
    percent = -1;		/* How could MAX_HIT be < 1?? */

  for (ar_index = 0; diagnosis[ar_index].percent >= 0; ar_index++)
    if (percent >= diagnosis[ar_index].percent)
      break;

  send_to_char(ch, "\n%c%s %s\r", UPPER(*pers), pers + 1, diagnosis[ar_index].text);
}

static void look_at_char(struct char_data *i, struct char_data *ch)
{
  int j, found;

  if (!ch->desc)
    return;

   if (i->player.description)
    send_to_char(ch, "\n# %s\r"
      "\n%s\r",
      i->player.short_descr,
      i->player.description
    );
  else
    act("You see nothing special about $m.", FALSE, i, 0, ch, TO_VICT);

  diag_char_to_char(i, ch);

  found = FALSE;
  for (j = 0; !found && j < NUM_WEARS; j++)
    if (GET_EQ(i, j) && CAN_SEE_OBJ(ch, GET_EQ(i, j)))
      found = TRUE;

  if (found) {
    act("$n is using...", FALSE, i, 0, ch, TO_VICT);
    for (j = 0; j < NUM_WEARS; j++)
      if (GET_EQ(i, j) && CAN_SEE_OBJ(ch, GET_EQ(i, j))) {
	      // send_to_char(ch, "object:%s\r\n", wear_where[j]);
	      show_obj_to_char(GET_EQ(i, j), ch, SHOW_OBJ_SHORT);
      }
  }
  // todo: look at fixing this code better
  if (ch != i && (IS_SARYA(ch) || GET_LEVEL(ch) >= LVL_IMMORT)) {
    act("You look at $s inventory...", FALSE, i, 0, ch, TO_VICT);
    list_obj_to_char(i->carrying, ch, SHOW_OBJ_SHORT, TRUE);
  }
}

static void list_one_char(struct char_data *i, struct char_data *ch)
{
  struct obj_data *furniture;
  const char *positions[] = {
    " is awaiting re=spawn.",
    " is wounded.",
    " is incapacitated.",
    " is stunned.",
    " is sleeping.",
    " is resting.",
    " is sitting.",
    "!FIGHTING!",
    " is standing."
  };

  if (!IS_NPC(ch) && PRF_FLAGGED(ch, PRF_SHOWVNUMS)) {
    if (IS_NPC(i))
    send_to_char(ch, "[%d] ", GET_MOB_VNUM(i));
    if (SCRIPT(i) && TRIGGERS(SCRIPT(i))) {
      if (!TRIGGERS(SCRIPT(i))->next)
        send_to_char(ch, "[T%d] ", GET_TRIG_VNUM(TRIGGERS(SCRIPT(i))));
      else
        send_to_char(ch, "[TRIGS] ");
    }
  }

  if (GROUP(i)) {
    send_to_char(ch, "(%s) ",
      GROUP_LEADER(GROUP(i)) == i ? "leader" : "group"
    );
  }

  if (IS_NPC(i) && i->player.long_descr && GET_POS(i) == GET_DEFAULT_POS(i)) {

    send_to_char(ch, "\ntalk:#adv agent:thegame %s\r", i->player.long_descr);
    /*
    if (AFF_FLAGGED(i, AFF_INVISIBLE)) send_to_char(ch, "*");

    if (AFF_FLAGGED(ch, AFF_DETECT_ALIGN)) {
      if (IS_EVIL(i)) {
        send_to_char(ch, "G ");
      }
      else if (IS_GOOD(i)) {
        send_to_char(ch, "E ");
      }
    }
    */

    /*
    if (AFF_FLAGGED(i, AFF_SANCTUARY))
      act("...$e is glowing!", FALSE, i, 0, ch, TO_VICT);
    if (AFF_FLAGGED(i, AFF_BLIND) && GET_LEVEL(i) < LVL_IMMORT)
      act("...$e is blind!", FALSE, i, 0, ch, TO_VICT);

    send_to_char(ch, "\r");
    */
    return;
  }

  if (IS_NPC(i))
    send_to_char(ch, "%c%s", UPPER(*i->player.short_descr), i->player.short_descr + 1);
  else
    send_to_char(ch, "%s%s%s", i->player.name, *GET_TITLE(i) ? " " : "", GET_TITLE(i));

  if (AFF_FLAGGED(i, AFF_INVISIBLE))
    send_to_char(ch, " (invisible)");
  if (AFF_FLAGGED(i, AFF_HIDE))
    send_to_char(ch, " (hidden)");
  if (!IS_NPC(i) && !i->desc)
    send_to_char(ch, " (linkless)");
  if (!IS_NPC(i) && PLR_FLAGGED(i, PLR_WRITING))
    send_to_char(ch, " (writing)");
  if (!IS_NPC(i) && PRF_FLAGGED(i, PRF_BUILDWALK))
    send_to_char(ch, " (buildwalk)");
  if (!IS_NPC(i) && PRF_FLAGGED(i, PRF_AFK))
    send_to_char(ch, " (AFK)");

  if (GET_POS(i) != POS_FIGHTING) {
    if (!SITTING(i))
      send_to_char(ch, "%s", positions[(int) GET_POS(i)]);
  else {
    furniture = SITTING(i);
    send_to_char(ch, " is %s upon %s.", (GET_POS(i) == POS_SLEEPING ?
        "sleeping" : (GET_POS(i) == POS_RESTING ? "resting" : "sitting")),
        OBJS(furniture, ch));
  }
  } else {
    if (FIGHTING(i)) {
      send_to_char(ch, " is here, fighting ");
      if (FIGHTING(i) == ch)
	send_to_char(ch, "YOU!");
      else {
	if (IN_ROOM(i) == IN_ROOM(FIGHTING(i)))
	  send_to_char(ch, "%s!", PERS(FIGHTING(i), ch));
	else
	  send_to_char(ch,  "someone who has already left!");
      }
    } else			/* NIL fighting pointer */
      send_to_char(ch, " is here struggling with thin air.");
  }

  if (AFF_FLAGGED(ch, AFF_DETECT_ALIGN)) {
    if (IS_EVIL(i))
      send_to_char(ch, " (Red Aura)");
    else if (IS_GOOD(i))
      send_to_char(ch, " (Blue Aura)");
  }

  if (AFF_FLAGGED(i, AFF_SANCTUARY))
    act("...$e glows with a bright light!", FALSE, i, 0, ch, TO_VICT);
}

static void list_char_to_char(struct char_data *list, struct char_data *ch)
{
  struct char_data *i;

  for (i = list; i; i = i->next_in_room)
    if (ch != i) {
      /* hide npcs whose description starts with a '.' from non-holylighted people - Idea from Elaseth of TBA */
      if (!IS_NPC(ch) && !PRF_FLAGGED(ch, PRF_HOLYLIGHT) &&
      	   IS_NPC(i) && i->player.long_descr && *i->player.long_descr == '.')
        continue;
      if (CAN_SEE(ch, i))
        list_one_char(i, ch);
      else if (IS_DARK(IN_ROOM(ch)) && !CAN_SEE_IN_DARK(ch) &&
	       AFF_FLAGGED(i, AFF_INFRAVISION))
        send_to_char(ch, "\ninfo:You see a pair of glowing red eyes looking your way.\r");
    }
}

/*
static void do_auto_exits(struct char_data *ch)
{
  int door, slen = 0;

  send_to_char(ch, "%s[ Exits: ", CCCYN(ch, C_NRM));

  for (door = 0; door < DIR_COUNT; door++) {
    if (!EXIT(ch, door) || EXIT(ch, door)->to_room == NOWHERE)
      continue;
    if (EXIT_FLAGGED(EXIT(ch, door), EX_CLOSED) && !CONFIG_DISP_CLOSED_DOORS)
      continue;
	if (EXIT_FLAGGED(EXIT(ch, door), EX_HIDDEN) && !PRF_FLAGGED(ch, PRF_HOLYLIGHT))
	  continue;
    if (EXIT_FLAGGED(EXIT(ch, door), EX_CLOSED))
	  send_to_char(ch, "%s(%s)%s ", EXIT_FLAGGED(EXIT(ch, door), EX_HIDDEN) ? CCWHT(ch, C_NRM) : CCRED(ch, C_NRM), autoexits[door], CCCYN(ch, C_NRM));
	else if (EXIT_FLAGGED(EXIT(ch, door), EX_HIDDEN))
	  send_to_char(ch, "%s%s%s ", CCWHT(ch, C_NRM), autoexits[door], CCCYN(ch, C_NRM));
    else
      send_to_char(ch, "\t(%s\t) ", autoexits[door]);
    slen++;
  }

  send_to_char(ch, "%s]%s\r\n", slen ? "" : "None!", CCNRM(ch, C_NRM));
}
*/

ACMD(do_exits)
{
  int door, len = 0;

  if (AFF_FLAGGED(ch, AFF_BLIND) && GET_LEVEL(ch) < LVL_IMMORT) {
    send_to_char(ch, "\ninfo:You are blind.\r");
    return;
  }

  // send_to_char(ch, "Obvious exits:\r\n");

  for (door = 0; door < DIR_COUNT; door++) {
    if (!EXIT(ch, door) || EXIT(ch, door)->to_room == NOWHERE)
      continue;
    if (EXIT_FLAGGED(EXIT(ch, door), EX_CLOSED) && !CONFIG_DISP_CLOSED_DOORS)
      continue;
    if (EXIT_FLAGGED(EXIT(ch, door), EX_HIDDEN) && !PRF_FLAGGED(ch, PRF_HOLYLIGHT))
	  continue;

    len++;

    if (!IS_NPC(ch) && PRF_FLAGGED(ch, PRF_SHOWVNUMS) && !EXIT_FLAGGED(EXIT(ch, door), EX_CLOSED))
      send_to_char(ch, "\nexit[%s]: (%d) %s %s\r", dirs[door], GET_ROOM_VNUM(EXIT(ch, door)->to_room),
      EXIT_FLAGGED(EXIT(ch, door), EX_HIDDEN) ? " [HIDDEN]" : "", world[EXIT(ch, door)->to_room].name);
    else if (CONFIG_DISP_CLOSED_DOORS && EXIT_FLAGGED(EXIT(ch, door), EX_CLOSED)) {
      /* But we tell them the door is closed */
      send_to_char(ch, "\nexit[%s]: %s closed%s\r", dirs[door],
		(EXIT(ch, door)->keyword)? fname(EXIT(ch, door)->keyword) : "opening",
		EXIT_FLAGGED(EXIT(ch, door), EX_HIDDEN) ? " and hidden." : ".");
      }
    else
      send_to_char(ch, "\nexit[%s]:%s\r", dirs[door], IS_DARK(EXIT(ch, door)->to_room) && !CAN_SEE_IN_DARK(ch) ? "Too dark to see." : world[EXIT(ch, door)->to_room].name);
  }

  if (!len)
    send_to_char(ch, "\ninfo:None.\r");
}

void look_at_room(struct char_data *ch, int ignore_brief)
{
  trig_data *t;
  struct room_data *rm = &world[IN_ROOM(ch)];
  room_vnum target_room;

  target_room = IN_ROOM(ch);

  if (!ch->desc)
    return;

  if (IS_DARK(IN_ROOM(ch)) && !CAN_SEE_IN_DARK(ch)) {
    send_to_char(ch, "\ninfo:It is too dark to see.\r");
    return;
  } else if (AFF_FLAGGED(ch, AFF_BLIND) && GET_LEVEL(ch) < LVL_IMMORT) {
    send_to_char(ch, "\ninfo:You appear to be blind.\r");
    return;
  }

  send_to_char(ch, "\n# %s", world[IN_ROOM(ch)].name);

  if (!IS_NPC(ch) && PRF_FLAGGED(ch, PRF_SHOWVNUMS)) {
    char buf[MAX_STRING_LENGTH];

    sprintbitarray(ROOM_FLAGS(IN_ROOM(ch)), room_bits, RF_ARRAY_MAX, buf);
    send_to_char(ch, "[%5d] ", GET_ROOM_VNUM(IN_ROOM(ch)));
    send_to_char(ch, "%s [ %s] [ %s ]", world[IN_ROOM(ch)].name, buf, sector_types[world[IN_ROOM(ch)].sector_type]);

    if (SCRIPT(rm)) {
      send_to_char(ch, "[T");
      for (t = TRIGGERS(SCRIPT(rm)); t; t = t->next)
        send_to_char(ch, " %d", GET_TRIG_VNUM(t));
      send_to_char(ch, "]");
    }
  }
  else {
    /* send room title */
    if ((!IS_NPC(ch) && !PRF_FLAGGED(ch, PRF_BRIEF)) || ignore_brief || ROOM_FLAGGED(IN_ROOM(ch), ROOM_DEATH)) {
      if(!IS_NPC(ch) && PRF_FLAGGED(ch, PRF_AUTOMAP) && can_see_map(ch)) {
        str_and_map(world[target_room].description, ch, target_room);
      }
      else {
        /* send the room description */
        send_to_char(ch, "\n::begin:world\r"
          "\ntalk:#adv world:thegame %d\r"
          "\nroom:%d\r"
          "\n::end:world\r",
          GET_ROOM_VNUM(IN_ROOM(ch)),
          GET_ROOM_VNUM(IN_ROOM(ch))
        );
      }
    }
  }

  /* now list characters & objects */
  if (world[IN_ROOM(ch)].people) {
    send_to_char(ch, "\n::begin:agents\r");
    list_char_to_char(world[IN_ROOM(ch)].people, ch);
    send_to_char(ch, "\n::end:agents\r");
  }

  if (world[IN_ROOM(ch)].contents) {
    send_to_char(ch, "\n::begin:objects\r");
    list_obj_to_char(world[IN_ROOM(ch)].contents, ch, SHOW_OBJ_SHORT, FALSE);
    send_to_char(ch, "\n::end:objects\r");
  }

  /* autoexits
  if (!IS_NPC(ch) && PRF_FLAGGED(ch, PRF_AUTOEXIT))
    do_auto_exits(ch);
  */
}

static void look_in_direction(struct char_data *ch, int dir)
{
  if (EXIT(ch, dir)) {
    /*
    if (EXIT(ch, dir)->general_description)
      send_to_char(ch, "%s\r\n", EXIT(ch, dir)->general_description);
    else
      send_to_char(ch, "You see nothing special.\r\n");
    */

    if (EXIT_FLAGGED(EXIT(ch, dir), EX_CLOSED) && EXIT(ch, dir)->keyword)
      send_to_char(ch, "\ninfo:The %s is closed.\r", fname(EXIT(ch, dir)->keyword));

    else if (EXIT_FLAGGED(EXIT(ch, dir), EX_ISDOOR) && EXIT(ch, dir)->keyword)
      send_to_char(ch, "\n# %s\r"
        "\ntalk:#adv world:thegame %d/%s\r"
        "\nroom: %d\r",
        EXIT(ch, dir)->keyword,
        GET_ROOM_VNUM(EXIT(ch, dir)->to_room),
        EXIT(ch, dir)->keyword,
        // EXIT(ch, dir)->general_description,
        GET_ROOM_VNUM(EXIT(ch, dir)->to_room)
      );

    else
      send_to_char(ch, "\n# Look"
        "\ntalk:#adv world:thegame %d/look\r"
        "\nroom: %d\r",
        GET_ROOM_VNUM(EXIT(ch, dir)->to_room),
        GET_ROOM_VNUM(EXIT(ch, dir)->to_room)
      );

  } else
    send_to_char(ch, "\ninfo:You reach into the depths of your own mind and think.\r");
}

static void look_in_obj(struct char_data *ch, char *arg)
{
  struct obj_data *obj = NULL;
  struct char_data *dummy = NULL;
  int amt, bits;

  if (!*arg)
    send_to_char(ch, "\ninfo:Look in what?\r");
  else if (!(bits = generic_find(arg, FIND_OBJ_INV | FIND_OBJ_ROOM |
				 FIND_OBJ_EQUIP, ch, &dummy, &obj))) {
    send_to_char(ch, "\ninfo:There doesn't seem to be %s %s here.\r", AN(arg), arg);
  } else if ((GET_OBJ_TYPE(obj) != ITEM_DRINKCON) &&
	     (GET_OBJ_TYPE(obj) != ITEM_FOUNTAIN) &&
	     (GET_OBJ_TYPE(obj) != ITEM_CONTAINER))
    send_to_char(ch, "\ninfo:There's nothing inside that!\r");
  else {
    if (GET_OBJ_TYPE(obj) == ITEM_CONTAINER) {
      if (OBJVAL_FLAGGED(obj, CONT_CLOSED) && (GET_LEVEL(ch) < LVL_IMMORT || !PRF_FLAGGED(ch, PRF_NOHASSLE))) {
        send_to_char(ch, "\ninfo:It is closed.\r");
      }
      else {
        send_to_char(ch, "\ninfo:%s\r", fname(obj->name));
        list_obj_to_char(obj->contains, ch, SHOW_OBJ_SHORT, TRUE);
      }
    } else {		/* item must be a fountain or drink container */
      if ((GET_OBJ_VAL(obj, 1) == 0) && (GET_OBJ_VAL(obj, 0) != -1)) {
        send_to_char(ch, "\ninfo:It is empty.\r");
      }
      else {
        if (GET_OBJ_VAL(obj, 0) < 0)
        {
          char buf2[MAX_STRING_LENGTH];
          sprinttype(GET_OBJ_VAL(obj, 2), color_liquid, buf2, sizeof(buf2));
          send_to_char(ch, "\ninfo:It's full of a %s liquid.\r", buf2);
        }
	      else if (GET_OBJ_VAL(obj,1)>GET_OBJ_VAL(obj,0)) {
          send_to_char(ch, "\ninfo:Its contents seem somewhat murky.\r"); /* BUG */
        }
        else {
          char buf2[MAX_STRING_LENGTH];
	        amt = (GET_OBJ_VAL(obj, 1) * 3) / GET_OBJ_VAL(obj, 0);
	        sprinttype(GET_OBJ_VAL(obj, 2), color_liquid, buf2, sizeof(buf2));
	        send_to_char(ch, "\ninfo:It's %sfull of a %s liquid.\r", fullness[amt], buf2);
        }
      }
    }
  }
}

char *find_exdesc(char *word, struct extra_descr_data *list) {
  struct extra_descr_data *i;
  for (i = list; i; i = i->next) {
    if (*i->keyword == '.' ? isname(word, i->keyword + 1) : isname(word, i->keyword)) {
      return (i->description);
    }
  }

  return (NULL);
}

/* Given the argument "look at <target>", figure out what object or char
 * matches the target.  First, see if there is another char in the room with
 * the name.  Then check local objs for exdescs. Thanks to Angus Mezick for
 * the suggested fix to this problem. */
static void look_at_target(struct char_data *ch, char *arg)
{
  int bits, found = FALSE, j, fnum, i = 0;
  struct char_data *found_char = NULL;
  struct obj_data *obj, *found_obj = NULL;
  char *desc;

  if (!ch->desc)
    return;

  if (!*arg) {
    send_to_char(ch, "\ninfo:Look at what?\r");
    return;
  }

  bits = generic_find(arg, FIND_OBJ_INV | FIND_OBJ_ROOM | FIND_OBJ_EQUIP |
		      FIND_CHAR_ROOM, ch, &found_char, &found_obj);

  /* Is the target a character? */
  if (found_char != NULL) {
    look_at_char(found_char, ch);
    if (ch != found_char) {
      if (CAN_SEE(found_char, ch))
	act("$n looks at you.", TRUE, ch, 0, found_char, TO_VICT);
      act("$n looks at $N.", TRUE, ch, 0, found_char, TO_NOTVICT);
    }
    return;
  }

  /* Strip off "number." from 2.foo and friends. */
  if (!(fnum = get_number(&arg))) {
    send_to_char(ch, "\ninfo:Look at what?\r");
    return;
  }

  /* Does the argument match an extra desc in the room? */
  if ((desc = find_exdesc(arg, world[IN_ROOM(ch)].ex_description)) != NULL && ++i == fnum) {
    send_to_char(ch, "\n## %s"
      "\ntalk:#adv world:thegame %d/%s\r"
      "\nroom:%d\r",
      arg,
      GET_ROOM_VNUM(IN_ROOM(ch)),
      arg,
      GET_ROOM_VNUM(IN_ROOM(ch))
    );

    // page_string(ch->desc, desc, FALSE);
    return;
  }

  /* Does the argument match an extra desc in the char's equipment? */
  for (j = 0; j < NUM_WEARS && !found; j++)
    if (GET_EQ(ch, j) && CAN_SEE_OBJ(ch, GET_EQ(ch, j)))
      if ((desc = find_exdesc(arg, GET_EQ(ch, j)->ex_description)) != NULL && ++i == fnum) {
        send_to_char(ch, "\n# Equipment\r"
          "\n%s\r",
          desc
        );
        found = TRUE;
      }

  /* Does the argument match an extra desc in the char's inventory? */
  for (obj = ch->carrying; obj && !found; obj = obj->next_content) {
    if (CAN_SEE_OBJ(ch, obj))
      if ((desc = find_exdesc(arg, obj->ex_description)) != NULL && ++i == fnum) {
        send_to_char(ch, "\n# Inventory\r"
          "\n%s\r",
          desc
        );
        found = TRUE;
      }
  }

  /* Does the argument match an extra desc of an object in the room? */
  for (obj = world[IN_ROOM(ch)].contents; obj && !found; obj = obj->next_content) {
    if (CAN_SEE_OBJ(ch, obj)) {
      if ((desc = find_exdesc(arg, obj->ex_description)) != NULL && ++i == fnum) {
        send_to_char(ch, "\n# Object\r"
          "\n%s\r"
          "\nroom:%d\r",
          desc,
          GET_ROOM_VNUM(IN_ROOM(ch))
        );
	      found = TRUE;
      }
    }
  }

  /* If an object was found back in generic_find */
  if (bits) {
    if (!found)
      show_obj_to_char(found_obj, ch, SHOW_OBJ_ACTION);
    else {
      show_obj_modifiers(found_obj, ch);
      send_to_char(ch, "\n");
    }
  } else if (!found)
    send_to_char(ch, "\ninfo:Try looking around for that item.\r");
}

ACMD(do_look)
{
  int look_type;
  int found = 0;
  char tempsave[MAX_INPUT_LENGTH];

  if (!ch->desc)
    return;

  if (GET_POS(ch) < POS_SLEEPING)
    send_to_char(ch, "\ninfo:You are sleeping.\r");
  else if (AFF_FLAGGED(ch, AFF_BLIND) && GET_LEVEL(ch) < LVL_IMMORT)
    send_to_char(ch, "\ninfo:You are blind!\r");
  else if (IS_DARK(IN_ROOM(ch)) && !CAN_SEE_IN_DARK(ch)) {
    send_to_char(ch, "\ninfo:It is dark.\r");
    list_char_to_char(world[IN_ROOM(ch)].people, ch);	/* glowing red eyes */
  } else {
    char arg[MAX_INPUT_LENGTH], arg2[MAX_INPUT_LENGTH];

    half_chop(argument, arg, arg2);

    if (subcmd == SCMD_READ) {
      if (!*arg)
	send_to_char(ch, "\ninfo:Read what?\r");
      else
	look_at_target(ch, strcpy(tempsave, arg));
      return;
    }
    if (!*arg)			/* "look" alone, without an argument at all */
      look_at_room(ch, 1);
    else if (is_abbrev(arg, "in"))
      look_in_obj(ch, arg2);
    /* did the char type 'look <direction>?' */
    else if ((look_type = search_block(arg, dirs, FALSE)) >= 0)
      look_in_direction(ch, look_type);
    else if (is_abbrev(arg, "at"))
      look_at_target(ch, strcpy(tempsave, arg2));
    else if (is_abbrev(arg, "around")) {
      struct extra_descr_data *i;

      for (i = world[IN_ROOM(ch)].ex_description; i; i = i->next) {
        if (*i->keyword != '.') {
          send_to_char(ch, "\n%s%s:%s\r",
          (found ? "\n" : ""), i->keyword, i->description);
          found = 1;
        }
      }
      if (!found)
         send_to_char(ch, "\ninfo:You find nothing noticeable.\r");
    } else
      look_at_target(ch, strcpy(tempsave, arg));
  }
}

ACMD(do_examine)
{
  struct char_data *tmp_char;
  struct obj_data *tmp_object;
  char tempsave[MAX_INPUT_LENGTH], arg[MAX_INPUT_LENGTH];

  one_argument(argument, arg);

  if (!*arg) {
    send_to_char(ch, "\ninfo:What are you attempting to examine?\r");
    return;
  }

  /* look_at_target() eats the number. */
  look_at_target(ch, strcpy(tempsave, arg));	/* strcpy: OK */

  generic_find(arg, FIND_OBJ_INV | FIND_OBJ_ROOM | FIND_CHAR_ROOM |
		      FIND_OBJ_EQUIP, ch, &tmp_char, &tmp_object);

  if (tmp_object) {
    if ((GET_OBJ_TYPE(tmp_object) == ITEM_DRINKCON) ||
	(GET_OBJ_TYPE(tmp_object) == ITEM_FOUNTAIN) ||
	(GET_OBJ_TYPE(tmp_object) == ITEM_CONTAINER)) {
      send_to_char(ch, "\ninfo:You take a look inside and see...\r");
      look_in_obj(ch, arg);
    }
  }
}

ACMD(do_gold)
{
  if (GET_GOLD(ch) == 0)
    send_to_char(ch, "\ngold:You're broke!\r");
  else if (GET_GOLD(ch) == 1)
    send_to_char(ch, "\ngold:You have one miserable little gold coin.\r");
  else
    send_to_char(ch, "\ngold:You have %d gold coins.\r", GET_GOLD(ch));
}

ACMD(do_score)
{
  struct time_info_data playing_time;

  if (IS_NPC(ch))
    return;

  if (age(ch)->month == 0 && age(ch)->day == 0) {
    send_to_char(ch, "\ninfo:It's your birthday.\r");
  }

  send_to_char(ch,
    "\nname: %s\r"
    "\nage: %dyrs\r"
    "\ngender: %s\r"
    "\nclass: %s\r"
    "\nrank: %s\r"
    "\nlevel: %d"
    "\nexp: %d\r"
    "\nalign:%d\r"
    "\ngold: %d\r",
    GET_NAME(ch),
    GET_AGE(ch),
    genders[(int) GET_GENDER(ch)],
    pc_class_types[GET_CLASS(ch)],
    GET_TITLE(ch),
    GET_LEVEL(ch),
    GET_EXP(ch),
    GET_ALIGNMENT(ch),
    GET_GOLD(ch)
  );

  if (GET_LEVEL(ch) < LVL_IMMORT)
    send_to_char(ch, "\nlevelup: %d\r",
	level_exp(GET_CLASS(ch), GET_LEVEL(ch) + 1) - GET_EXP(ch));

  send_to_char(ch, "\nhit: %d|%d\r", GET_HIT(ch), GET_MAX_HIT(ch));
  send_to_char(ch, "\nmana: %d|%d\r", GET_MANA(ch), GET_MAX_MANA(ch));
  send_to_char(ch, "\nmove: %d|%d\r", GET_MOVE(ch), GET_MAX_MOVE(ch));
  send_to_char(ch, "\narmor: %d\r", compute_armor_class(ch));

  send_to_char(ch, "\nquests: %d|%d\r", GET_NUM_QUESTS(ch), GET_QUESTPOINTS(ch));
  if (GET_QUEST(ch) == NOTHING)
    send_to_char(ch, "\nquest:NONE\r");
  else
  {
    send_to_char(ch, "\nquest: %s\r", QST_NAME(real_quest(GET_QUEST(ch))));

    if (!IS_NPC(ch) && PRF_FLAGGED(ch, PRF_SHOWVNUMS))
        send_to_char(ch, " [%d]", GET_QUEST(ch));
  }

  playing_time = *real_time_passed((time(0) - ch->player.time.logon) +
				  ch->player.time.played, 0);
  send_to_char(ch, "\nplaying: %dd %dh\r",
     playing_time.day,
     playing_time.hours);

  switch (GET_POS(ch)) {
  case POS_DEAD:
    send_to_char(ch, "\npos:You are knocked out\r");
    break;
  case POS_MORTALLYW:
    send_to_char(ch, "\npos:You are wounded\r");
    break;
  case POS_INCAP:
    send_to_char(ch, "\npos:Incapacitated\r");
    break;
  case POS_STUNNED:
    send_to_char(ch, "\npos:Stunned\r");
    break;
  case POS_SLEEPING:
    send_to_char(ch, "\npos:Sleeping\r");
    break;
  case POS_RESTING:
    send_to_char(ch, "\npos:Resting\r");
    break;
  case POS_SITTING:
    if (!SITTING(ch))
      send_to_char(ch, "\npos:Sitting\r");
    else {
      struct obj_data *furniture = SITTING(ch);
      send_to_char(ch, "\npos:Sitting on %s\r", furniture->short_description);
    }
    break;
  case POS_FIGHTING:
    send_to_char(ch, "\npos:Fighting %s\r", FIGHTING(ch) ? PERS(FIGHTING(ch), ch) : "thin air");
    break;
  case POS_STANDING:
    send_to_char(ch, "\npos:Standing\r");
    break;
  default:
    send_to_char(ch, "\npos:Floating\r");
    break;
  }

  if (GET_COND(ch, DRUNK) > 10)
    send_to_char(ch, "\ncond:Drunk\r");

  if (GET_COND(ch, HUNGER) == 0)
    send_to_char(ch, "\ncond:Hungry\r");

  if (GET_COND(ch, THIRST) == 0)
    send_to_char(ch, "\ncond:Thirsty\r");

  if (AFF_FLAGGED(ch, AFF_BLIND) && GET_LEVEL(ch) < LVL_IMMORT)
    send_to_char(ch, "\naff:Blind\r");

  if (AFF_FLAGGED(ch, AFF_INVISIBLE))
    send_to_char(ch, "\naff:Invisible\r");

  if (AFF_FLAGGED(ch, AFF_DETECT_INVIS))
    send_to_char(ch, "\naff:Detect Invisible\r");

  if (AFF_FLAGGED(ch, AFF_SANCTUARY))
    send_to_char(ch, "\naff:Sanctuary\r");

  if (AFF_FLAGGED(ch, AFF_POISON))
    send_to_char(ch, "\naffr:Poisoned\r");

  if (AFF_FLAGGED(ch, AFF_CHARM))
    send_to_char(ch, "\naff:Charmed.\r");

  if (affected_by_spell(ch, SPELL_ARMOR))
    send_to_char(ch, "\naff:Protected.\r");

  if (AFF_FLAGGED(ch, AFF_INFRAVISION))
    send_to_char(ch, "\naff:Infra-Vision\r");

  if (PRF_FLAGGED(ch, PRF_SUMMONABLE))
    send_to_char(ch, "\nprf:Summoned.\r");

  /*
  if (GET_LEVEL(ch) >= LVL_IMMORT) {
    if (POOFIN(ch))
      send_to_char(ch, "in:%s %s\r\n", GET_NAME(ch), POOFIN(ch));
    else
      send_to_char(ch, "in:%s has arrived.\r\n", GET_NAME(ch));
    if (POOFOUT(ch))
      send_to_char(ch, "out:%s %s\r\n", GET_NAME(ch), POOFOUT(ch));
    else
      send_to_char(ch, "out:%s has disappeared.\r\n", GET_NAME(ch));

    send_to_char(ch, "%d\r\n", GET_OLC_ZONE(ch));
  }
  */
}

ACMD(do_inventory)
{
  list_inv_to_char(ch->carrying, ch);
}

ACMD(do_equipment)
{
  int i, found = 0;
  for (i = 0; i < NUM_WEARS; i++) {
    if (GET_EQ(ch, i)) {
      found = TRUE;
      if (CAN_SEE_OBJ(ch, GET_EQ(ch, i))) {
        send_to_char(ch, "\nequipment:%s:%s", wear_where[i], GET_EQ(ch, i)->short_description);
      } else {
        send_to_char(ch, "\nequipment:%s:something", wear_where[i]);
      }
    }
  }
  if (!found)
    send_to_char(ch, "\nequipment:No Equipment");
}

ACMD(do_time)
{
  const char *suf;
  int weekday, day;

  /* day in [1..35] */
  day = time_info.day + 1;

  /* 35 days in a month, 7 days a week */
  weekday = ((35 * time_info.month) + day) % 7;

  send_to_char(ch, "time:%d%s | ",
	  (time_info.hours % 12 == 0) ? 12 : (time_info.hours % 12),
	  time_info.hours >= 12 ? "pm" : "am");

  /* Peter Ajamian supplied the following as a fix for a bug introduced in the
   * ordinal display that caused 11, 12, and 13 to be incorrectly displayed as
   * 11st, 12nd, and 13rd.  Nate Winters had already submitted a fix, but it
   * hard-coded a limit on ordinal display which I want to avoid. -dak */
  suf = "th";

  if (((day % 100) / 10) != 1) {
    switch (day % 10) {
    case 1:
      suf = "st";
      break;
    case 2:
      suf = "nd";
      break;
    case 3:
      suf = "rd";
      break;
    }
  }
  send_to_char(ch, "\ndate:%s - %s %d, %d.",
    weekdays[weekday],
    month_name[time_info.month],
	  day,
    time_info.year);
}

ACMD(do_weather)
{
  const char *sky_look[] = {
    "clear blue",
    "cloudy",
    "rainy",
    "lit by flashes of lightning"
  };

  if (OUTSIDE(ch))
    {
    send_to_char(ch, "\nweather:The sky is %s and %s.", sky_look[weather_info.sky], weather_info.change >= 0 ? "you feel a cool breeze" : "you feel the weather changing");
    if (GET_LEVEL(ch) >= LVL_DEVA)
      send_to_char(ch, "\npressure: %d (change: %d)"
        "\nsky: %d (%s)",
        weather_info.pressure,
        weather_info.change,
        weather_info.sky,
        sky_look[weather_info.sky]
      );
    }
  else
    send_to_char(ch, "\nweather:This inside weather is amazing!");
}

/* puts -'s instead of spaces */
void space_to_minus(char *str)
{
  while ((str = strchr(str, ' ')) != NULL)
    *str = '-';
}

int search_help(const char *argument, int level)
{
  int chk, bot, top, mid, minlen;

   bot = 0;
   top = top_of_helpt;
   minlen = strlen(argument);

  while (bot <= top) {
    mid = (bot + top) / 2;

    if (!(chk = strn_cmp(argument, help_table[mid].keywords, minlen)))  {
      while ((mid > 0) && !strn_cmp(argument, help_table[mid - 1].keywords, minlen))
         mid--;

      while (level < help_table[mid].min_level && mid < (bot + top) / 2)
        mid++;
      if (strn_cmp(argument, help_table[mid].keywords, minlen) || level < help_table[mid].min_level)
        break;

      return (mid);
    }
    else if (chk > 0)
      bot = mid + 1;
    else
      top = mid - 1;
  }
  return NOWHERE;
}

ACMD(do_help)
{
  int mid = 0;
  int i, found = 0;

    if (!ch->desc)
    return;

  skip_spaces(&argument);

  if (!help_table) {
    send_to_char(ch, "\nNo help available.");
    return;
  }

  if (!*argument) {
    if (GET_LEVEL(ch) < LVL_IMMORT)
      page_string(ch->desc, help, 0);
    else
      page_string(ch->desc, ihelp, 0);
    return;
  }

  space_to_minus(argument);

  if ((mid = search_help(argument, GET_LEVEL(ch))) == NOWHERE) {
    send_to_char(ch, "\nThere is no help found for that word.");
    mudlog(NRM, MIN(LVL_IMPL, GET_INVIS_LEV(ch)), TRUE,
      "%s tried to get help on %s", GET_NAME(ch), argument);
    for (i = 0; i < top_of_helpt; i++)  {
      if (help_table[i].min_level > GET_LEVEL(ch))
        continue;
      /* To help narrow down results, if they don't start with the same letters, move on. */
      if (*argument != *help_table[i].keywords)
        continue;
      if (levenshtein_distance(argument, help_table[i].keywords) <= 2) {
        if (!found) {
          send_to_char(ch, "\nDid you mean...");
          found = 1;
        }
        send_to_char(ch, "\ntalk:#mud help %s", help_table[i].keywords);
      }
    }
    return;
  }
  page_string(ch->desc, help_table[mid].entry, 0);
}

#define WHO_FORMAT \
"\nUsage: who [minlev[-maxlev]] [-n name] [-c classlist] [-k] [-l] [-n] [-q] [-r] [-s] [-z]"

/* Written by Rhade */
ACMD(do_who)
{
  struct descriptor_data *d;
  struct char_data *tch;
  int i, num_can_see = 0;
  char name_search[MAX_INPUT_LENGTH], buf[MAX_INPUT_LENGTH];
  char mode;
  int low = 0, high = LVL_IMPL, localwho = 0, questwho = 0;
  int showclass = 0, short_list = 0, outlaws = 0;
  int who_room = 0, showgroup = 0, showleader = 0;

  struct {
    char *disp;
    int min_level;
    int max_level;
    int count; /* must always start as 0 */
  } rank[] = {
    { "\nImmortals", LVL_IMMORT, LVL_IMPL, 0},
    { "\nMortals", 1, LVL_IMMORT - 1, 0 },
    { "\n", 0, 0, 0 }
  };

  skip_spaces(&argument);
  strcpy(buf, argument);   /* strcpy: OK (sizeof: argument == buf) */
  name_search[0] = '\0';

  while (*buf) {
    char arg[MAX_INPUT_LENGTH], buf1[MAX_INPUT_LENGTH];

    half_chop(buf, arg, buf1);
    if (isdigit(*arg)) {
      sscanf(arg, "%d-%d", &low, &high);
      strcpy(buf, buf1);   /* strcpy: OK (sizeof: buf1 == buf) */
    } else if (*arg == '-') {
      mode = *(arg + 1);       /* just in case; we destroy arg in the switch */
      switch (mode) {
      case 'k':
        outlaws = 1;
        strcpy(buf, buf1);   /* strcpy: OK (sizeof: buf1 == buf) */
        break;
      case 'z':
        localwho = 1;
        strcpy(buf, buf1);   /* strcpy: OK (sizeof: buf1 == buf) */
        break;
      case 's':
        short_list = 1;
        strcpy(buf, buf1);   /* strcpy: OK (sizeof: buf1 == buf) */
        break;
      case 'q':
        questwho = 1;
        strcpy(buf, buf1);   /* strcpy: OK (sizeof: buf1 == buf) */
        break;
      case 'n':
        half_chop(buf1, name_search, buf);
        break;
      case 'r':
        who_room = 1;
        strcpy(buf, buf1);   /* strcpy: OK (sizeof: buf1 == buf) */
        break;
      case 'c':
        half_chop(buf1, arg, buf);
        showclass = find_class_bitvector(arg);
        break;
      case 'l':
        showleader = 1;
        strcpy(buf, buf1);   /* strcpy: OK (sizeof: buf1 == buf) */
        break;
      case 'g':
        showgroup = 1;
        strcpy(buf, buf1);   /* strcpy: OK (sizeof: buf1 == buf) */
        break;
      default:
        send_to_char(ch, "%s", WHO_FORMAT);
        return;
      }
    } else {
      send_to_char(ch, "%s", WHO_FORMAT);
      return;
    }
  }

  for (d = descriptor_list; d && !short_list; d = d->next) {
    if (d->original)
      tch = d->original;
    else if (!(tch = d->character))
      continue;

    if (CAN_SEE(ch, tch) && IS_PLAYING(d)) {
      if (*name_search && str_cmp(GET_NAME(tch), name_search) &&
          !strstr(GET_TITLE(tch), name_search))
        continue;
      if (!CAN_SEE(ch, tch) || GET_LEVEL(tch) < low || GET_LEVEL(tch) > high)
        continue;
      if (outlaws && !PLR_FLAGGED(tch, PLR_KILLER) && !PLR_FLAGGED(tch, PLR_THIEF))
        continue;
      if (questwho && !PRF_FLAGGED(tch, PRF_QUEST))
        continue;
      if (localwho && world[IN_ROOM(ch)].zone != world[IN_ROOM(tch)].zone)
        continue;
      if (who_room && (IN_ROOM(tch) != IN_ROOM(ch)))
        continue;
      if (showclass && !(showclass & (1 << GET_CLASS(tch))))
        continue;
      if (showgroup && !GROUP(tch))
        continue;
      if (showleader && (!GROUP(tch) || GROUP_LEADER(GROUP(tch)) != tch))
        continue;
      for (i = 0; *rank[i].disp != '\n'; i++)
        if (GET_LEVEL(tch) >= rank[i].min_level && GET_LEVEL(tch) <= rank[i].max_level)
          rank[i].count++;
    }
  }

  for (i = 0; *rank[i].disp != '\n'; i++) {
    if (!rank[i].count && !short_list)
      continue;

    if (short_list)
      send_to_char(ch, "\n# Players");
    else
      send_to_char(ch, "\n%s", rank[i].disp);

    for (d = descriptor_list; d; d = d->next) {
      if (d->original)
        tch = d->original;
      else if (!(tch = d->character))
        continue;

      if ((GET_LEVEL(tch) < rank[i].min_level || GET_LEVEL(tch) > rank[i].max_level) && !short_list)
        continue;
      if (!IS_PLAYING(d))
        continue;
      if (*name_search && str_cmp(GET_NAME(tch), name_search) &&
          !strstr(GET_TITLE(tch), name_search))
        continue;
      if (!CAN_SEE(ch, tch) || GET_LEVEL(tch) < low || GET_LEVEL(tch) > high)
        continue;
      if (outlaws && !PLR_FLAGGED(tch, PLR_KILLER) && !PLR_FLAGGED(tch, PLR_THIEF))
        continue;
      if (questwho && !PRF_FLAGGED(tch, PRF_QUEST))
        continue;
      if (localwho && world[IN_ROOM(ch)].zone != world[IN_ROOM(tch)].zone)
        continue;
      if (who_room && (IN_ROOM(tch) != IN_ROOM(ch)))
        continue;
      if (showclass && !(showclass & (1 << GET_CLASS(tch))))
        continue;
      if (showgroup && !GROUP(tch))
        continue;
      if (showleader && (!GROUP(tch) || GROUP_LEADER(GROUP(tch)) != tch))
        continue;

      if (short_list) {
        send_to_char(ch, "%s[%2d %s] %-12.12s%s%s",
          (GET_LEVEL(tch) >= LVL_IMMORT ? CCYEL(ch, C_SPR) : ""),
          GET_LEVEL(tch), CLASS_ABBR(tch), GET_NAME(tch),
          CCNRM(ch, C_SPR), ((!(++num_can_see % 4)) ? "\n" : ""));
      } else {
        num_can_see++;
        send_to_char(ch, "%s[%2d %s] %s%s%s%s",
            (GET_LEVEL(tch) >= LVL_IMMORT ? CCYEL(ch, C_SPR) : ""),
            GET_LEVEL(tch), CLASS_ABBR(tch),
            GET_NAME(tch), (*GET_TITLE(tch) ? " " : ""), GET_TITLE(tch),
            CCNRM(ch, C_SPR));

        if (GET_INVIS_LEV(tch))
          send_to_char(ch, " (i%d)", GET_INVIS_LEV(tch));
        else if (AFF_FLAGGED(tch, AFF_INVISIBLE))
          send_to_char(ch, " (invis)");

        if (PLR_FLAGGED(tch, PLR_MAILING))
          send_to_char(ch, " (mailing)");
        else if (d->olc)
          send_to_char(ch, " (OLC)");
        else if (PLR_FLAGGED(tch, PLR_WRITING))
          send_to_char(ch, " (writing)");

        if (d->original)
          send_to_char(ch, " (out of body)");

        if (d->connected == CON_OEDIT)
          send_to_char(ch, " (Object Edit)");
        if (d->connected == CON_MEDIT)
          send_to_char(ch, " (Mobile Edit)");
        if (d->connected == CON_ZEDIT)
          send_to_char(ch, " (Zone Edit)");
        if (d->connected == CON_SEDIT)
          send_to_char(ch, " (Shop Edit)");
        if (d->connected == CON_REDIT)
          send_to_char(ch, " (Room Edit)");
        if (d->connected == CON_TEDIT)
          send_to_char(ch, " (Text Edit)");
        if (d->connected == CON_TRIGEDIT)
          send_to_char(ch, " (Trigger Edit)");
        if (d->connected == CON_AEDIT)
          send_to_char(ch, " (Social Edit)");
        if (d->connected == CON_CEDIT)
          send_to_char(ch, " (Configuration Edit)");
        if (d->connected == CON_HEDIT)
          send_to_char(ch, " (Help edit)");
        if (d->connected == CON_QEDIT)
          send_to_char(ch, " (Quest Edit)");
        if (PRF_FLAGGED(tch, PRF_BUILDWALK))
          send_to_char(ch, " (Buildwalking)");
        if (PRF_FLAGGED(tch, PRF_AFK))
          send_to_char(ch, " (AFK)");
        if (PRF_FLAGGED(tch, PRF_NOGOSS))
          send_to_char(ch, " (nogos)");
        if (PRF_FLAGGED(tch, PRF_NOWIZ))
          send_to_char(ch, " (nowiz)");
        if (PRF_FLAGGED(tch, PRF_NOSHOUT))
          send_to_char(ch, " (noshout)");
        if (PRF_FLAGGED(tch, PRF_NOTELL))
          send_to_char(ch, " (notell)");
        if (PRF_FLAGGED(tch, PRF_QUEST))
          send_to_char(ch, " (quest)");
        if (PLR_FLAGGED(tch, PLR_THIEF))
          send_to_char(ch, " (THIEF)");
        if (PLR_FLAGGED(tch, PLR_KILLER))
          send_to_char(ch, " (KILLER)");
        send_to_char(ch, "\n");
      }
    }
    send_to_char(ch, "\n");
    if (short_list)
      break;
  }
  if (short_list && num_can_see % 4)
    send_to_char(ch, "\n");
  if (!num_can_see)
    send_to_char(ch, "\nNobody at all!");
  else if (num_can_see == 1)
    send_to_char(ch, "\nOne lonely character displayed.");
  else
    send_to_char(ch, "\n%d characters displayed.", num_can_see);

  if (IS_HAPPYHOUR > 0){
    send_to_char(ch, "It's a Happy Hour! Type [happyhour] to see the current bonuses.\r");
  }
}

#define USERS_FORMAT \
"\nformat: users [-l minlevel[-maxlevel]] [-n name] [-h host] [-c classlist] [-o] [-p]"

ACMD(do_users)
{
  char line[200], line2[220], idletime[10], classname[20];
  char state[30], timestr[9], mode;
  char name_search[MAX_INPUT_LENGTH], host_search[MAX_INPUT_LENGTH];
  struct char_data *tch;
  struct descriptor_data *d;
  int low = 0, high = LVL_IMPL, num_can_see = 0;
  int showclass = 0, outlaws = 0, playing = 0, deadweight = 0;
  char buf[MAX_INPUT_LENGTH], arg[MAX_INPUT_LENGTH];

  host_search[0] = name_search[0] = '\0';

  strcpy(buf, argument);	/* strcpy: OK (sizeof: argument == buf) */
  while (*buf) {
    char buf1[MAX_INPUT_LENGTH];

    half_chop(buf, arg, buf1);
    if (*arg == '-') {
      mode = *(arg + 1);  /* just in case; we destroy arg in the switch */
      switch (mode) {
      case 'o':
      case 'k':
	outlaws = 1;
	playing = 1;
	strcpy(buf, buf1);	/* strcpy: OK (sizeof: buf1 == buf) */
	break;
      case 'p':
	playing = 1;
	strcpy(buf, buf1);	/* strcpy: OK (sizeof: buf1 == buf) */
	break;
      case 'd':
	deadweight = 1;
	strcpy(buf, buf1);	/* strcpy: OK (sizeof: buf1 == buf) */
	break;
      case 'l':
	playing = 1;
	half_chop(buf1, arg, buf);
	sscanf(arg, "%d-%d", &low, &high);
	break;
      case 'n':
	playing = 1;
	half_chop(buf1, name_search, buf);
	break;
      case 'h':
	playing = 1;
	half_chop(buf1, host_search, buf);
	break;
      case 'c':
	playing = 1;
	half_chop(buf1, arg, buf);
	showclass = find_class_bitvector(arg);
	break;
      default:
	send_to_char(ch, "%s", USERS_FORMAT);
	return;
      }				/* end of switch */

    } else {			/* endif */
      send_to_char(ch, "%s", USERS_FORMAT);
      return;
    }
  }				/* end while (parser) */
  send_to_char(ch,
	 "Num Class   Name         State          Idl   Login\t*   Site\r\n"
	 "--- ------- ------------ -------------- ----- -------- ------------------------\r\n");

  one_argument(argument, arg);

  for (d = descriptor_list; d; d = d->next) {
    if (STATE(d) != CON_PLAYING && playing)
      continue;
    if (STATE(d) == CON_PLAYING && deadweight)
      continue;
    if (IS_PLAYING(d)) {
      if (d->original)
        tch = d->original;
      else if (!(tch = d->character))
        continue;

      if (*host_search && !strstr(d->host, host_search))
        continue;
      if (*name_search && str_cmp(GET_NAME(tch), name_search))
        continue;
      if (!CAN_SEE(ch, tch) || GET_LEVEL(tch) < low || GET_LEVEL(tch) > high)
        continue;
      if (outlaws && !PLR_FLAGGED(tch, PLR_KILLER) &&
	  !PLR_FLAGGED(tch, PLR_THIEF))
        continue;
      if (showclass && !(showclass & (1 << GET_CLASS(tch))))
        continue;
      if (GET_INVIS_LEV(tch) > GET_LEVEL(ch))
        continue;

      if (d->original)
	sprintf(classname, "[%2d %s]", GET_LEVEL(d->original),
		CLASS_ABBR(d->original));
      else
	sprintf(classname, "[%2d %s]", GET_LEVEL(d->character),
		CLASS_ABBR(d->character));
    } else
      strcpy(classname, "   -   ");

    strftime(timestr, sizeof(timestr), "%H:%M:%S", localtime(&(d->login_time)));

    if (STATE(d) == CON_PLAYING && d->original)
      strcpy(state, "Switched");
    else
      strcpy(state, connected_types[STATE(d)]);

    if (d->character && STATE(d) == CON_PLAYING)
      sprintf(idletime, "%5d", d->character->char_specials.timer *
	      SECS_PER_MUD_HOUR / SECS_PER_REAL_MIN);
    else
      strcpy(idletime, "     ");

    sprintf(line, "%3d %-7s %-12s %-14s %-3s %-8s ", d->desc_num, classname,
	d->original && d->original->player.name ? d->original->player.name :
	d->character && d->character->player.name ? d->character->player.name :
	"UNDEFINED",
	state, idletime, timestr);

    if (*d->host)
      sprintf(line + strlen(line), "[%s]", d->host);
    else
      strcat(line, "[Hostname unknown]");

    if (STATE(d) != CON_PLAYING) {
      sprintf(line2, "%s%s%s", CCGRN(ch, C_SPR), line, CCNRM(ch, C_SPR));
      strcpy(line, line2);
    }
    if (STATE(d) != CON_PLAYING || (STATE(d) == CON_PLAYING && CAN_SEE(ch, d->character))) {
      send_to_char(ch, "%s", line);
      num_can_see++;
    }
  }

  send_to_char(ch, "\nThere are %d visible sockets connected.", num_can_see);
}

/* Generic page_string function for displaying text */
ACMD(do_gen_ps)
{
  if (IS_NPC(ch)) {
    send_to_char(ch, "\ninfo:Not for mobiles!");
    return;
  }

  switch (subcmd) {
  case SCMD_CREDITS:
    page_string(ch->desc, credits, 0);
    break;
  case SCMD_NEWS:
    GET_LAST_NEWS(ch) = time(0);
    page_string(ch->desc, news, 0);
    break;
  case SCMD_INFO:
    page_string(ch->desc, info, 0);
    break;
  case SCMD_WIZLIST:
    page_string(ch->desc, wizlist, 0);
    break;
  case SCMD_IMMLIST:
    page_string(ch->desc, immlist, 0);
    break;
  case SCMD_HANDBOOK:
    page_string(ch->desc, handbook, 0);
    break;
  case SCMD_POLICIES:
    page_string(ch->desc, policies, 0);
    break;
  case SCMD_MOTD:
    GET_LAST_MOTD(ch) = time(0);
    page_string(ch->desc, motd, 0);
    break;
  case SCMD_IMOTD:
    page_string(ch->desc, imotd, 0);
    break;
  case SCMD_CLEAR:
    send_to_char(ch, "\033[H\033[J");
    break;
  case SCMD_VERSION:
    send_to_char(ch, "\n%s", tbamud_version);
    break;
  case SCMD_WHOAMI:
    send_to_char(ch, "\n%s", GET_NAME(ch));
    break;
  default:
    log("SYSERR: Unhandled case in do_gen_ps. (%d)", subcmd);
    /* SYSERR_DESC: General page string function for such things as 'credits',
     * 'news', 'wizlist', 'clear', 'version'.  This occurs when a call is made
     * to this routine that is not one of the predefined calls.  To correct it,
     * either a case needs to be added into the function to account for the
     * subcmd that is being passed to it, or the call to the function needs to
     * have the correct subcmd put into place. */
    return;
  }
}

static void perform_mortal_where(struct char_data *ch, char *arg)
{
  struct char_data *i;
  struct descriptor_data *d;
  int j;

  if (!*arg) {
    j = world[(IN_ROOM(ch))].zone;
    send_to_char(ch, "Players in %s\tn.\r\n--------------------\r\n", zone_table[j].name);
    for (d = descriptor_list; d; d = d->next) {
      if (STATE(d) != CON_PLAYING || d->character == ch)
	continue;
      if ((i = (d->original ? d->original : d->character)) == NULL)
	continue;
      if (IN_ROOM(i) == NOWHERE || !CAN_SEE(ch, i))
	continue;
      if (world[IN_ROOM(ch)].zone != world[IN_ROOM(i)].zone)
	continue;
      send_to_char(ch, "\n%-20s%s - %s%s", GET_NAME(i), QNRM, world[IN_ROOM(i)].name, QNRM);
    }
  } else {			/* print only FIRST char, not all. */
    for (i = character_list; i; i = i->next) {
      if (IN_ROOM(i) == NOWHERE || i == ch)
	continue;
      if (!CAN_SEE(ch, i) || world[IN_ROOM(i)].zone != world[IN_ROOM(ch)].zone)
	continue;
      if (!isname(arg, i->player.name))
	continue;
      send_to_char(ch, "\n%-25s%s - %s%s", GET_NAME(i), QNRM, world[IN_ROOM(i)].name, QNRM);
      return;
    }
    send_to_char(ch, "\ninfo:There is Nobody around by that name.");
  }
}

static void print_object_location(int num, struct obj_data *obj, struct char_data *ch,
			        int recur)
{
  if (num > 0) {
    send_to_char(ch, "\n%d. %d %s",
    num,
    GET_OBJ_VNUM(obj),
    obj->short_description);
  }

  if (SCRIPT(obj)) {
    if (!TRIGGERS(SCRIPT(obj))->next)
      send_to_char(ch, "[T%d] ", GET_TRIG_VNUM(TRIGGERS(SCRIPT(obj))));
    else
      send_to_char(ch, "[TRIGS] ");
  }

  if (IN_ROOM(obj) != NOWHERE)
    send_to_char(ch, "\n- R %d %s\r", GET_ROOM_VNUM(IN_ROOM(obj)), world[IN_ROOM(obj)].name);
  else if (obj->carried_by)
    send_to_char(ch, "\n- C %s\r", PERS(obj->carried_by, ch));
  else if (obj->worn_by)
    send_to_char(ch, "\n- W %s\r", PERS(obj->worn_by, ch));
  else if (obj->in_obj) {
    send_to_char(ch, "\n- I %s\r", obj->in_obj->short_description);
    if (recur)
      print_object_location(0, obj->in_obj, ch, recur);
  } else
    send_to_char(ch, "in an unknown location");
}

/* Perform a where search if have immortal level
  character data is sent in as *ch
  the char string argument for the deva to search for
*/
static void perform_deva_where(struct char_data *ch, char *arg)
{
  struct char_data *i;
  struct obj_data *k;
  struct descriptor_data *d;
  int num = 0, found = 0;

  // if there is an argument that we start here.
  if (!*arg) {
    for (d = descriptor_list; d; d = d->next)
      if (IS_PLAYING(d)) {
        i = (d->original ? d->original : d->character);
        if (i && CAN_SEE(ch, i) && (IN_ROOM(i) != NOWHERE)) {
          if (d->original) {
            send_to_char(ch, "\nwhere:%s - %d %s in %s\r",
              GET_NAME(i),
              GET_ROOM_VNUM(IN_ROOM(d->character)),
              world[IN_ROOM(d->character)].name,
              GET_NAME(d->character));
          }
          else {
            send_to_char(ch, "\n%s:%s %d:%s %s\r",
              IS_NPC(ch) ? "agent" : "player",
              GET_NAME(i),
              GET_ROOM_VNUM(IN_ROOM(i)),
              world[IN_ROOM(i)].name,
              zone_table[(world[IN_ROOM(i)].zone)].name);
          }
        }
      }
  // if there is no argument passed we go here.
  } else {
    for (i = character_list; i; i = i->next)
      if (CAN_SEE(ch, i) && IN_ROOM(i) != NOWHERE && isname(arg, i->player.name)) {
        found = 1;
        send_to_char(ch, "\n%d. %d:%s > %d:%s\r",
          ++num,
          GET_MOB_VNUM(i),
          GET_NAME(i),
          GET_ROOM_VNUM(IN_ROOM(i)),
          world[IN_ROOM(i)].name
        );
        if (SCRIPT(i) && TRIGGERS(SCRIPT(i))) {
          if (!TRIGGERS(SCRIPT(i))->next)
            send_to_char(ch, " > T%d ", GET_TRIG_VNUM(TRIGGERS(SCRIPT(i))));
          else
            send_to_char(ch, "[TRIGS] ");
        }
      send_to_char(ch, "\r");
      }
    for (num = 0, k = object_list; k; k = k->next)
      if (CAN_SEE_OBJ(ch, k) && isname(arg, k->name)) {
        found = 1;
        print_object_location(++num, k, ch, TRUE);
      }
    if (!found)
      send_to_char(ch, "\nYour search yielded fruitless results.");
  }
}

ACMD(do_where)
{
  char arg[MAX_INPUT_LENGTH];

  one_argument(argument, arg);

  if (GET_LEVEL(ch) >= LVL_IMMORT)
    perform_deva_where(ch, arg);
  else
    perform_mortal_where(ch, arg);
}

ACMD(do_levels)
{
  char buf[MAX_STRING_LENGTH], arg[MAX_STRING_LENGTH];
  size_t len = 0, nlen;
  int i, ret, min_lev=1, max_lev=LVL_IMMORT, val;

  /* COMMENTING THIS OUT BECAUSE IT BLOCKS AGENTS FROM GETTING LEVELS
  if (IS_NPC(ch)) {
    send_to_char(ch, "You ain't nothin' but a hound-dog.\r\n");
    return;
  }
  */

  one_argument(argument, arg);

  if (*arg) {
    if (isdigit(*arg)) {
      ret = sscanf(arg, "%d-%d", &min_lev, &max_lev);
      if (ret == 0) {
        /* No valid args found */
        min_lev = 1;
        max_lev = LVL_IMMORT;
      }
      else if (ret == 1) {
        /* One arg = range is (num) either side of current level */
        val = min_lev;
        max_lev = MIN(GET_LEVEL(ch) + val, LVL_IMMORT);
        min_lev = MAX(GET_LEVEL(ch) - val, 1);
      }
      else if (ret == 2) {
        /* Two args = min-max range limit - just do sanity checks */
        min_lev = MAX(min_lev, 1);
        max_lev = MIN(max_lev + 1, LVL_IMMORT);
      }
    }
    else
    {
      send_to_char(ch, "\nusage: levels [<min>-<max> | <range>]");
      send_to_char(ch, "\nDisplays exp required for levels.");
      send_to_char(ch, "\nlevels: shows all levels (1-%d)", (LVL_IMMORT-1));
      send_to_char(ch, "\nlevels 5 shows 5 levels either side of your current level");
      send_to_char(ch, "\nlevels 10-40 shows level 10 to level 40");
      return;
    }
  }

  for (i = min_lev; i < max_lev; i++) {
    nlen = snprintf(buf + len, sizeof(buf) - len, "[%2d] %8d-%-8d : ", (int)i,
	level_exp(GET_CLASS(ch), i), level_exp(GET_CLASS(ch), i + 1) - 1);
    if (len + nlen >= sizeof(buf))
      break;
    len += nlen;

    switch (GET_GENDER(ch)) {
    case GENDER_MALE:
    case GENDER_NEUTRAL:
      nlen = snprintf(buf + len, sizeof(buf) - len, "\n%s", title_male(GET_CLASS(ch), i));
      break;
    case GENDER_FEMALE:
      nlen = snprintf(buf + len, sizeof(buf) - len, "\n%s", title_female(GET_CLASS(ch), i));
      break;
    default:
      nlen = snprintf(buf + len, sizeof(buf) - len, "\nYou are genderless.");
      break;
    }
    if (len + nlen >= sizeof(buf))
      break;
    len += nlen;
  }

  if (len < sizeof(buf) && max_lev == LVL_IMMORT)
    snprintf(buf + len, sizeof(buf) - len, "\n%d. %d Immoratal\r",
		LVL_IMMORT, level_exp(GET_CLASS(ch), LVL_IMMORT));
  page_string(ch->desc, buf, TRUE);
}

ACMD(do_consider)
{
  char buf[MAX_INPUT_LENGTH];
  struct char_data *victim;
  int diff;

  one_argument(argument, buf);

  if (!(victim = get_char_vis(ch, buf, NULL, FIND_CHAR_ROOM))) {
    send_to_char(ch, "\nConsider who?");
    return;
  }
  if (victim == ch) {
    send_to_char(ch, "\nEasy! Very easy indeed!");
    return;
  }

  if (!IS_NPC(victim)) {
    send_to_char(ch, "\nWould you like some help with that?");
    return;
  }
  diff = (GET_LEVEL(victim) - GET_LEVEL(ch));

  if (diff <= -10)
    send_to_char(ch, "\nNow where did they run off to?");
  else if (diff <= -5)
    send_to_char(ch, "\nYou could do it.");
  else if (diff <= -2)
    send_to_char(ch, "\nAppears Easy.");
  else if (diff <= -1)
    send_to_char(ch, "\nSeems fairly easy.");
  else if (diff == 0)
    send_to_char(ch, "\nThe perfect match!");
  else if (diff <= 1)
    send_to_char(ch, "\nYou might need a bit of luck!");
  else if (diff <= 2)
    send_to_char(ch, "\n\nYou might need a lot of luck!");
  else if (diff <= 3)
    send_to_char(ch, "\nYou might need a lot of luck with great equipment!");
  else if (diff <= 5)
    send_to_char(ch, "\nHow lucky do you really feel?");
  else if (diff <= 10)
    send_to_char(ch, "\nAre you insane to consider something like that.");
  else if (diff <= 100)
    send_to_char(ch, "\nYou are crazy!");
}

ACMD(do_diagnose)
{
  char buf[MAX_INPUT_LENGTH];
  struct char_data *vict;

  one_argument(argument, buf);

  if (*buf) {
    if (!(vict = get_char_vis(ch, buf, NULL, FIND_CHAR_ROOM)))
      send_to_char(ch, "%s", CONFIG_NOPERSON);
    else
      diag_char_to_char(vict, ch);
  } else {
    if (FIGHTING(ch))
      diag_char_to_char(FIGHTING(ch), ch);
    else
      send_to_char(ch, "\nDiagnose who?");
  }
}

ACMD(do_toggle)
{
  char buf2[4], arg[MAX_INPUT_LENGTH], arg2[MAX_INPUT_LENGTH];
  int toggle, tp, wimp_lev, result = 0, len = 0, i;
  const char *types[] = { "off", "brief", "normal", "on", "\n" };

    const struct {
    char *command;
    bitvector_t toggle; /* this needs changing once hashmaps are implemented */
    char min_level;
    char *disable_msg;
    char *enable_msg;
  } tog_messages[] = {
    {"summonable", PRF_SUMMONABLE, 0,
    "\ninfo:Summon is disabled",
    "\ninfo:Summon is enabled"},
    {"nohassle", PRF_NOHASSLE, LVL_IMMORT,
    "\ninfo:Nohassle disabled",
    "\ninfo:Nohassle enabled"},
    {"brief", PRF_BRIEF, 0,
    "\ninfo:Brief mode disabled",
    "\ninfo:Brief mode enabled"},
    {"compact", PRF_COMPACT, 0,
    "\ninfo:Compact mode disabled",
    "\ninfo:Compact mode enabled"},
    {"notell", PRF_NOTELL, 0,
    "\ninfo:Notell is enabled",
    "\ninfo:Tell disabled"},
    {"noauction", PRF_NOAUCT, 0,
    "\ninfo:Auctions enabled",
    "\ninfo:Auctions disabled"},
    {"noshout", PRF_NOSHOUT, 0,
    "\ninfo:Shouts enabled",
    "\ninfo:Shouts disabled"},
    {"nogossip", PRF_NOGOSS, 0,
    "\ninfo:Gossip enabled",
    "\ninfo:Gossip disabled"},
    {"nograts", PRF_NOGRATZ, 0,
    "\ninfo:Gratz enabled",
    "\ninfo:Gratz disabled"},
    {"nowiz", PRF_NOWIZ, LVL_IMMORT,
    "\ninfo:Wiz channel enabled",
    "\ninfo:Wiz channel disabled"},
    {"quest", PRF_QUEST, 0,
    "\ninfo:Quest disabled",
    "\ninfo:Quest enabled"},
    {"showvnums", PRF_SHOWVNUMS, LVL_IMMORT,
    "\ninfo:Show vnums disabled",
    "\ninfoninfo:Show vnums enabled"},
    {"norepeat", PRF_NOREPEAT, 0,
    "\ninfo:Communication repeat enabled",
    "\ninfo:Communication repeat disabled"},
    {"holylight", PRF_HOLYLIGHT, LVL_IMMORT,
    "\ninfo:HolyLight disabled",
    "\ninfo:HolyLight enabled"},
    {"slownameserver", 0, LVL_IMPL,
    "\ninfo:Slow mode disabled (IP addresses are resolved)",
    "\ninfo:Slow mode enabled (IP address NOT resolved)"},
    {"autoexits", PRF_AUTOEXIT, 0,
    "\ninfo:Autoexits disabled",
    "\ninfo:Autoexits enabled"},
    {"trackthru", 0, LVL_IMPL,
    "\ninfo:Track through doors disabled",
    "\ninfo:Track through doors enabled"},
    {"clsolc", PRF_CLS, LVL_BUILDER,
    "\ninfo:OLC clear screen disabled",
    "\ninfo:OLC clear screen enabled"},
    {"buildwalk", PRF_BUILDWALK, LVL_BUILDER,
    "\ninfo:Buildwalk disabled",
    "\ninfo:Buildwalk enabled"},
    {"afk", PRF_AFK, 0,
    "\ninfo:AFK diabled",
    "\ninfo:AFK enabled"},
    {"autoloot", PRF_AUTOLOOT, 0,
    "\ninfo:Autoloot disabled",
    "\ninfo:Autoloot enabled"},
    {"autogold", PRF_AUTOGOLD, 0,
    "\ninfo:Autogold disabled",
    "\ninfo:Autogold enabled"},
    {"autosplit", PRF_AUTOSPLIT, 0,
    "\ninfo:Autosplit disabled",
    "\ninfo:Autosplit enabled"},
    {"autooffer", PRF_AUTOOFFER, 0,
    "\ninfo:Autooffer disabled",
    "\ninfo:Autooffer enabled"},
    {"autoassist", PRF_AUTOASSIST, 0,
    "\ninfo:Autoassist disabled",
    "\ninfo:Autoassist enabled"},
    {"automap", PRF_AUTOMAP, 1,
    "\ninfo:Mini-map disabled",
    "\ninfo:Mini-map enabled"},
    {"autokey", PRF_AUTOKEY, 0,
    "\ninfo:Autokey disabled",
    "\ninfo:Autokey enabled"},
    {"autodoor", PRF_AUTODOOR, 0,
    "\ninfo:Autodoor disabled",
    "\ninfo:Autodoor enabled"},
    {"zoneresets", PRF_ZONERESETS, LVL_IMPL,
    "\ninfo:Zone resets disabled",
    "\ninfo:Zone resets enabled"},
    {"syslog", 0, LVL_IMMORT, "\n", "\n"},
    {"wimpy", 0, 0, "\n", "\n"},
    {"pagelength", 0, 0, "\n", "\n"},
    {"screenwidth", 0, 0, "\n", "\n"},
    {"color", 0, 0, "\n", "\n"},
    {"\n", 0, -1, "\n", "\n"} /* must be last */
  };

  if (IS_NPC(ch))
    return;

  argument = one_argument(argument, arg);
  any_one_arg(argument, arg2); /* so that we don't skip 'on' */

  if (!*arg) {
    if (!GET_WIMP_LEV(ch))
      strcpy(buf2, "OFF");        /* strcpy: OK */
    else
      sprintf(buf2, "%-3.3d", GET_WIMP_LEV(ch));  /* sprintf: OK */

	if (GET_LEVEL(ch) == LVL_IMPL) {
      send_to_char(ch,
        "\ntoggle[slownameserver:%s]:Slow Name Server"
        "\ntoggle[trackthru:%s]:Trackthru Doors",

	ONOFF(CONFIG_NS_IS_SLOW),
	ONOFF(CONFIG_TRACK_T_DOORS));
    }

    if (GET_LEVEL(ch) >= LVL_IMMORT) {
      send_to_char(ch,
        "\ntoggle[buildwalk:%s]:Buildwalk"
        "\ntoggle[nowiz:%s]:Wiz-Channel"
        "\ntoggle[clsolc:%s]:Clear OLC Screen"
        "\ntoggle[nohassle:%s]:No Hassle"
        "\ntoggle[holylight:%s]:Holylight"
        "\ntoggle[showvnums:%s]:Show Room Num."
        "\ntoggle[syslog:%s]: System Log",

        ONOFF(PRF_FLAGGED(ch, PRF_BUILDWALK)),
        ONOFF(PRF_FLAGGED(ch, PRF_NOWIZ)),
        ONOFF(PRF_FLAGGED(ch, PRF_CLS)),
        ONOFF(PRF_FLAGGED(ch, PRF_NOHASSLE)),
        ONOFF(PRF_FLAGGED(ch, PRF_HOLYLIGHT)),
        ONOFF(PRF_FLAGGED(ch, PRF_SHOWVNUMS)),
        types[(PRF_FLAGGED(ch, PRF_LOG1) ? 1 : 0) + (PRF_FLAGGED(ch, PRF_LOG2) ? 2 : 0)]
      );
    }
    if (GET_LEVEL(ch) >= LVL_IMPL) {
      send_to_char(ch, "\ntoggle[zoneresets:%s]:Zone Resets",
        ONOFF(PRF_FLAGGED(ch, PRF_ZONERESETS))
      );
    }

  send_to_char(ch,
    "Hit Pnt Display: %-3s    "
    "          Brief: %-3s    "
    "     Summonable: %-3s\r\n"

    "   Move Display: %-3s    "
    "        Compact: %-3s    "
    "          Quest: %-3s\r\n"

    "   Mana Display: %-3s    "
    "         NoTell: %-3s    "
    "       NoRepeat: %-3s\r\n"

    "      AutoExits: %-3s    "
    "        NoShout: %-3s    "
    "          Wimpy: %-3s\r\n"

    "       NoGossip: %-3s    "
    "      NoAuction: %-3s    "
    "        NoGrats: %-3s\r\n"

    "       AutoLoot: %-3s    "
    "       AutoGold: %-3s    "
    "      AutoSplit: %-3s\r\n"

    "      Autooffer: %-3s    "
    "     AutoAssist: %-3s    "
    "        AutoMap: %-3s\r\n"

    "     Pagelength: %-3d    "
    "    Screenwidth: %-3d    "
    "            AFK: %-3s\r\n"

    "        Autokey: %-3s    "
    "       Autodoor: %-3s    "
    "          Color: %s     \r\n ",

    ONOFF(PRF_FLAGGED(ch, PRF_DISPHP)),
    ONOFF(PRF_FLAGGED(ch, PRF_BRIEF)),
    ONOFF(PRF_FLAGGED(ch, PRF_SUMMONABLE)),

    ONOFF(PRF_FLAGGED(ch, PRF_DISPMOVE)),
    ONOFF(PRF_FLAGGED(ch, PRF_COMPACT)),
    ONOFF(PRF_FLAGGED(ch, PRF_QUEST)),

    ONOFF(PRF_FLAGGED(ch, PRF_DISPMANA)),
    ONOFF(PRF_FLAGGED(ch, PRF_NOTELL)),
    ONOFF(PRF_FLAGGED(ch, PRF_NOREPEAT)),

    ONOFF(PRF_FLAGGED(ch, PRF_AUTOEXIT)),
    ONOFF(PRF_FLAGGED(ch, PRF_NOSHOUT)),
    buf2,

    ONOFF(PRF_FLAGGED(ch, PRF_NOGOSS)),
    ONOFF(PRF_FLAGGED(ch, PRF_NOAUCT)),
    ONOFF(PRF_FLAGGED(ch, PRF_NOGRATZ)),

    ONOFF(PRF_FLAGGED(ch, PRF_AUTOLOOT)),
    ONOFF(PRF_FLAGGED(ch, PRF_AUTOGOLD)),
    ONOFF(PRF_FLAGGED(ch, PRF_AUTOSPLIT)),

    ONOFF(PRF_FLAGGED(ch, PRF_AUTOOFFER)),
    ONOFF(PRF_FLAGGED(ch, PRF_AUTOASSIST)),
    ONOFF(PRF_FLAGGED(ch, PRF_AUTOMAP)),

    GET_PAGE_LENGTH(ch),
    GET_SCREEN_WIDTH(ch),
    ONOFF(PRF_FLAGGED(ch, PRF_AFK)),

    ONOFF(PRF_FLAGGED(ch, PRF_AUTOKEY)),
    ONOFF(PRF_FLAGGED(ch, PRF_AUTODOOR)),
    types[COLOR_LEV(ch)]);
    return;
  }

  len = strlen(arg);
  for (toggle = 0; *tog_messages[toggle].command != '\n'; toggle++)
    if (!strncmp(arg, tog_messages[toggle].command, len))
      break;

  if (*tog_messages[toggle].command == '\n' || tog_messages[toggle].min_level > GET_LEVEL(ch)) {
    send_to_char(ch, "\ninfo:You can't toggle that!");
    return;
  }

  switch (toggle) {
  case SCMD_COLOR:
    if (!*arg2) {
      send_to_char(ch, "\ninfo:Your current color level is %s.", types[COLOR_LEV(ch)]);
      return;
    }

    if (((tp = search_block(arg2, types, FALSE)) == -1)) {
      send_to_char(ch, "\nusage: toggle color { Off | Brief | Normal | On }");
      return;
    }
    REMOVE_BIT_AR(PRF_FLAGS(ch), PRF_COLOR_1);
    REMOVE_BIT_AR(PRF_FLAGS(ch), PRF_COLOR_2);
    if (tp & 1) SET_BIT_AR(PRF_FLAGS(ch), PRF_COLOR_1);
    if (tp & 2) SET_BIT_AR(PRF_FLAGS(ch), PRF_COLOR_2);

    send_to_char(ch, "\nYour %scolor%s is now %s.", CCRED(ch, C_SPR), CCNRM(ch, C_OFF), types[tp]);
    return;
  case SCMD_SYSLOG:
    if (!*arg2) {
      send_to_char(ch, "\nYour syslog is currently %s.",
        types[(PRF_FLAGGED(ch, PRF_LOG1) ? 1 : 0) + (PRF_FLAGGED(ch, PRF_LOG2) ? 2 : 0)]);
      return;
    }
    if (((tp = search_block(arg2, types, FALSE)) == -1)) {
      send_to_char(ch, "\nusage: toggle syslog { Off | Brief | Normal | On }");
      return;
    }
    REMOVE_BIT_AR(PRF_FLAGS(ch), PRF_LOG1);
    REMOVE_BIT_AR(PRF_FLAGS(ch), PRF_LOG2);
    if (tp & 1) SET_BIT_AR(PRF_FLAGS(ch), PRF_LOG1);
    if (tp & 2) SET_BIT_AR(PRF_FLAGS(ch), PRF_LOG2);

    send_to_char(ch, "\nYour syslog is now %s.", types[tp]);
    return;
  case SCMD_SLOWNS:
    result = (CONFIG_NS_IS_SLOW = !CONFIG_NS_IS_SLOW);
    break;
  case SCMD_TRACK:
    result = (CONFIG_TRACK_T_DOORS = !CONFIG_TRACK_T_DOORS);
    break;
  case SCMD_BUILDWALK:
    if (GET_LEVEL(ch) < LVL_BUILDER) {
      send_to_char(ch, "\nBuilders only, sorry.");
      return;
    }
    result = PRF_TOG_CHK(ch, PRF_BUILDWALK);
    if (PRF_FLAGGED(ch, PRF_BUILDWALK)) {
      for (i=0; *arg2 && *(sector_types[i]) != '\n'; i++)
        if (is_abbrev(arg2, sector_types[i]))
          break;
      if (*(sector_types[i]) == '\n')
        i=0;
      GET_BUILDWALK_SECTOR(ch) = i;
      send_to_char(ch, "\nDefault sector type is %s", sector_types[i]);
      mudlog(CMP, GET_LEVEL(ch), TRUE,
             "OLC: %s turned buildwalk on.  Allowed zone %d", GET_NAME(ch), GET_OLC_ZONE(ch));
    } else
      mudlog(CMP, GET_LEVEL(ch), TRUE,
             "OLC: %s turned buildwalk off.  Allowed zone %d", GET_NAME(ch), GET_OLC_ZONE(ch));
    break;
  case SCMD_AFK:
    if ((result = PRF_TOG_CHK(ch, PRF_AFK)))
      act("$n is now away from $s keyboard.", TRUE, ch, 0, 0, TO_ROOM);
    else {
      act("$n has returned to $s keyboard.", TRUE, ch, 0, 0, TO_ROOM);
      if (has_mail(GET_IDNUM(ch)))
        send_to_char(ch, "\nYou have mail waiting.");
    }
    break;
  case SCMD_WIMPY:
    if (!*arg2) {
      if (GET_WIMP_LEV(ch)) {
        send_to_char(ch, "\nYour current wimp level is %d hit points.", GET_WIMP_LEV(ch));
        return;
      } else {
        send_to_char(ch, "\nAt the moment, you're not a wimp.  (sure, sure...)");
        return;
      }
    }
    if (isdigit(*arg2)) {
      if ((wimp_lev = atoi(arg2)) != 0) {
        if (wimp_lev < 0)
          send_to_char(ch, "\nHeh, heh, heh.. we are jolly funny today, eh?");
        else if (wimp_lev > GET_MAX_HIT(ch))
          send_to_char(ch, "\nThat doesn't make much sense, now does it?");
        else if (wimp_lev > (GET_MAX_HIT(ch) / 2))
          send_to_char(ch, "\nYou can't set your wimp level above half your hit points.");
        else {
          send_to_char(ch, "Okay, you'll wimp out if you drop below %d hit points.", wimp_lev);
          GET_WIMP_LEV(ch) = wimp_lev;
        }
      } else {
        send_to_char(ch, "Okay, you'll now tough out fights to the bitter end.");
        GET_WIMP_LEV(ch) = 0;
      }
    } else
      send_to_char(ch, "\nSpecify at how many hit points you want to wimp out at.  (0 to disable)");
    break;
  case SCMD_PAGELENGTH:
    if (!*arg2)
      send_to_char(ch, "\nYour current page length is set to %d lines.", GET_PAGE_LENGTH(ch));
    else if (is_number(arg2)) {
      GET_PAGE_LENGTH(ch) = MIN(MAX(atoi(arg2), 5), 255);
      send_to_char(ch, "\nOkay, your page length is now set to %d lines.", GET_PAGE_LENGTH(ch));
    } else
      send_to_char(ch, "\nPlease specify a number of lines (5 - 255).");
    break;
  case SCMD_SCREENWIDTH:
    if (!*arg2)
      send_to_char(ch, "Your current screen width is set to %d characters.", GET_SCREEN_WIDTH(ch));
    else if (is_number(arg2)) {
      GET_SCREEN_WIDTH(ch) = MIN(MAX(atoi(arg2), 40), 200);
      send_to_char(ch, "Okay, your screen width is now set to %d characters.", GET_SCREEN_WIDTH(ch));
    } else
      send_to_char(ch, "Please specify a number of characters (40 - 200).");
    break;
  case SCMD_AUTOMAP:
    if (can_see_map(ch)) {
      if (!*arg2) {
        TOGGLE_BIT_AR(PRF_FLAGS(ch), tog_messages[toggle].toggle);
        result = (PRF_FLAGGED(ch, tog_messages[toggle].toggle));
      } else if (!strcmp(arg2, "on")) {
        SET_BIT_AR(PRF_FLAGS(ch), tog_messages[toggle].toggle);
        result = 1;
      } else if (!strcmp(arg2, "off")) {
        REMOVE_BIT_AR(PRF_FLAGS(ch), tog_messages[toggle].toggle);
      } else {
        send_to_char(ch, "\nValue for %s must either be 'on' or 'off'.", tog_messages[toggle].command);
        return;
      }
    } else
      send_to_char(ch, "\ninfo:Automap is disabled.");
    break;
  default:
    if (!*arg2) {
      TOGGLE_BIT_AR(PRF_FLAGS(ch), tog_messages[toggle].toggle);
      result = (PRF_FLAGGED(ch, tog_messages[toggle].toggle));
    } else if (!strcmp(arg2, "on")) {
      SET_BIT_AR(PRF_FLAGS(ch), tog_messages[toggle].toggle);
      result = 1;
    } else if (!strcmp(arg2, "off")) {
      REMOVE_BIT_AR(PRF_FLAGS(ch), tog_messages[toggle].toggle);
    } else {
      send_to_char(ch, "\ninfo:Value for %s must either be 'on' or 'off'.", tog_messages[toggle].command);
      return;
    }
  }
  if (result)
    send_to_char(ch, "%s", tog_messages[toggle].enable_msg);
  else
    send_to_char(ch, "%s", tog_messages[toggle].disable_msg);
}

ACMD(do_commands)
{
  int no, i, cmd_num;
  int socials = 0;
  const char *commands[1000];
  int overflow = sizeof(commands) / sizeof(commands[0]);

  if (!ch->desc)
    return;

  if (subcmd == SCMD_SOCIALS)
    socials = 1;

  send_to_char(ch, "\n# %s", socials ? "socials" : "commands");

  /* cmd_num starts at 1, not 0, to remove 'RESERVED' */
  for (no = 0, cmd_num = 1;
       complete_cmd_info[cmd_sort_info[cmd_num]].command[0] != '\n';
       ++cmd_num) {

    i = cmd_sort_info[cmd_num];

    if (complete_cmd_info[i].minimum_level < 0 || GET_LEVEL(ch) < complete_cmd_info[i].minimum_level)

      continue;

    if (complete_cmd_info[i].minimum_level >= LVL_IMMORT)
      continue;

    if (socials != (complete_cmd_info[i].command_pointer == do_action))
      continue;

    if (--overflow < 0)
      continue;

    /* matching command: copy to commands list */
    commands[no++] = complete_cmd_info[i].command;
  }

  /* display commands list in a nice columnized format */
  column_list(ch, 0, commands, no, FALSE);
}

void free_history(struct char_data *ch, int type)
{
  struct txt_block *tmp = GET_HISTORY(ch, type), *ftmp;

  while ((ftmp = tmp)) {
    tmp = tmp->next;
    if (ftmp->text)
      free(ftmp->text);
    free(ftmp);
  }
  GET_HISTORY(ch, type) = NULL;
}

ACMD(do_history)
{
  char arg[MAX_INPUT_LENGTH];
  int type;

  one_argument(argument, arg);

  type = search_block(arg, history_types, FALSE);
  if (!*arg || type < 0) {
    int i;

    send_to_char(ch, "Usage: history <");
    for (i = 0; *history_types[i] != '\n'; i++) {
      send_to_char(ch, " %s ", history_types[i]);
      if (*history_types[i + 1] == '\n')
        send_to_char(ch, "\n>");
      else
        send_to_char(ch, "|");
    }
    return;
  }

  if (GET_HISTORY(ch, type) && GET_HISTORY(ch, type)->text && *GET_HISTORY(ch, type)->text) {
    struct txt_block *tmp;
    for (tmp = GET_HISTORY(ch, type); tmp; tmp = tmp->next)
      send_to_char(ch, "%s", tmp->text);
/* Make this a 1 if you want history to clear after viewing */
#if 0
      free_history(ch, type);
#endif
  } else
    send_to_char(ch, "\ninfo:You have no channel history.");
}

#define HIST_LENGTH 100
void add_history(struct char_data *ch, char *str, int type)
{
  int i = 0;
  char time_str[MAX_STRING_LENGTH], buf[MAX_STRING_LENGTH];
  struct txt_block *tmp;
  time_t ct;

  if (IS_NPC(ch))
    return;

  tmp = GET_HISTORY(ch, type);
  ct = time(0);
  strftime(time_str, sizeof(time_str), "%H:%M ", localtime(&ct));

  sprintf(buf, "%s%s", time_str, str);

  if (!tmp) {
    CREATE(GET_HISTORY(ch, type), struct txt_block, 1);
    GET_HISTORY(ch, type)->text = strdup(buf);
  }
  else {
    while (tmp->next)
      tmp = tmp->next;
    CREATE(tmp->next, struct txt_block, 1);
    tmp->next->text = strdup(buf);

    for (tmp = GET_HISTORY(ch, type); tmp; tmp = tmp->next, i++);

    for (; i > HIST_LENGTH && GET_HISTORY(ch, type); i--) {
      tmp = GET_HISTORY(ch, type);
      GET_HISTORY(ch, type) = tmp->next;
      if (tmp->text)
        free(tmp->text);
      free(tmp);
    }
  }
  /* add this history message to ALL */
  if (type != HIST_ALL)
    add_history(ch, str, HIST_ALL);
}

ACMD(do_whois)
{
  struct char_data *victim = 0;
  int hours;
  int got_from_file = 0;
  char buf[MAX_STRING_LENGTH];

  one_argument(argument, buf);

  if (!*buf) {
    send_to_char(ch, "\ninfo:Whois who?");
    return;
  }

  if (!(victim=get_player_vis(ch, buf, NULL, FIND_CHAR_WORLD)))
  {
     CREATE(victim, struct char_data, 1);
     clear_char(victim);

     new_mobile_data(victim);

     CREATE(victim->player_specials, struct player_special_data, 1);

     if (load_char(buf, victim) > -1)
       got_from_file = 1;
     else {
        send_to_char (ch, "\nThere is no such player.");
        free_char (victim);
        return;
     }
  }

  /* We either have our victim from file or he's playing or function has returned. */
  sprinttype(GET_GENDER(victim), genders, buf, sizeof(buf));
  send_to_char(ch, "name: %s %s\r"
    "\ngender: %s",
    GET_NAME(victim),
    (victim->player.title ? victim->player.title : ""),
    buf
  );

  sprinttype (victim->player.chclass, pc_class_types, buf, sizeof(buf));
  send_to_char(ch, "\nclass: %s", buf);

  send_to_char(ch, "\nlevel: %d", GET_LEVEL(victim));

  if (!(GET_LEVEL(victim) < LVL_IMMORT) || (GET_LEVEL(ch) >= GET_LEVEL(victim))) {
    strftime(buf, sizeof(buf), "%a %b %d %Y", localtime(&(victim->player.time.logon)));

    hours = (time(0) - victim->player.time.logon) / 3600;

    if (!got_from_file) {
      send_to_char(ch, "\ninfo:Last Logon: Playing now!  (Idle %d Minutes)",
           victim->char_specials.timer * SECS_PER_MUD_HOUR / SECS_PER_REAL_MIN);

      if (!victim->desc)
        send_to_char(ch, "  (Linkless)");

      if (PRF_FLAGGED(victim, PRF_AFK))
        send_to_char(ch, "\ninfo:%s%s is afk right now, so %s may not respond to communication.%s", CBGRN(ch, C_NRM), GET_NAME(victim), HSSH(victim), CCNRM(ch, C_NRM));
    }
    else if (hours > 0)
      send_to_char(ch, "\ninfo:Last Logon: %s (%d days & %d hours ago.)", buf, hours/24, hours%24);
    else
      send_to_char(ch, "\ninfo:Last Logon: %s (0 hours & %d minutes ago.)",
                   buf, (int)(time(0) - victim->player.time.logon)/60);
  }

  if (has_mail(GET_IDNUM(victim)))
     act("$E$u has mail waiting.", FALSE, ch, 0, victim, TO_CHAR);
  else
     act("$E$u has no mail waiting.", FALSE, ch, 0, victim, TO_CHAR);

  if (PLR_FLAGGED(victim, PLR_DELETED))
    send_to_char (ch, "\n***DELETED***");

  if (!got_from_file && victim->desc != NULL && GET_LEVEL(ch) >= LVL_DEVA) {
    protocol_t * prot = victim->desc->pProtocol;
    send_to_char(ch, "Client:  %s [%s]\r\n", prot->pVariables[eMSDP_CLIENT_ID]->pValueString, prot->pVariables[eMSDP_CLIENT_VERSION]->pValueString ? prot->pVariables[eMSDP_CLIENT_VERSION]->pValueString : "Unknown");
    send_to_char(ch, "Color:   %s\r\n", prot->pVariables[eMSDP_XTERM_256_COLORS]->ValueInt ? "Xterm" : (prot->pVariables[eMSDP_ANSI_COLORS]->ValueInt ? "Ansi" : "None"));
    send_to_char(ch, "MXP:     %s\r\n", prot->bMXP ? "Yes" : "No");
    send_to_char(ch, "Charset: %s\r\n", prot->bCHARSET ? "Yes" : "No");
    send_to_char(ch, "MSP:     %s\r\n", prot->bMSP ? "Yes" : "No");
    send_to_char(ch, "ATCP:    %s\r\n", prot->bATCP ? "Yes" : "No");
    send_to_char(ch, "MSDP:    %s\r\n", prot->bMSDP ? "Yes" : "No");
  }

  if (got_from_file)
    free_char (victim);
}

static bool get_zone_levels(zone_rnum znum, char *buf)
{
  /* Create a string for the level restrictions for this zone. */
  if ((zone_table[znum].min_level == -1) && (zone_table[znum].max_level == -1)) {
    sprintf(buf, "<Not Set!>");
    return FALSE;
  }

  if (zone_table[znum].min_level == -1) {
    sprintf(buf, "Up to level %d", zone_table[znum].max_level);
    return TRUE;
  }

  if (zone_table[znum].max_level == -1) {
    sprintf(buf, "Above level %d", zone_table[znum].min_level);
    return TRUE;
  }

  sprintf(buf, "Levels %d to %d", zone_table[znum].min_level, zone_table[znum].max_level);
  return TRUE;
}

ACMD(do_areas)
{
  int i, hilev=-1, lolev=-1, zcount=0, lev_set, len=0, tmp_len=0;
  char arg[MAX_INPUT_LENGTH], *second, lev_str[MAX_INPUT_LENGTH], buf[MAX_STRING_LENGTH];
  bool show_zone = FALSE, overlap = FALSE, overlap_shown = FALSE;

  one_argument(argument, arg);

  if (*arg) {
    /* There was an arg typed - check for level range */
    second = strchr(arg, '-');
    if (second) {
      /* Check for 1st value */
      if (second == arg)
        lolev = 0;
      else
        lolev = atoi(arg);

      /* Check for 2nd value */
      if (*(second+1) == '\0' || !isdigit(*(second+1)) )
        hilev = 100;
      else
        hilev = atoi(second+1);

    } else {
      /* No range - single number */
      lolev = atoi(arg);
      hilev = -1;  /* No high level - indicates single level */
    }
  }
  if (hilev != -1 && lolev > hilev) {
    /* Swap hi and lo lev if needed */
    i     = lolev;
    lolev = hilev;
    hilev = i;
  }
  if (hilev != -1)
    len = snprintf(buf, sizeof(buf), "\ninfo:Checking range %d to %d", lolev, hilev);
  else if (lolev != -1)
    len = snprintf(buf, sizeof(buf), "\ninfo:Checking level %d", lolev);
  else
    len = snprintf(buf, sizeof(buf), "\ninfo:Checking all areas.");

  for (i = 0; i <= top_of_zone_table; i++) {    /* Go through the whole zone table */
    show_zone = FALSE;
    overlap = FALSE;

    if (ZONE_FLAGGED(i, ZONE_GRID)) {           /* Is this zone 'on the grid' ?    */
      if (lolev == -1) {
        /* No range supplied, show all zones */
        show_zone = TRUE;
      } else if ((hilev == -1) && (lolev >= ZONE_MINLVL(i)) && (lolev <= ZONE_MAXLVL(i))) {
        /* Single number supplied, it's in this zone's range */
        show_zone = TRUE;
      } else if ((hilev != -1) && (lolev >= ZONE_MINLVL(i)) && (hilev <= ZONE_MAXLVL(i))) {
        /* Range supplied, it's completely within this zone's range (no overlap) */
        show_zone = TRUE;
      } else if ((hilev != -1) && ((lolev >= ZONE_MINLVL(i) && lolev <= ZONE_MAXLVL(i)) || (hilev <= ZONE_MAXLVL(i) && hilev >= ZONE_MINLVL(i)))) {
        /* Range supplied, it overlaps this zone's range */
        show_zone = TRUE;
        overlap = TRUE;
      } else if (ZONE_MAXLVL(i) < 0 && (lolev >= ZONE_MINLVL(i))) {
        /* Max level not set for this zone, but specified min in range */
        show_zone = TRUE;
      } else if (ZONE_MAXLVL(i) < 0 && (hilev >= ZONE_MINLVL(i))) {
        /* Max level not set for this zone, so just display it as red */
        show_zone = TRUE;
        overlap = TRUE;
      }
    }

    if (show_zone) {
      if (overlap) overlap_shown = TRUE;
      lev_set = get_zone_levels(i, lev_str);
      tmp_len = snprintf(buf+len, sizeof(buf)-len, "\tn(%3d) %s%-*s\tn %s%s\tn\r\n", ++zcount, overlap ? QRED : QCYN,
                 count_color_chars(zone_table[i].name)+30, zone_table[i].name,
                 lev_set ? "\tc" : "\tn", lev_set ? lev_str : "All Levels");
      len += tmp_len;
    }
  }
  tmp_len = snprintf(buf+len, sizeof(buf)-len, "%s%d%s area%s found.", QYEL, zcount, QNRM, zcount == 1 ? "" : "s");
  len += tmp_len;

  if (overlap_shown) {
    snprintf(buf+len, sizeof(buf)-len, "Areas shown in \trred\tn may have some creatures outside the specified range.");
  }

  if (zcount == 0)
    send_to_char(ch, "\ninfo:No areas found.");
  else
    page_string(ch->desc, buf, TRUE);
}

static void list_scanned_chars(struct char_data * list, struct char_data * ch, int
distance, int door)
{
  char buf[MAX_STRING_LENGTH], buf2[MAX_STRING_LENGTH - 1];

  const char *how_far[] = {
    "close by",
    "a ways off",
    "far off to the"
  };

  struct char_data *i;
  int count = 0;
  *buf = '\0';

/* this loop is a quick, easy way to help make a grammatical sentence
   (i.e., "You see x, x, y, and z." with commas, "and", etc.) */

  for (i = list; i; i = i->next_in_room)

/* put any other conditions for scanning someone in this if statement -
   i.e., if (CAN_SEE(ch, i) && condition2 && condition3) or whatever */

    if (CAN_SEE(ch, i))
     count++;

  if (!count)
    return;

  for (i = list; i; i = i->next_in_room) {

/* make sure to add changes to the if statement above to this one also, using
   or's to join them.. i.e.,
   if (!CAN_SEE(ch, i) || !condition2 || !condition3) */

    if (!CAN_SEE(ch, i))
      continue;
    if (!*buf)
      snprintf(buf, sizeof(buf), "You see %s", GET_NAME(i));
    else
      strncat(buf, GET_NAME(i), sizeof(buf) - strlen(buf) - 1);
    if (--count > 1)
      strncat(buf, ", ", sizeof(buf) - strlen(buf) - 1);
    else if (count == 1)
      strncat(buf, " and ", sizeof(buf) - strlen(buf) - 1);
    else {
      snprintf(buf2, sizeof(buf2), " %s %s.", how_far[distance], dirs[door]);
      strncat(buf, buf2, sizeof(buf) - strlen(buf) - 1);
    }

  }
  send_to_char(ch, "\ninfo:%s", buf);
}

ACMD(do_scan)
{
  int door;
  bool found=FALSE;

  int range;
  int maxrange = 3;

  room_rnum scanned_room = IN_ROOM(ch);

  if (IS_AFFECTED(ch, AFF_BLIND)) {
    send_to_char(ch, "\ninfo:You can't see a damned thing, you're blind!");
    return;
  }

  for (door = 0; door < DIR_COUNT; door++) {
    for (range = 1; range<= maxrange; range++) {
      if (world[scanned_room].dir_option[door] && world[scanned_room].dir_option[door]->to_room != NOWHERE &&
       !IS_SET(world[scanned_room].dir_option[door]->exit_info, EX_CLOSED) &&
       !IS_SET(world[scanned_room].dir_option[door]->exit_info, EX_HIDDEN)) {
        scanned_room = world[scanned_room].dir_option[door]->to_room;
        if (IS_DARK(scanned_room) && !CAN_SEE_IN_DARK(ch)) {
          if (world[scanned_room].people)
            send_to_char(ch, "\ninfo: %s - It's too dark to see, but you can hear something.", dirs[door]);
          else
            send_to_char(ch, "\ninfo: %s - It is too dark to see.", dirs[door]);
          found=TRUE;
        } else {
          if (world[scanned_room].people) {
            list_scanned_chars(world[scanned_room].people, ch, range - 1, door);
            found=TRUE;
          }
        }
      }                  // end of if
      else
        break;
    }                    // end of range
    scanned_room = IN_ROOM(ch);
  }                      // end of directions
  if (!found) {
    send_to_char(ch, "\ninfo:You don't see anything nearby.");
  }
} // end of do_scan
