/* ***********************************************************************
*    File:   qedit.c                                  Part of CircleMUD  *
* Version:   2.0 (November 2005) Written for CircleMud CWG / Suntzu      *
* Purpose:   To provide special quest-related code.                      *
* Copyright: Kenneth Ray                                                 *
*                                                                        *
* Made for Oasis OLC                                                     *
* Copyright 1996 Harvey Gilpin.                                          *
*********************************************************************** */

#include "conf.h"
#include "sysdep.h"

#include "structs.h"
#include "utils.h"

#include "comm.h"
#include "db.h"
#include "constants.h"
#include "oasis.h"
#include "improved-edit.h"
#include "screen.h"
#include "genolc.h"
#include "genzon.h"
#include "interpreter.h"
#include "modify.h"
#include "quest.h"

/*-------------------------------------------------------------------*/
/*. Function prototypes . */

static void qedit_setup_new(struct descriptor_data *d);
static void qedit_setup_existing(struct descriptor_data *d, qst_rnum rnum);
static void qedit_disp_menu(struct descriptor_data *d);
static void qedit_save_internally(struct descriptor_data *d);
static void qedit_save_to_disk(int num);

/*-------------------------------------------------------------------*/

static void qedit_save_internally(struct descriptor_data *d)
{
  add_quest(OLC_QUEST(d));
}

static void qedit_save_to_disk(int num)
{
  save_quests(num);
}

/*-------------------------------------------------------------------*\
  utility functions
 \*-------------------------------------------------------------------*/

ACMD(do_oasis_qedit)
{
  int number = NOWHERE, save = 0;
  qst_rnum real_num;
  struct descriptor_data *d;
  char buf1[MAX_INPUT_LENGTH];
  char buf2[MAX_INPUT_LENGTH];

  /****************************************************************************/
  /** Parse any arguments.                                                   **/
  /****************************************************************************/
  two_arguments(argument, buf1, buf2);

  if (!*buf1) {
    send_to_char(ch, "\np:Specify a quest VNUM to edit.\r");
    return;
  } else if (!isdigit(*buf1)) {
    if (str_cmp("save", buf1) != 0) {
      send_to_char(ch, "\ninfo: Stop that, someone will get hurt.\r");
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
      send_to_char(ch, "\ninfo:Save which zone?\r");
      return;
    }
  }

  /****************************************************************************/
  /** If a numeric argument was given, get it.                               **/
  /****************************************************************************/
  if (number == NOWHERE)
    number = atoi(buf1);

  if (number < IDXTYPE_MIN || number > IDXTYPE_MAX) {
    send_to_char(ch, "\ninfo:That quest VNUM can't exist.\r");
    return;
  }

  /****************************************************************************/
  /** Check that the quest isn't already being edited.                       **/
  /****************************************************************************/
  for (d = descriptor_list; d; d = d->next) {
    if (STATE(d) == CON_QEDIT) {
      if (d->olc && OLC_NUM(d) == number) {
        send_to_char(ch, "\ninfo:That quest is currently being edited by %s.\r",
          PERS(d->character, ch));
        return;
      }
    }
  }

  /****************************************************************************/
  /** Point d to the builder's descriptor.                                   **/
  /****************************************************************************/
  d = ch->desc;

  /****************************************************************************/
  /** Give the descriptor an OLC structure.                                  **/
  /****************************************************************************/
  if (d->olc) {
    mudlog(BRF, LVL_IMMORT, TRUE,
      "SYSERR: do_oasis_quest: Player already had olc structure.");
    free(d->olc);
  }

  CREATE(d->olc, struct oasis_olc_data, 1);

  /****************************************************************************/
  /** Find the zone.                                                         **/
  /****************************************************************************/
  if ((OLC_ZNUM(d) = real_zone_by_thing(number)) == NOWHERE) {
    send_to_char(ch, "\ninfo:Sorry, there is no zone for that number!\r");
    free(d->olc);
    d->olc = NULL;
    return;
  }

  /****************************************************************************/
  /** Everyone but IMPLs can only edit zones they have been assigned.        **/
  /****************************************************************************/
  if (!can_edit_zone(ch, OLC_ZNUM(d))) {
    send_to_char(ch, "\ninfo:You do not have permission to edit this zone.\r");

    /**************************************************************************/
    /** Free the OLC structure.                                              **/
    /**************************************************************************/
    free(d->olc);
    d->olc = NULL;
    return;
  }

  if (save) {
    send_to_char(ch, "\nsave:Saving all quests in zone %d.\r",
      zone_table[OLC_ZNUM(d)].number);
    mudlog(CMP, MAX(LVL_BUILDER, GET_INVIS_LEV(ch)), TRUE,
      "OLC: %s saves quest info for zone %d.",
      GET_NAME(ch), zone_table[OLC_ZNUM(d)].number);

    /**************************************************************************/
    /** Save the quest to the quest file.                                    **/
    /**************************************************************************/
    qedit_save_to_disk(OLC_ZNUM(d));

    /**************************************************************************/
    /** Free the OLC structure.                                              **/
    /**************************************************************************/
    free(d->olc);
    d->olc = NULL;
    return;
  }

  OLC_NUM(d) = number;

  if ((real_num = real_quest(number)) != NOTHING)
    qedit_setup_existing(d, real_num);
  else
    qedit_setup_new(d);

  STATE(d) = CON_QEDIT;

  act("$n starts using OLC.", TRUE, d->character, 0, 0, TO_ROOM);
  SET_BIT_AR(PLR_FLAGS(ch), PLR_WRITING);

  mudlog(BRF, MAX(LVL_IMMORT, GET_INVIS_LEV(ch)), TRUE,
         "OLC: %s starts editing zone %d allowed zone %d",
         GET_NAME(ch), zone_table[OLC_ZNUM(d)].number, GET_OLC_ZONE(ch));
}

static void qedit_setup_new(struct descriptor_data *d)
{
  struct aq_data *quest;

  /* Allociate some quest shaped space                          */
  CREATE(quest, struct aq_data, 1);
  /* Set default values                                         */
  quest->vnum       = OLC_NUM(d);     /* Quest vnum             */
  quest->qm         = NOBODY;         /* Questmaster rnum       */
  quest->flags      = 0;              /* Quest bitflags         */
  quest->type       = AQ_UNDEFINED;   /* Quest type             */
  quest->target     = NOTHING;        /* Quest target           */
  quest->prereq     = NOTHING;        /* Prerequisite object    */
  quest->value[0]   = 0;              /* Points for completing  */
  quest->value[1]   = 0;              /* Points for abandoning  */
  quest->value[2]   = 0;              /* Minimum level          */
  quest->value[3]   = LVL_IMPL;       /* Maximim level          */
  quest->value[4]   = -1;             /* Time limit             */
  quest->value[5]   = NOBODY;         /* Mob to return object   */
  quest->value[6]   = 1;              /* Quantity of targets    */
  quest->prev_quest = NOTHING;        /* Previous quest         */
  quest->next_quest = NOTHING;        /* Next quest             */
  quest->gold_reward= 0;              /* Prize in gold coins    */
  quest->exp_reward = 0;              /* Prize in exp points    */
  quest->obj_reward = NOTHING;        /* vnum of reward object  */
  quest->name       = strdup("Undefined Quest");
  quest->desc       = strdup("Quest definition is incomplete.");
  quest->info       = strdup("There is no information on this quest.\r\n");
  quest->done       = strdup("You have completed the quest.\r\n");
  quest->quit       = strdup("You have abandoned the quest.\r\n");
  quest->func       = NULL;           /* Secondary qm spec proc */
  /* Set the descriptor OLC structure to point to this quest    */
  OLC_QUEST(d) = quest;
  /* Show the main quest edit menu                              */
  qedit_disp_menu(d);
}

/*-------------------------------------------------------------------*/

static void qedit_setup_existing(struct descriptor_data *d, qst_rnum r_num)
{
  /*. Alloc some quest shaped space . */
  CREATE(OLC_QUEST(d), struct aq_data, 1);
  copy_quest(OLC_QUEST(d), aquest_table + r_num, FALSE);
  qedit_disp_menu(d);
}

/*-------------------------------------------------------------------*/

/**************************************************************************
 Menu functions
**************************************************************************/

/*-------------------------------------------------------------------*/
/*. Display main menu . */

static void qedit_disp_menu(struct descriptor_data *d)
{
  struct aq_data *quest;
  char quest_flags[MAX_STRING_LENGTH], buf2[MAX_STRING_LENGTH];
  char targetname[MAX_STRING_LENGTH];
  mob_vnum return_mob;

  quest = OLC_QUEST(d);

  clear_screen(d);
  sprintbit(quest->flags, aq_flags, quest_flags, sizeof(quest_flags));
  if (quest->type == AQ_OBJ_RETURN) {
    if ((return_mob = real_mobile(quest->value[5])) != NOBODY)
      snprintf(buf2, sizeof(buf2), "to %s [%d]",
        mob_proto[return_mob].player.short_descr,
        quest->value[5]);
    else
      snprintf(buf2, sizeof(buf2), "to an unknown mob [%d].",
               quest->value[5]);
  }
  switch (quest->type) {
    case AQ_OBJ_FIND:
    case AQ_OBJ_RETURN:
      snprintf(targetname, sizeof(targetname), "%s",
               real_object(quest->target) == NOTHING ?
               "An unknown object" :
               obj_proto[real_object(quest->target)].short_description);
      break;
    case AQ_ROOM_FIND:
    case AQ_ROOM_CLEAR:
      snprintf(targetname, sizeof(targetname), "%s",
               real_room(quest->target) == NOWHERE ?
               "An unknown room" :
               world[real_room(quest->target)].name);
      break;
    case AQ_MOB_FIND:
    case AQ_MOB_TACKLE:
    case AQ_MOB_SAVE:
      snprintf(targetname, sizeof(targetname), "%s",
               real_mobile(quest->target) == NOBODY ?
               "An unknown mobile" :
               GET_NAME(&mob_proto[real_mobile(quest->target)]));
      break;
    default:
      snprintf(targetname, sizeof(targetname), "Unknown");
      break;
  }
  write_to_output(d,
    "\n## Quest: %d\r"
    "\nselect[1:name]: %s\r"
    "\nselect[2:desc]: %s\r"
    "\nselect[8:master]: %d %s\r"
    "\nselect[6:flags]: %s\r"
    "\nselect[7:type]: %s %s\r"
    "\nselect[9:target]: %d %s\r"
    "\nselect[A:quantity]: %d\r"
    "\n### Messages\r"
    "\nselect[3:accept]: %s\r"
    "\nselect[4:complete]: %s\r"
    "\nselect[5:quit]: %s\r"
    "\n### Rewards\r"
    "\nselect[B:completed]: %d"
    "\nselect[C:abandoned]: %d\r"
    "\nselect[G:gold coins]: %d\r"
    "\nselect[T:exp points]: %d\r"
    "\nselect[O:object]: %d\r"
    "\n### Limits\r"
    "\nselect[D:lower level]: %d\r"
    "\nselect[E:upper level]: %d\r"
    "\nselect[F:prerequesite]: %d %s\r"
    "\nselect[L:time limit]: %d\r"
    "\n### Flow\r"
    "\nselect[P:prev]: %d %s\r"
    "\nselect[N:next]: %d %s\r"
    "\n::begin:buttons\r"
    "\nbmud[delete quest]:X\r"
    "\n::end:buttons\r"
    "\nmenu[quit]:Q\r",
    quest->vnum,
    quest->name,
    quest->desc,
    quest->qm == NOBODY ? -1 : quest->qm,
    real_mobile(quest->qm) == NOBODY ? "Invalid Mob" : mob_proto[(real_mobile(quest->qm))].player.short_descr,
    quest_flags,
    quest_types[quest->type],
    quest->type == AQ_OBJ_RETURN ? buf2 : "",
    quest->target == NOBODY ? -1 : quest->target,
    targetname,
    quest->value[6],
    quest->info && (str_cmp(quest->info, "undefined")) ? quest->info : "Nothing",
    quest->done && (str_cmp(quest->done, "undefined")) ? quest->done : "Nothing",
    quest->quit && (str_cmp(quest->quit, "undefined")) ? quest->quit : "Nothing",
    quest->value[0],
    quest->value[1],
    quest->gold_reward, quest->exp_reward, quest->obj_reward == NOTHING ? -1 : quest->obj_reward,
    quest->value[2], quest->value[3],
    quest->prereq     == NOTHING ? -1 : quest->prereq,
    quest->prereq     == NOTHING ? "" :
      real_object(quest->prereq) == NOTHING ? "an unknown object" :
                  obj_proto[real_object(quest->prereq)].short_description,
    quest->value[4],
    quest->prev_quest == NOTHING ? -1 : quest->prev_quest,
    real_quest(quest->prev_quest) == NOTHING ? "" : QST_DESC(real_quest(quest->prev_quest)),
    quest->next_quest == NOTHING ? -1 : quest->next_quest,
    real_quest(quest->next_quest) == NOTHING ? "" : QST_DESC(real_quest(quest->next_quest)));
  OLC_MODE(d) = QEDIT_MAIN_MENU;
}
/* For quest type.  */
static void qedit_disp_type_menu(struct descriptor_data *d)
{
  int i, count = 0;
  clear_screen(d);

  write_to_output(d, "\n## Quest Type\r"
    "\n::begin:buttons\r");

  for (i = 0; i < NUM_AQ_TYPES; i++) {
    write_to_output(d, "\nbmud[%s]:%d\r", quest_types[i], ++count);
  }

  write_to_output(d, "\n::end:buttons\r");

  OLC_MODE(d) = QEDIT_TYPES;
}
/* For quest flags.  */
static void qedit_disp_flag_menu(struct descriptor_data *d)
{
  char bits[MAX_STRING_LENGTH];
  int i, count = 0;
  clear_screen(d);

  write_to_output(d,"\n## Quest Flags\r"
    "\n::begin:buttons\r");

  for (i = 0; i < NUM_AQ_FLAGS; i++) {
    write_to_output(d, "\nmenu[%s]:%d\r\n", aq_flags[i], ++count);
  }

  sprintbit(OLC_QUEST(d)->flags, aq_flags, bits, sizeof(bits));

  write_to_output(d, "\n::end:buttons\r"
    "\nflags: %s\r"
    "\nmenu[done]:0\r", bits);

  OLC_MODE(d) = QEDIT_FLAGS;
}
/**************************************************************************
  The GARGANTUAN event handler
**************************************************************************/

void qedit_parse(struct descriptor_data *d, char *arg)
{
  int number = atoi(arg);
  char *oldtext = NULL;

  switch (OLC_MODE(d)) {
    /*-------------------------------------------------------------------*/
    case QEDIT_CONFIRM_SAVESTRING:
      switch (*arg) {
        case 'y':
        case 'Y':
          send_to_char(d->character, "\nsave:Saving Quest to memory.\r");
          qedit_save_internally(d);
          mudlog(CMP, MAX(LVL_BUILDER, GET_INVIS_LEV(d->character)), TRUE,
            "OLC: %s edits quest %d", GET_NAME(d->character), OLC_NUM(d));
          if (CONFIG_OLC_SAVE) {
            qedit_save_to_disk(real_zone_by_thing(OLC_NUM(d)));
            write_to_output(d, "\nsave:Quest %d saved to disk.\r", OLC_NUM(d));
          } else {
            write_to_output(d, "\nsave:Quest %d saved to memory.\r", OLC_NUM(d));
          }
          cleanup_olc(d, CLEANUP_STRUCTS);
          return;
        case 'n':
        case 'N':
          cleanup_olc(d, CLEANUP_ALL);
          return;
        default:
          write_to_output(d, "\ninfo:Invalid choice.");
          write_to_output(d, "%s", confirm_msg);
          return;
      }
    /*-------------------------------------------------------------------*/
    case QEDIT_CONFIRM_DELETE:
      switch (*arg) {
        case 'y':
          if (delete_quest(real_quest(OLC_NUM(d)))) {
            write_to_output(d, "\ninfo:Quest deleted.\r");
          }
          else {
            write_to_output(d, "\ninfo:Unable to delete quest.\r");
          }
          if (CONFIG_OLC_SAVE) {
            qedit_save_to_disk(real_zone_by_thing(OLC_NUM(d)));
            write_to_output(d, "\nsave:Quest file saved to disk.\r");
          }
          else {
            write_to_output(d, "\nsave:Quest file saved to memory.\r");
          }
          cleanup_olc(d, CLEANUP_ALL);
          return;
        case 'n':
          qedit_disp_menu(d);
          return;
        default:
          write_to_output(d, "\ninfo:Invalid choice.");
          write_to_output(d, "%s", confirm_msg);
          return;
      }

    /*-------------------------------------------------------------------*/
    case QEDIT_MAIN_MENU:
      switch (*arg) {
        case 'q':
        case 'Q':
          if (OLC_VAL(d)) {   /*. Anything been changed? . */
            write_to_output(d, "%s", confirm_msg);
            OLC_MODE(d) = QEDIT_CONFIRM_SAVESTRING;
          } else
            cleanup_olc(d, CLEANUP_ALL);
          return;
        case 'x':
        case 'X':
          OLC_MODE(d) = QEDIT_CONFIRM_DELETE;
          write_to_output(d, "\np:Do you wish to delete the Quest?\r"
            "%s", confirm_btn);
          break;
        case '1':
          OLC_MODE(d) = QEDIT_NAME;
          write_to_output(d, "\np:What is the quest name?\r"
            "\ncurrent:%s", OLC_QUEST(d)->name);
          break;
        case '2':
          OLC_MODE(d) = QEDIT_DESC;
          write_to_output(d, "\np:What is the the quest description?\r"
            "\ncurrent:%s\r", OLC_QUEST(d)->desc);
          break;
        case '3':
          OLC_MODE(d) = QEDIT_INFO;
          clear_screen(d);
          write_to_output(d, "\np:What is the quest acceptance message?\r");

          if (OLC_QUEST(d)->info) {
            write_to_output(d, "%s", OLC_QUEST(d)->info);
            oldtext = strdup(OLC_QUEST(d)->info);
          }
          string_write(d, &OLC_QUEST(d)->info, MAX_QUEST_MSG, 0, oldtext);
          OLC_VAL(d) = 1;

          break;
        case '4':
          OLC_MODE(d) = QEDIT_COMPLETE;
          clear_screen(d);
          write_to_output(d, "\np:What is the quest completion message?\r");

          if (OLC_QUEST(d)->done) {
            write_to_output(d, "%s", OLC_QUEST(d)->done);
            oldtext = strdup(OLC_QUEST(d)->done);
          }
          string_write(d, &OLC_QUEST(d)->done, MAX_QUEST_MSG, 0, oldtext);
          OLC_VAL(d) = 1;

          break;
        case '5':
          OLC_MODE(d) = QEDIT_ABANDON;
          clear_screen(d);
          write_to_output(d, "\np:What is the quest quit message:\r");

          if (OLC_QUEST(d)->quit) {
            write_to_output(d, "%s", OLC_QUEST(d)->quit);
            oldtext = strdup(OLC_QUEST(d)->quit);
          }
          string_write(d, &OLC_QUEST(d)->quit, MAX_QUEST_MSG, 0, oldtext);
          OLC_VAL(d) = 1;

          break;
        case '6':
          OLC_MODE(d) = QEDIT_FLAGS;
          qedit_disp_flag_menu(d);
          break;
        case '7':
          OLC_MODE(d) = QEDIT_TYPES;
          qedit_disp_type_menu(d);
          break;
        case '8':
          OLC_MODE(d) = QEDIT_QUESTMASTER;
          write_to_output(d, "\np:What is the vnum of quest master?\r"
            "\ncurrent:%d\r", OLC_QUEST(d)->qm == NOBODY ? -1 : OLC_QUEST(d)->qm);
          break;
        case '9':
          OLC_MODE(d) = QEDIT_TARGET;
          write_to_output(d, "\np:What is the target vnum?\r");
          break;
        case 'a':
        case 'A':
          OLC_MODE(d) = QEDIT_QUANTITY;
          write_to_output(d, "\np:What is the quantity of the target?\r");
          break;
        case 'b':
        case 'B':
          OLC_MODE(d) = QEDIT_POINTSCOMP;
          write_to_output(d, "\np:What are the points for completing the quest?\r" );
          break;
        case 'c':
        case 'C':
          OLC_MODE(d) = QEDIT_POINTSQUIT;
          write_to_output(d, "\np:What are the points for quitting the quest?\r" );
          break;
        case 'd':
        case 'D':
          OLC_MODE(d) = QEDIT_LEVELMIN;
          write_to_output(d, "\np:What is the minimum level to accept the quest? (0-34)\r" );
          break;
        case 'e':
        case 'E':
          OLC_MODE(d) = QEDIT_LEVELMAX;
          write_to_output(d, "\np:What is the maximum level to accept the quest? (0-34)\r" );
          break;
        case 'f':
        case 'F':
          OLC_MODE(d) = QEDIT_PREREQ;
          write_to_output(d, "\np:What is the prerequisite object vnum? (-1 for none)");
          break;
        case 'g':
        case 'G':
          OLC_MODE(d) = QEDIT_GOLD;
          write_to_output(d, "Enter the number of gold coins (0 for none) : ");
          break;
        case 't':
        case 'T':
          OLC_MODE(d) = QEDIT_EXP;
          write_to_output(d, "Enter a number of experience points (0 for none) : ");
          break;
        case 'o':
        case 'O':
          OLC_MODE(d) = QEDIT_OBJ;
          write_to_output(d, "Enter the prize object vnum (-1 for none) : ");
          break;
        case 'l':
        case 'L':
          OLC_MODE(d) = QEDIT_TIMELIMIT;
          write_to_output(d, "Enter time limit to complete (-1 for none) : " );
          break;
        case 'n':
        case 'N':
          OLC_MODE(d) = QEDIT_NEXTQUEST;
          write_to_output(d, "Enter vnum of next quest (-1 for none) : ");
          break;
        case 'p':
        case 'P':
          OLC_MODE(d) = QEDIT_PREVQUEST;
          write_to_output(d, "Enter vnum of previous quest (-1 for none) : ");
          break;
        default:
          write_to_output(d, "\ninfo:Invalid choice!\r");
          qedit_disp_menu(d);
          break;
      }
      return;
    /*-------------------------------------------------------------------*/
    case QEDIT_NAME:
      if (!genolc_checkstring(d, arg))
        break;
      if (OLC_QUEST(d)->name)
        free(OLC_QUEST(d)->name);
      arg[MAX_QUEST_NAME - 1] = '\0';
      OLC_QUEST(d)->name = str_udup(arg);
      break;
    case QEDIT_DESC:
      if (!genolc_checkstring(d, arg))
        break;
      if (OLC_QUEST(d)->desc)
        free(OLC_QUEST(d)->desc);
      arg[MAX_QUEST_DESC - 1] = '\0';
      OLC_QUEST(d)->desc = str_udup(arg);
      break;
    case QEDIT_QUESTMASTER:
      if (number != -1)
        if (real_mobile(number) == NOBODY) {
          write_to_output(d, "\ninfo:That mobile does not exist.\r");
          return;
        }
      OLC_QUEST(d)->qm = number;
      break;
    case QEDIT_TYPES:
      number--;
      if (number < 0 || number >= NUM_AQ_TYPES) {
        write_to_output(d, "\ninfo:Invalid choice!\r");
        qedit_disp_type_menu(d);
        return;
      }
      OLC_QUEST(d)->type = number;
      if (number == AQ_OBJ_RETURN) {
        OLC_MODE(d) = QEDIT_RETURNMOB;
        write_to_output(d, "\np:Enter mob vnum to return object to.");
        return;
      }
      break;
    case QEDIT_FLAGS:
      if (number < 0 || number > NUM_AQ_FLAGS) {
        write_to_output(d, "\ninfo:That is not a valid choice!\r");
        qedit_disp_flag_menu(d);
      } else if (number == 0)
        break;
      else {
        TOGGLE_BIT(OLC_QUEST(d)->flags, number );
        qedit_disp_flag_menu(d);
      }
      return;
    case QEDIT_QUANTITY:
      OLC_QUEST(d)->value[6] = LIMIT(number, 1, 50);
      break;
    case QEDIT_POINTSCOMP:
      OLC_QUEST(d)->value[0] = LIMIT(number, 0, 999999);
      break;
    case QEDIT_POINTSQUIT:
      OLC_QUEST(d)->value[1] = LIMIT(number, 0, 999999);
      break;
    case QEDIT_PREREQ:
      if ((number = atoi(arg)) != -1)
        if (real_object(number) == NOTHING) {
          write_to_output(d, "That object does not exist, try again : ");
          return;
        }
      OLC_QUEST(d)->prereq = number;
      break;
    case QEDIT_LEVELMIN:
      if (number < 0 || number > LVL_IMPL) {
        write_to_output(d, "Level must be between 0 and %d!\r\n", LVL_IMPL);
        write_to_output(d, "Enter minimum level to accept the quest : " );
        return;
      }  else if (number > OLC_QUEST(d)->value[3]) {
        write_to_output(d, "Minimum level can't be above maximum level!\r\n");
        write_to_output(d, "Enter minimum level to accept the quest : " );
        return;
      } else {
        OLC_QUEST(d)->value[2] = number;
        break;
      }
    case QEDIT_LEVELMAX:
      if (number < 0 || number > LVL_IMPL) {
        write_to_output(d, "Level must be between 0 and %d!\r\n", LVL_IMPL);
        write_to_output(d, "Enter maximum level to accept the quest : " );
        return;
      } else if (number < OLC_QUEST(d)->value[2]) {
        write_to_output(d, "Maximum level can't be below minimum level!\r\n");
        write_to_output(d, "Enter maximum level to accept the quest : " );
        return;
      } else {
        OLC_QUEST(d)->value[3] = number;
        break;
      }
    case QEDIT_TIMELIMIT:
      OLC_QUEST(d)->value[4] = LIMIT(number, -1, 100);
      break;
    case QEDIT_RETURNMOB:
      if ((number = atoi(arg)) != -1)
        if (real_mobile(number) == NOBODY) {
          write_to_output(d, "That mobile does not exist, try again : ");
          return;
        }
      OLC_QUEST(d)->value[5] = number;
      break;
    case QEDIT_TARGET:
      OLC_QUEST(d)->target = number;
      break;
    case QEDIT_NEXTQUEST:
      if ((number = atoi(arg)) != -1) {
        if (real_quest(number) == NOTHING) {
          write_to_output(d, "That is not a valid quest, try again (-1 for none) : ");
          return;
        }
      }
      OLC_QUEST(d)->next_quest = (number == -1 ? NOTHING : atoi(arg));
      break;
    case QEDIT_PREVQUEST:
      if ((number = atoi(arg)) != -1) {
        if (real_quest(number) == NOTHING) {
          write_to_output(d, "That is not a valid quest, try again (-1 for none) : ");
          return;
        }
      }
      OLC_QUEST(d)->prev_quest = (number == -1 ? NOTHING : atoi(arg));
      break;
    case QEDIT_GOLD:
      OLC_QUEST(d)->gold_reward = LIMIT(number, 0, 99999);
      break;
    case QEDIT_EXP:
      OLC_QUEST(d)->exp_reward = LIMIT(number, 0, 99999);
      break;
    case QEDIT_OBJ:
      if ((number = atoi(arg)) != -1)
        if (real_object(number) == NOTHING) {
          write_to_output(d, "That object does not exist, try again : ");
          return;
        }
      OLC_QUEST(d)->obj_reward = number;
      break;
    default:
      /*. We should never get here . */
      write_to_output(d, "\nerror:SYSTEM ERROR.\r");
      cleanup_olc(d, CLEANUP_ALL);
      mudlog(BRF, LVL_BUILDER, TRUE, "SYSERR: OLC: qedit_parse(): "
        "Reached default case!");
      break;
  }
  /*-------------------------------------------------------------------*/
  /*. END OF CASE
  If we get here, we have probably changed something, and now want to
  return to main menu.  Use OLC_VAL as a 'has changed' flag . */

  OLC_VAL(d) = 1;
  qedit_disp_menu(d);
}

void qedit_string_cleanup(struct descriptor_data *d, int terminator)
{
  switch (OLC_MODE(d)) {
  case QEDIT_INFO:
  case QEDIT_COMPLETE:
  case QEDIT_ABANDON:
    qedit_disp_menu(d);
    break;
  }
}
