/**************************************************************************
*  File: class.c                                           Part of tbaMUD *
*  Usage: Source file for class-specific code.                            *
*                                                                         *
*  All rights reserved.  See license for complete information.            *
*                                                                         *
*  Copyright (C) 1993, 94 by the Trustees of the Johns Hopkins University *
*  CircleMUD is based on DikuMUD, Copyright (C) 1990, 1991.               *
**************************************************************************/

/* This file attempts to concentrate most of the code which must be changed
 * in order for new classes to be added.  If you're adding a new class, you
 * should go through this entire file from beginning to end and add the
 * appropriate new special cases for your new class. */

#include "conf.h"
#include "sysdep.h"
#include "structs.h"
#include "utils.h"
#include "db.h"
#include "spells.h"
#include "interpreter.h"
#include "constants.h"
#include "act.h"
#include "class.h"

/* Names first */
const char *class_abbrevs[] = {
  "Mo",
  "Ar",
  "Na",
  "Ma",
  "Ai",
  "Sp",
  "Ag",
  "Ng",
  "Cg",
  "Ci",
  "Fb",
  "Ns",
  "Do",
  "Da",
  "Di",
  "Aj",
  "Su",
  "Sa",
  "\n"
};

const char *pc_class_types[] = {
  "Monk",
  "Army",
  "Navy",
  "Marines",
  "AirForce",
  "SpaceForce",
  "AirGuard",
  "NatGuard",
  "CoastGuard",
  "CIA",
  "FBI",
  "NSA",
  "DOD",
  "Deva",
  "Devi",
  "Arjika",
  "Susoma",
  "Saryakiavan",
  "\n"
};

/* The menu for choosing a class in interpreter.c: */
const char *class_menu =
"## Religious\r\n"
"menu[MONK]:a\r\n"
"## Military\r\n"
"menu[ARMY]:b\r\n"
"menu[NAVY]:c\r\n"
"menu[MARINES]:d\r\n"
"menu[AIR FORCE]:e\r\n"
"menu[SPACE FORCE]:f\r\n"
"## Guard\r\n"
"menu[AIR GUARD]:g\r\n"
"menu[NAT GUARD]:h\r\n"
"menu[COAST GUARD]:i\r\n"
"## Federal\r\n"
"menu[CIA]:j\r\n"
"menu[FBI]:k\r\n"
"menu[NSA]:l\r\n"
"menu[DOD]:m\r\n"
"## Vedic\r\n"
"menu[DEVA]:n\r\n"
"menu[DEVI]:o\r\n"
"menu[ARJIKA]:p\r\n"
"menu[SUSOMA]:q\r\n"
"menu[SARYAK]:r\r\n";

/* The code to interpret a class letter -- used in interpreter.c when a new
 * character is selecting a class and by 'set class' in act.wizard.c. */
int parse_class(char arg)
{
  arg = LOWER(arg);

  switch (arg) {
  case 'a': return CLASS_MONK; // MONK
  case 'b': return CLASS_ARMY; // ARMY
  case 'c': return CLASS_NAVY; // NAVY
  case 'd': return CLASS_MARINES; // MARINES
  case 'e': return CLASS_AIRFORCE; // AIR FORCE
  case 'f': return CLASS_SPACEFORCE; // SPACE FORCE
  case 'g': return CLASS_AIRGUARD; // AIR GUARD
  case 'h': return CLASS_NATGUARD; // NATIONAL GUARD
  case 'i': return CLASS_COASTGUARD; // COAST GUARD
  case 'j': return CLASS_CIA; // CIA
  case 'k': return CLASS_FBI; // FBI
  case 'l': return CLASS_NSA; // NSA
  case 'm': return CLASS_DOD; // DOD
  case 'n': return CLASS_DEVA; // DEVA
  case 'o': return CLASS_DEVI; // DEVI
  case 'p': return CLASS_ARJIKA; // ARJIKA
  case 'q': return CLASS_SUSOMA; // SUSOMA
  case 'r': return CLASS_SARYAK; // SARYAKIAVAN
  default:  return CLASS_UNDEFINED;
  }
}

/* bitvectors (i.e., powers of two) for each class, mainly for use in do_who
 * and do_users.  Add new classes at the end so that all classes use sequential
 * powers of two (1 << 0, 1 << 1, 1 << 2, 1 << 3, 1 << 4, 1 << 5, etc.) up to
 * the limit of your bitvector_t, typically 0-31. */
bitvector_t find_class_bitvector(const char *arg)
{
  size_t rpos, ret = 0;

  for (rpos = 0; rpos < strlen(arg); rpos++)
    ret |= (1 << parse_class(arg[rpos]));

  return (ret);
}

/* These are definitions which control the guildmasters for each class.
 * The  first field (top line) controls the highest percentage skill level a
 * character of the class is allowed to attain in any skill.  (After this
 * level, attempts to practice will say "You are already learned in this area."
 *
 * The second line controls the maximum percent gain in learnedness a character
 * is allowed per practice -- in other words, if the random die throw comes out
 * higher than this number, the gain will only be this number instead.
 *
 * The third line controls the minimu percent gain in learnedness a character
 * is allowed per practice -- in other words, if the random die throw comes
 * out below this number, the gain will be set up to this number.
 *
 * The fourth line simply sets whether the character knows 'spells' or 'skills'.
 * This does not affect anything except the message given to the character when
 * trying to practice (i.e. "You know of the following spells" vs. "You know of
 * the following skills" */

#define SPELL	0
#define SKILL	1

/* #define LEARNED_LEVEL	0  % known which is considered "learned" */
/* #define MAX_PER_PRAC		1  max percent gain in skill per practice */
/* #define MIN_PER_PRAC		2  min percent gain in skill per practice */
/* #define PRAC_TYPE		3  should it say 'spell' or 'skill'?	*/

int prac_params[4][NUM_CLASSES] = {
  /* MAG	CLE	THE	WAR */
  { 95,		95,	85,	80	},	/* learned level */
  { 100,	100,	12,	12	},	/* max per practice */
  { 25,		25,	0,	0	},	/* min per practice */
  { SPELL,	SPELL,	SKILL,	SKILL	},	/* prac name */
};

/* The appropriate rooms for each guildmaster/guildguard; controls which types
 * of people the various guildguards let through.  i.e., the first line shows
 * that from room 3017, only MAGIC_USERS are allowed to go south. Don't forget
 * to visit spec_assign.c if you create any new mobiles that should be a guild
 * master or guard so they can act appropriately. If you "recycle" the
 * existing mobs that are used in other guilds for your new guild, then you
 * don't have to change that file, only here. Guildguards are now implemented
 * via triggers. This code remains as an example. */
struct guild_info_type guild_info[] = {

/* Amaravati */
 { CLASS_ARMY, 350, NORTH },
 { CLASS_NAVY, 152, SOUTH },
 { CLASS_AIRFORCE, 336, NORTH },
 { CLASS_MARINES, 166, SOUTH },

/* Brass Dragon */
  { -999 /* all */ ,	5065,	WEST	},

/* this must go last -- add new guards above! */
  { -1, NOWHERE, -1}
};

/* Saving throws for : MCTW : PARA, ROD, PETRI, BREATH, SPELL. Levels 0-40. Do
 * not forget to change extern declaration in magic.c if you add to this. */
byte saving_throws(int class_num, int type, int level)
{
  switch (class_num) {
  case CLASS_ARMY:
    switch (type) {
    case SAVING_PARA:	/* Paralyzation */
      switch (level) {
      case  0: return 90;
      case  1: return 70;
      case  2: return 69;
      case  3: return 68;
      case  4: return 67;
      case  5: return 66;
      case  6: return 65;
      case  7: return 63;
      case  8: return 61;
      case  9: return 60;
      case 10: return 59;
      case 11: return 57;
      case 12: return 55;
      case 13: return 54;
      case 14: return 53;
      case 15: return 53;
      case 16: return 52;
      case 17: return 51;
      case 18: return 50;
      case 19: return 48;
      case 20: return 46;
      case 21: return 45;
      case 22: return 44;
      case 23: return 42;
      case 24: return 40;
      case 25: return 38;
      case 26: return 36;
      case 27: return 34;
      case 28: return 32;
      case 29: return 30;
      case 30: return 28;
      case 31: return  0;
      case 32: return  0;
      case 33: return  0;
      case 34: return  0;
      case 35: return  0;
      case 36: return  0;
      case 37: return  0;
      case 38: return  0;
      case 39: return  0;
      case 40: return  0;
      default:
	log("SYSERR: Missing level for mage paralyzation saving throw.");
	break;
      }
    case SAVING_ROD:	/* Rods */
      switch (level) {
      case  0: return 90;
      case  1: return 55;
      case  2: return 53;
      case  3: return 51;
      case  4: return 49;
      case  5: return 47;
      case  6: return 45;
      case  7: return 43;
      case  8: return 41;
      case  9: return 40;
      case 10: return 39;
      case 11: return 37;
      case 12: return 35;
      case 13: return 33;
      case 14: return 31;
      case 15: return 30;
      case 16: return 29;
      case 17: return 27;
      case 18: return 25;
      case 19: return 23;
      case 20: return 21;
      case 21: return 20;
      case 22: return 19;
      case 23: return 17;
      case 24: return 15;
      case 25: return 14;
      case 26: return 13;
      case 27: return 12;
      case 28: return 11;
      case 29: return 10;
      case 30: return  9;
      case 31: return  0;
      case 32: return  0;
      case 33: return  0;
      case 34: return  0;
      case 35: return  0;
      case 36: return  0;
      case 37: return  0;
      case 38: return  0;
      case 39: return  0;
      case 40: return  0;
      default:
	log("SYSERR: Missing level for mage rod saving throw.");
	break;
      }
    case SAVING_PETRI:	/* Petrification */
      switch (level) {
      case  0: return 90;
      case  1: return 65;
      case  2: return 63;
      case  3: return 61;
      case  4: return 59;
      case  5: return 57;
      case  6: return 55;
      case  7: return 53;
      case  8: return 51;
      case  9: return 50;
      case 10: return 49;
      case 11: return 47;
      case 12: return 45;
      case 13: return 43;
      case 14: return 41;
      case 15: return 40;
      case 16: return 39;
      case 17: return 37;
      case 18: return 35;
      case 19: return 33;
      case 20: return 31;
      case 21: return 30;
      case 22: return 29;
      case 23: return 27;
      case 24: return 25;
      case 25: return 23;
      case 26: return 21;
      case 27: return 19;
      case 28: return 17;
      case 29: return 15;
      case 30: return 13;
      case 31: return  0;
      case 32: return  0;
      case 33: return  0;
      case 34: return  0;
      case 35: return  0;
      case 36: return  0;
      case 37: return  0;
      case 38: return  0;
      case 39: return  0;
      case 40: return  0;
      default:
	log("SYSERR: Missing level for mage petrification saving throw.");
	break;
      }
    case SAVING_BREATH:	/* Breath weapons */
      switch (level) {
      case  0: return 90;
      case  1: return 75;
      case  2: return 73;
      case  3: return 71;
      case  4: return 69;
      case  5: return 67;
      case  6: return 65;
      case  7: return 63;
      case  8: return 61;
      case  9: return 60;
      case 10: return 59;
      case 11: return 57;
      case 12: return 55;
      case 13: return 53;
      case 14: return 51;
      case 15: return 50;
      case 16: return 49;
      case 17: return 47;
      case 18: return 45;
      case 19: return 43;
      case 20: return 41;
      case 21: return 40;
      case 22: return 39;
      case 23: return 37;
      case 24: return 35;
      case 25: return 33;
      case 26: return 31;
      case 27: return 29;
      case 28: return 27;
      case 29: return 25;
      case 30: return 23;
      case 31: return  0;
      case 32: return  0;
      case 33: return  0;
      case 34: return  0;
      case 35: return  0;
      case 36: return  0;
      case 37: return  0;
      case 38: return  0;
      case 39: return  0;
      case 40: return  0;
      default:
	log("SYSERR: Missing level for mage breath saving throw.");
	break;
      }
    case SAVING_SPELL:	/* Generic spells */
      switch (level) {
      case  0: return 90;
      case  1: return 60;
      case  2: return 58;
      case  3: return 56;
      case  4: return 54;
      case  5: return 52;
      case  6: return 50;
      case  7: return 48;
      case  8: return 46;
      case  9: return 45;
      case 10: return 44;
      case 11: return 42;
      case 12: return 40;
      case 13: return 38;
      case 14: return 36;
      case 15: return 35;
      case 16: return 34;
      case 17: return 32;
      case 18: return 30;
      case 19: return 28;
      case 20: return 26;
      case 21: return 25;
      case 22: return 24;
      case 23: return 22;
      case 24: return 20;
      case 25: return 18;
      case 26: return 16;
      case 27: return 14;
      case 28: return 12;
      case 29: return 10;
      case 30: return  8;
      case 31: return  0;
      case 32: return  0;
      case 33: return  0;
      case 34: return  0;
      case 35: return  0;
      case 36: return  0;
      case 37: return  0;
      case 38: return  0;
      case 39: return  0;
      case 40: return  0;
      default:
	log("SYSERR: Missing level for mage spell saving throw.");
	break;
      }
    default:
      log("SYSERR: Invalid saving throw type.");
      break;
    }
    break;
  case CLASS_NAVY:
    switch (type) {
    case SAVING_PARA:	/* Paralyzation */
      switch (level) {
      case  0: return 90;
      case  1: return 60;
      case  2: return 59;
      case  3: return 48;
      case  4: return 46;
      case  5: return 45;
      case  6: return 43;
      case  7: return 40;
      case  8: return 37;
      case  9: return 35;
      case 10: return 34;
      case 11: return 33;
      case 12: return 31;
      case 13: return 30;
      case 14: return 29;
      case 15: return 27;
      case 16: return 26;
      case 17: return 25;
      case 18: return 24;
      case 19: return 23;
      case 20: return 22;
      case 21: return 21;
      case 22: return 20;
      case 23: return 18;
      case 24: return 15;
      case 25: return 14;
      case 26: return 12;
      case 27: return 10;
      case 28: return  9;
      case 29: return  8;
      case 30: return  7;
      case 31: return  0;
      case 32: return  0;
      case 33: return  0;
      case 34: return  0;
      case 35: return  0;
      case 36: return  0;
      case 37: return  0;
      case 38: return  0;
      case 39: return  0;
      case 40: return  0;
      default:
	log("SYSERR: Missing level for monk paralyzation saving throw.");
	break;
      }
    case SAVING_ROD:	/* Rods */
      switch (level) {
      case  0: return 90;
      case  1: return 70;
      case  2: return 69;
      case  3: return 68;
      case  4: return 66;
      case  5: return 65;
      case  6: return 63;
      case  7: return 60;
      case  8: return 57;
      case  9: return 55;
      case 10: return 54;
      case 11: return 53;
      case 12: return 51;
      case 13: return 50;
      case 14: return 49;
      case 15: return 47;
      case 16: return 46;
      case 17: return 45;
      case 18: return 44;
      case 19: return 43;
      case 20: return 42;
      case 21: return 41;
      case 22: return 40;
      case 23: return 38;
      case 24: return 35;
      case 25: return 34;
      case 26: return 32;
      case 27: return 30;
      case 28: return 29;
      case 29: return 28;
      case 30: return 27;
      case 31: return  0;
      case 32: return  0;
      case 33: return  0;
      case 34: return  0;
      case 35: return  0;
      case 36: return  0;
      case 37: return  0;
      case 38: return  0;
      case 39: return  0;
      case 40: return  0;
      default:
	log("SYSERR: Missing level for monk rod saving throw.");
	break;
      }
    case SAVING_PETRI:	/* Petrification */
      switch (level) {
      case  0: return 90;
      case  1: return 65;
      case  2: return 64;
      case  3: return 63;
      case  4: return 61;
      case  5: return 60;
      case  6: return 58;
      case  7: return 55;
      case  8: return 53;
      case  9: return 50;
      case 10: return 49;
      case 11: return 48;
      case 12: return 46;
      case 13: return 45;
      case 14: return 44;
      case 15: return 43;
      case 16: return 41;
      case 17: return 40;
      case 18: return 39;
      case 19: return 38;
      case 20: return 37;
      case 21: return 36;
      case 22: return 35;
      case 23: return 33;
      case 24: return 31;
      case 25: return 29;
      case 26: return 27;
      case 27: return 25;
      case 28: return 24;
      case 29: return 23;
      case 30: return 22;
      case 31: return  0;
      case 32: return  0;
      case 33: return  0;
      case 34: return  0;
      case 35: return  0;
      case 36: return  0;
      case 37: return  0;
      case 38: return  0;
      case 39: return  0;
      case 40: return  0;
      default:
	log("SYSERR: Missing level for monk petrification saving throw.");
	break;
      }
    case SAVING_BREATH:	/* Breath weapons */
      switch (level) {
      case  0: return 90;
      case  1: return 80;
      case  2: return 79;
      case  3: return 78;
      case  4: return 76;
      case  5: return 75;
      case  6: return 73;
      case  7: return 70;
      case  8: return 67;
      case  9: return 65;
      case 10: return 64;
      case 11: return 63;
      case 12: return 61;
      case 13: return 60;
      case 14: return 59;
      case 15: return 57;
      case 16: return 56;
      case 17: return 55;
      case 18: return 54;
      case 19: return 53;
      case 20: return 52;
      case 21: return 51;
      case 22: return 50;
      case 23: return 48;
      case 24: return 45;
      case 25: return 44;
      case 26: return 42;
      case 27: return 40;
      case 28: return 39;
      case 29: return 38;
      case 30: return 37;
      case 31: return  0;
      case 32: return  0;
      case 33: return  0;
      case 34: return  0;
      case 35: return  0;
      case 36: return  0;
      case 37: return  0;
      case 38: return  0;
      case 39: return  0;
      case 40: return  0;
      default:
	log("SYSERR: Missing level for monk breath saving throw.");
	break;
      }
    case SAVING_SPELL:	/* Generic spells */
      switch (level) {
      case  0: return 90;
      case  1: return 75;
      case  2: return 74;
      case  3: return 73;
      case  4: return 71;
      case  5: return 70;
      case  6: return 68;
      case  7: return 65;
      case  8: return 63;
      case  9: return 60;
      case 10: return 59;
      case 11: return 58;
      case 12: return 56;
      case 13: return 55;
      case 14: return 54;
      case 15: return 53;
      case 16: return 51;
      case 17: return 50;
      case 18: return 49;
      case 19: return 48;
      case 20: return 47;
      case 21: return 46;
      case 22: return 45;
      case 23: return 43;
      case 24: return 41;
      case 25: return 39;
      case 26: return 37;
      case 27: return 35;
      case 28: return 34;
      case 29: return 33;
      case 30: return 32;
      case 31: return  0;
      case 32: return  0;
      case 33: return  0;
      case 34: return  0;
      case 35: return  0;
      case 36: return  0;
      case 37: return  0;
      case 38: return  0;
      case 39: return  0;
      case 40: return  0;
      default:
	log("SYSERR: Missing level for monk spell saving throw.");
	break;
      }
    default:
      log("SYSERR: Invalid saving throw type.");
      break;
    }
    break;
  case CLASS_AIRFORCE:
    switch (type) {
    case SAVING_PARA:	/* Paralyzation */
      switch (level) {
      case  0: return 90;
      case  1: return 65;
      case  2: return 64;
      case  3: return 63;
      case  4: return 62;
      case  5: return 61;
      case  6: return 60;
      case  7: return 59;
      case  8: return 58;
      case  9: return 57;
      case 10: return 56;
      case 11: return 55;
      case 12: return 54;
      case 13: return 53;
      case 14: return 52;
      case 15: return 51;
      case 16: return 50;
      case 17: return 49;
      case 18: return 48;
      case 19: return 47;
      case 20: return 46;
      case 21: return 45;
      case 22: return 44;
      case 23: return 43;
      case 24: return 42;
      case 25: return 41;
      case 26: return 40;
      case 27: return 39;
      case 28: return 38;
      case 29: return 37;
      case 30: return 36;
      case 31: return  0;
      case 32: return  0;
      case 33: return  0;
      case 34: return  0;
      case 35: return  0;
      case 36: return  0;
      case 37: return  0;
      case 38: return  0;
      case 39: return  0;
      case 40: return  0;
      default:
	log("SYSERR: Missing level for thief paralyzation saving throw.");
	break;
      }
    case SAVING_ROD:	/* Rods */
      switch (level) {
      case  0: return 90;
      case  1: return 70;
      case  2: return 68;
      case  3: return 66;
      case  4: return 64;
      case  5: return 62;
      case  6: return 60;
      case  7: return 58;
      case  8: return 56;
      case  9: return 54;
      case 10: return 52;
      case 11: return 50;
      case 12: return 48;
      case 13: return 46;
      case 14: return 44;
      case 15: return 42;
      case 16: return 40;
      case 17: return 38;
      case 18: return 36;
      case 19: return 34;
      case 20: return 32;
      case 21: return 30;
      case 22: return 28;
      case 23: return 26;
      case 24: return 24;
      case 25: return 22;
      case 26: return 20;
      case 27: return 18;
      case 28: return 16;
      case 29: return 14;
      case 30: return 13;
      case 31: return  0;
      case 32: return  0;
      case 33: return  0;
      case 34: return  0;
      case 35: return  0;
      case 36: return  0;
      case 37: return  0;
      case 38: return  0;
      case 39: return  0;
      case 40: return  0;
      default:
	log("SYSERR: Missing level for thief rod saving throw.");
	break;
      }
    case SAVING_PETRI:	/* Petrification */
      switch (level) {
      case  0: return 90;
      case  1: return 60;
      case  2: return 59;
      case  3: return 58;
      case  4: return 58;
      case  5: return 56;
      case  6: return 55;
      case  7: return 54;
      case  8: return 53;
      case  9: return 52;
      case 10: return 51;
      case 11: return 50;
      case 12: return 49;
      case 13: return 48;
      case 14: return 47;
      case 15: return 46;
      case 16: return 45;
      case 17: return 44;
      case 18: return 43;
      case 19: return 42;
      case 20: return 41;
      case 21: return 40;
      case 22: return 39;
      case 23: return 38;
      case 24: return 37;
      case 25: return 36;
      case 26: return 35;
      case 27: return 34;
      case 28: return 33;
      case 29: return 32;
      case 30: return 31;
      case 31: return  0;
      case 32: return  0;
      case 33: return  0;
      case 34: return  0;
      case 35: return  0;
      case 36: return  0;
      case 37: return  0;
      case 38: return  0;
      case 39: return  0;
      case 40: return  0;
      default:
	log("SYSERR: Missing level for thief petrification saving throw.");
	break;
      }
    case SAVING_BREATH:	/* Breath weapons */
      switch (level) {
      case  0: return 90;
      case  1: return 80;
      case  2: return 79;
      case  3: return 78;
      case  4: return 77;
      case  5: return 76;
      case  6: return 75;
      case  7: return 74;
      case  8: return 73;
      case  9: return 72;
      case 10: return 71;
      case 11: return 70;
      case 12: return 69;
      case 13: return 68;
      case 14: return 67;
      case 15: return 66;
      case 16: return 65;
      case 17: return 64;
      case 18: return 63;
      case 19: return 62;
      case 20: return 61;
      case 21: return 60;
      case 22: return 59;
      case 23: return 58;
      case 24: return 57;
      case 25: return 56;
      case 26: return 55;
      case 27: return 54;
      case 28: return 53;
      case 29: return 52;
      case 30: return 51;
      case 31: return  0;
      case 32: return  0;
      case 33: return  0;
      case 34: return  0;
      case 35: return  0;
      case 36: return  0;
      case 37: return  0;
      case 38: return  0;
      case 39: return  0;
      case 40: return  0;
      default:
	log("SYSERR: Missing level for thief breath saving throw.");
	break;
      }
    case SAVING_SPELL:	/* Generic spells */
      switch (level) {
      case  0: return 90;
      case  1: return 75;
      case  2: return 73;
      case  3: return 71;
      case  4: return 69;
      case  5: return 67;
      case  6: return 65;
      case  7: return 63;
      case  8: return 61;
      case  9: return 59;
      case 10: return 57;
      case 11: return 55;
      case 12: return 53;
      case 13: return 51;
      case 14: return 49;
      case 15: return 47;
      case 16: return 45;
      case 17: return 43;
      case 18: return 41;
      case 19: return 39;
      case 20: return 37;
      case 21: return 35;
      case 22: return 33;
      case 23: return 31;
      case 24: return 29;
      case 25: return 27;
      case 26: return 25;
      case 27: return 23;
      case 28: return 21;
      case 29: return 19;
      case 30: return 17;
      case 31: return  0;
      case 32: return  0;
      case 33: return  0;
      case 34: return  0;
      case 35: return  0;
      case 36: return  0;
      case 37: return  0;
      case 38: return  0;
      case 39: return  0;
      case 40: return  0;
      default:
	log("SYSERR: Missing level for thief spell saving throw.");
	break;
      }
    default:
      log("SYSERR: Invalid saving throw type.");
      break;
    }
    break;
  case CLASS_MARINES:
    switch (type) {
    case SAVING_PARA:	/* Paralyzation */
      switch (level) {
      case  0: return 90;
      case  1: return 70;
      case  2: return 68;
      case  3: return 67;
      case  4: return 65;
      case  5: return 62;
      case  6: return 58;
      case  7: return 55;
      case  8: return 53;
      case  9: return 52;
      case 10: return 50;
      case 11: return 47;
      case 12: return 43;
      case 13: return 40;
      case 14: return 38;
      case 15: return 37;
      case 16: return 35;
      case 17: return 32;
      case 18: return 28;
      case 19: return 25;
      case 20: return 24;
      case 21: return 23;
      case 22: return 22;
      case 23: return 20;
      case 24: return 19;
      case 25: return 17;
      case 26: return 16;
      case 27: return 15;
      case 28: return 14;
      case 29: return 13;
      case 30: return 12;
      case 31: return 11;
      case 32: return 10;
      case 33: return  9;
      case 34: return  8;
      case 35: return  7;
      case 36: return  6;
      case 37: return  5;
      case 38: return  4;
      case 39: return  3;
      case 40: return  2;
      case 41: return  1;	/* Some mobiles. */
      case 42: return  0;
      case 43: return  0;
      case 44: return  0;
      case 45: return  0;
      case 46: return  0;
      case 47: return  0;
      case 48: return  0;
      case 49: return  0;
      case 50: return  0;
      default:
	log("SYSERR: Missing level for warrior paralyzation saving throw.");
	break;
      }
    case SAVING_ROD:	/* Rods */
      switch (level) {
      case  0: return 90;
      case  1: return 80;
      case  2: return 78;
      case  3: return 77;
      case  4: return 75;
      case  5: return 72;
      case  6: return 68;
      case  7: return 65;
      case  8: return 63;
      case  9: return 62;
      case 10: return 60;
      case 11: return 57;
      case 12: return 53;
      case 13: return 50;
      case 14: return 48;
      case 15: return 47;
      case 16: return 45;
      case 17: return 42;
      case 18: return 38;
      case 19: return 35;
      case 20: return 34;
      case 21: return 33;
      case 22: return 32;
      case 23: return 30;
      case 24: return 29;
      case 25: return 27;
      case 26: return 26;
      case 27: return 25;
      case 28: return 24;
      case 29: return 23;
      case 30: return 22;
      case 31: return 20;
      case 32: return 18;
      case 33: return 16;
      case 34: return 14;
      case 35: return 12;
      case 36: return 10;
      case 37: return  8;
      case 38: return  6;
      case 39: return  5;
      case 40: return  4;
      case 41: return  3;
      case 42: return  2;
      case 43: return  1;
      case 44: return  0;
      case 45: return  0;
      case 46: return  0;
      case 47: return  0;
      case 48: return  0;
      case 49: return  0;
      case 50: return  0;
      default:
	log("SYSERR: Missing level for warrior rod saving throw.");
	break;
      }
    case SAVING_PETRI:	/* Petrification */
      switch (level) {
      case  0: return 90;
      case  1: return 75;
      case  2: return 73;
      case  3: return 72;
      case  4: return 70;
      case  5: return 67;
      case  6: return 63;
      case  7: return 60;
      case  8: return 58;
      case  9: return 57;
      case 10: return 55;
      case 11: return 52;
      case 12: return 48;
      case 13: return 45;
      case 14: return 43;
      case 15: return 42;
      case 16: return 40;
      case 17: return 37;
      case 18: return 33;
      case 19: return 30;
      case 20: return 29;
      case 21: return 28;
      case 22: return 26;
      case 23: return 25;
      case 24: return 24;
      case 25: return 23;
      case 26: return 21;
      case 27: return 20;
      case 28: return 19;
      case 29: return 18;
      case 30: return 17;
      case 31: return 16;
      case 32: return 15;
      case 33: return 14;
      case 34: return 13;
      case 35: return 12;
      case 36: return 11;
      case 37: return 10;
      case 38: return  9;
      case 39: return  8;
      case 40: return  7;
      case 41: return  6;
      case 42: return  5;
      case 43: return  4;
      case 44: return  3;
      case 45: return  2;
      case 46: return  1;
      case 47: return  0;
      case 48: return  0;
      case 49: return  0;
      case 50: return  0;
      default:
	log("SYSERR: Missing level for warrior petrification saving throw.");
	break;
      }
    case SAVING_BREATH:	/* Breath weapons */
      switch (level) {
      case  0: return 90;
      case  1: return 85;
      case  2: return 83;
      case  3: return 82;
      case  4: return 80;
      case  5: return 75;
      case  6: return 70;
      case  7: return 65;
      case  8: return 63;
      case  9: return 62;
      case 10: return 60;
      case 11: return 55;
      case 12: return 50;
      case 13: return 45;
      case 14: return 43;
      case 15: return 42;
      case 16: return 40;
      case 17: return 37;
      case 18: return 33;
      case 19: return 30;
      case 20: return 29;
      case 21: return 28;
      case 22: return 26;
      case 23: return 25;
      case 24: return 24;
      case 25: return 23;
      case 26: return 21;
      case 27: return 20;
      case 28: return 19;
      case 29: return 18;
      case 30: return 17;
      case 31: return 16;
      case 32: return 15;
      case 33: return 14;
      case 34: return 13;
      case 35: return 12;
      case 36: return 11;
      case 37: return 10;
      case 38: return  9;
      case 39: return  8;
      case 40: return  7;
      case 41: return  6;
      case 42: return  5;
      case 43: return  4;
      case 44: return  3;
      case 45: return  2;
      case 46: return  1;
      case 47: return  0;
      case 48: return  0;
      case 49: return  0;
      case 50: return  0;
      default:
	log("SYSERR: Missing level for warrior breath saving throw.");
	break;
      }
    case SAVING_SPELL:	/* Generic spells */
      switch (level) {
      case  0: return 90;
      case  1: return 85;
      case  2: return 83;
      case  3: return 82;
      case  4: return 80;
      case  5: return 77;
      case  6: return 73;
      case  7: return 70;
      case  8: return 68;
      case  9: return 67;
      case 10: return 65;
      case 11: return 62;
      case 12: return 58;
      case 13: return 55;
      case 14: return 53;
      case 15: return 52;
      case 16: return 50;
      case 17: return 47;
      case 18: return 43;
      case 19: return 40;
      case 20: return 39;
      case 21: return 38;
      case 22: return 36;
      case 23: return 35;
      case 24: return 34;
      case 25: return 33;
      case 26: return 31;
      case 27: return 30;
      case 28: return 29;
      case 29: return 28;
      case 30: return 27;
      case 31: return 25;
      case 32: return 23;
      case 33: return 21;
      case 34: return 19;
      case 35: return 17;
      case 36: return 15;
      case 37: return 13;
      case 38: return 11;
      case 39: return  9;
      case 40: return  7;
      case 41: return  6;
      case 42: return  5;
      case 43: return  4;
      case 44: return  3;
      case 45: return  2;
      case 46: return  1;
      case 47: return  0;
      case 48: return  0;
      case 49: return  0;
      case 50: return  0;
      default:
	log("SYSERR: Missing level for warrior spell saving throw.");
	break;
      }
    default:
      log("SYSERR: Invalid saving throw type.");
      break;
    }
  default:
    log("SYSERR: Invalid class saving throw.");
    break;
  }

  /* Should not get here unless something is wrong. */
  return 100;
}

/* THAC0 for classes and levels.  (To Hit Armor Class 0) */
int thaco(int class_num, int level)
{
  switch (class_num) {
  case CLASS_ARMY:
    switch (level) {
    case  0: return 100;
    case  1: return  20;
    case  2: return  20;
    case  3: return  20;
    case  4: return  19;
    case  5: return  19;
    case  6: return  19;
    case  7: return  18;
    case  8: return  18;
    case  9: return  18;
    case 10: return  17;
    case 11: return  17;
    case 12: return  17;
    case 13: return  16;
    case 14: return  16;
    case 15: return  16;
    case 16: return  15;
    case 17: return  15;
    case 18: return  15;
    case 19: return  14;
    case 20: return  14;
    case 21: return  14;
    case 22: return  13;
    case 23: return  13;
    case 24: return  13;
    case 25: return  12;
    case 26: return  12;
    case 27: return  12;
    case 28: return  11;
    case 29: return  11;
    case 30: return  11;
    case 31: return  10;
    case 32: return  10;
    case 33: return  10;
    case 34: return   9;
    default:
      log("SYSERR: Missing level for mage thac0.");
    }
  case CLASS_NAVY:
    switch (level) {
    case  0: return 100;
    case  1: return  20;
    case  2: return  20;
    case  3: return  20;
    case  4: return  18;
    case  5: return  18;
    case  6: return  18;
    case  7: return  16;
    case  8: return  16;
    case  9: return  16;
    case 10: return  14;
    case 11: return  14;
    case 12: return  14;
    case 13: return  12;
    case 14: return  12;
    case 15: return  12;
    case 16: return  10;
    case 17: return  10;
    case 18: return  10;
    case 19: return   8;
    case 20: return   8;
    case 21: return   8;
    case 22: return   6;
    case 23: return   6;
    case 24: return   6;
    case 25: return   4;
    case 26: return   4;
    case 27: return   4;
    case 28: return   2;
    case 29: return   2;
    case 30: return   2;
    case 31: return   1;
    case 32: return   1;
    case 33: return   1;
    case 34: return   1;
    default:
      log("SYSERR: Missing level for monk thac0.");
    }
  case CLASS_AIRFORCE:
    switch (level) {
    case  0: return 100;
    case  1: return  20;
    case  2: return  20;
    case  3: return  19;
    case  4: return  19;
    case  5: return  18;
    case  6: return  18;
    case  7: return  17;
    case  8: return  17;
    case  9: return  16;
    case 10: return  16;
    case 11: return  15;
    case 12: return  15;
    case 13: return  14;
    case 14: return  14;
    case 15: return  13;
    case 16: return  13;
    case 17: return  12;
    case 18: return  12;
    case 19: return  11;
    case 20: return  11;
    case 21: return  10;
    case 22: return  10;
    case 23: return   9;
    case 24: return   9;
    case 25: return   8;
    case 26: return   8;
    case 27: return   7;
    case 28: return   7;
    case 29: return   6;
    case 30: return   6;
    case 31: return   5;
    case 32: return   5;
    case 33: return   4;
    case 34: return   4;
    default:
      log("SYSERR: Missing level for thief thac0.");
    }
  case CLASS_MARINES:
    switch (level) {
    case  0: return 100;
    case  1: return  20;
    case  2: return  19;
    case  3: return  18;
    case  4: return  17;
    case  5: return  16;
    case  6: return  15;
    case  7: return  14;
    case  8: return  14;
    case  9: return  13;
    case 10: return  12;
    case 11: return  11;
    case 12: return  10;
    case 13: return   9;
    case 14: return   8;
    case 15: return   7;
    case 16: return   6;
    case 17: return   5;
    case 18: return   4;
    case 19: return   3;
    case 20: return   2;
    case 21: return   1;
    case 22: return   1;
    case 23: return   1;
    case 24: return   1;
    case 25: return   1;
    case 26: return   1;
    case 27: return   1;
    case 28: return   1;
    case 29: return   1;
    case 30: return   1;
    case 31: return   1;
    case 32: return   1;
    case 33: return   1;
    case 34: return   1;
    default:
      log("SYSERR: Missing level for warrior thac0.");
    }
  default:
    log("SYSERR: Unknown class in thac0 chart.");
  }

  /* Will not get there unless something is wrong. */
  return 100;
}


/* Roll the 6 stats for a character... each stat is made of the sum of the best
 * 3 out of 4 rolls of a 6-sided die.  Each class then decides which priority
 * will be given for the best to worst stats. */
void roll_real_abils(struct char_data *ch)
{
  int i, j, k, temp;
  ubyte table[6];
  ubyte rolls[4];

  for (i = 0; i < 6; i++)
    table[i] = 0;

  for (i = 0; i < 6; i++) {

    for (j = 0; j < 4; j++)
      rolls[j] = rand_number(1, 6);

    temp = rolls[0] + rolls[1] + rolls[2] + rolls[3] -
      MIN(rolls[0], MIN(rolls[1], MIN(rolls[2], rolls[3])));

    for (k = 0; k < 6; k++)
      if (table[k] < temp) {
	temp ^= table[k];
	table[k] ^= temp;
	temp ^= table[k];
      }
  }

  ch->real_abils.str_add = 0;
  ch->real_abils.intel = table[0];
  ch->real_abils.wis = table[1];
  ch->real_abils.dex = table[2];
  ch->real_abils.str = table[3];
  ch->real_abils.con = table[4];
  ch->real_abils.cha = table[5];

  /* this is old abilities tables
  we should look into writing it better.
  i am going to reduece it to one table for all classes until better
  understood
  switch (GET_CLASS(ch)) {
  case CLASS_ARMY:
    ch->real_abils.intel = table[0];
    ch->real_abils.wis = table[1];
    ch->real_abils.dex = table[2];
    ch->real_abils.str = table[3];
    ch->real_abils.con = table[4];
    ch->real_abils.cha = table[5];
    break;
  case CLASS_NAVY:
    ch->real_abils.wis = table[0];
    ch->real_abils.intel = table[1];
    ch->real_abils.str = table[2];
    ch->real_abils.dex = table[3];
    ch->real_abils.con = table[4];
    ch->real_abils.cha = table[5];
    break;
  case CLASS_AIRFORCE:
    ch->real_abils.dex = table[0];
    ch->real_abils.str = table[1];
    ch->real_abils.con = table[2];
    ch->real_abils.intel = table[3];
    ch->real_abils.wis = table[4];
    ch->real_abils.cha = table[5];
    break;
  case CLASS_MARINES:
    ch->real_abils.str = table[0];
    ch->real_abils.dex = table[1];
    ch->real_abils.con = table[2];
    ch->real_abils.wis = table[3];
    ch->real_abils.intel = table[4];
    ch->real_abils.cha = table[5];
    if (ch->real_abils.str == 18)
      ch->real_abils.str_add = rand_number(0, 100);
    break;
  }
  */
  ch->aff_abils = ch->real_abils;
}

/* Some initializations for characters, including initial skills */
void do_start(struct char_data *ch)
{
  GET_LEVEL(ch) = 1;
  GET_EXP(ch) = 1;

  set_title(ch, NULL);
  roll_real_abils(ch);

  GET_MAX_HIT(ch)  = 10;
  GET_MAX_MANA(ch) = 100;
  GET_MAX_MOVE(ch) = 82;

  switch (GET_CLASS(ch)) {

  case CLASS_ARMY:
    break;

  case CLASS_NAVY:
    break;

  case CLASS_AIRFORCE:
    /*
    SET_SKILL(ch, SKILL_SNEAK, 10);
    SET_SKILL(ch, SKILL_HIDE, 5);
    SET_SKILL(ch, SKILL_STEAL, 15);
    SET_SKILL(ch, SKILL_BACKSTAB, 10);
    SET_SKILL(ch, SKILL_PICK_LOCK, 10);
    SET_SKILL(ch, SKILL_TRACK, 10);
    */
    break;

  case CLASS_MARINES:
    break;
  }

  advance_level(ch);

  GET_HIT(ch) = GET_MAX_HIT(ch);
  GET_MANA(ch) = GET_MAX_MANA(ch);
  GET_MOVE(ch) = GET_MAX_MOVE(ch);

  GET_COND(ch, THIRST) = 24;
  GET_COND(ch, HUNGER) = 24;
  GET_COND(ch, DRUNK) = 0;

  if (CONFIG_SITEOK_ALL)
    SET_BIT_AR(PLR_FLAGS(ch), PLR_SITEOK);
}

/* This function controls the change to maxmove, maxmana, and maxhp for each
 * class every time they gain a level. */
void advance_level(struct char_data *ch)
{
  int add_hp, add_mana = 0, add_move = 0, i;

  add_hp = con_app[GET_CON(ch)].hitp;

  add_hp += rand_number(3, 9);
  add_mana = rand_number(GET_LEVEL(ch), (int)(1.5 * GET_LEVEL(ch)));
  add_mana = MIN(add_mana, 10);
  add_move = rand_number(0, 2);

  /*
  switch (GET_CLASS(ch)) {
  case CLASS_ARMY:
    add_hp += rand_number(3, 8);
    add_mana = rand_number(GET_LEVEL(ch), (int)(1.5 * GET_LEVEL(ch)));
    add_mana = MIN(add_mana, 10);
    add_move = rand_number(0, 2);
    break;

  case CLASS_NAVY:
    add_hp += rand_number(5, 10);
    add_mana = rand_number(GET_LEVEL(ch), (int)(1.5 * GET_LEVEL(ch)));
    add_mana = MIN(add_mana, 10);
    add_move = rand_number(0, 2);
    break;

  case CLASS_AIRFORCE:
    add_hp += rand_number(7, 13);
    add_mana = 0;
    add_move = rand_number(1, 3);
    break;

  case CLASS_MARINES:
    add_hp += rand_number(10, 15);
    add_mana = 0;
    add_move = rand_number(1, 3);
    break;
  }
  */

  ch->points.max_hit += MAX(1, add_hp);
  ch->points.max_move += MAX(1, add_move);

  if (GET_LEVEL(ch) > 1)
    ch->points.max_mana += add_mana;

  GET_PRACTICES(ch) += MAX(2, wis_app[GET_WIS(ch)].bonus);

  if (GET_LEVEL(ch) >= LVL_IMMORT) {
    for (i = 0; i < 3; i++)
      GET_COND(ch, i) = (char) -1;
    SET_BIT_AR(PRF_FLAGS(ch), PRF_HOLYLIGHT);
  }

  snoop_check(ch);
  save_char(ch);
}

/* This simply calculates the backstab multiplier based on a character's level.
 * This used to be an array, but was changed to be a function so that it would
 * be easier to add more levels to your MUD.  This doesn't really create a big
 * performance hit because it's not used very often. */
int backstab_mult(int level)
{
  if (level <= 7)
    return 2;	  /* level 1 - 7 */
  else if (level <= 13)
    return 3;	  /* level 8 - 13 */
  else if (level <= 20)
    return 4;	  /* level 14 - 20 */
  else if (level <= 28)
    return 5;	  /* level 21 - 28 */
  else if (level < LVL_IMMORT)
    return 6;	  /* all remaining mortal levels */
  else
    return 20;	  /* immortals */
}

/* invalid_class is used by handler.c to determine if a piece of equipment is
 * usable by a particular class, based on the ITEM_ANTI_{class} bitvectors. */
int invalid_class(struct char_data *ch, struct obj_data *obj)
{
  if (OBJ_FLAGGED(obj, ITEM_ANTI_MAGIC_USER) && IS_ARMY(ch))
    return TRUE;

  if (OBJ_FLAGGED(obj, ITEM_ANTI_MONK) && IS_NAVY(ch))
    return TRUE;

  if (OBJ_FLAGGED(obj, ITEM_ANTI_WARRIOR) && IS_MARINES(ch))
    return TRUE;

  if (OBJ_FLAGGED(obj, ITEM_ANTI_THIEF) && IS_AIRFORCE(ch))
    return TRUE;

  return FALSE;
}

/* SPELLS AND SKILLS.  This area defines which spells are assigned to which
 * classes, and the minimum level the character must be to use the spell or
 * skill. */
void init_spell_levels(void)
{
  /* MAGES */
  spell_level(SPELL_MAGIC_MISSILE, CLASS_ARMY, 1);
  spell_level(SPELL_DETECT_INVIS, CLASS_ARMY, 2);
  spell_level(SPELL_DETECT_MAGIC, CLASS_ARMY, 2);
  spell_level(SPELL_CHILL_TOUCH, CLASS_ARMY, 3);
  spell_level(SPELL_INFRAVISION, CLASS_ARMY, 3);
  spell_level(SPELL_INVISIBLE, CLASS_ARMY, 4);
  spell_level(SPELL_ARMOR, CLASS_ARMY, 4);
  spell_level(SPELL_BURNING_HANDS, CLASS_ARMY, 5);
  spell_level(SPELL_LOCATE_OBJECT, CLASS_ARMY, 6);
  spell_level(SPELL_STRENGTH, CLASS_ARMY, 6);
  spell_level(SPELL_SHOCKING_GRASP, CLASS_ARMY, 7);
  spell_level(SPELL_SLEEP, CLASS_ARMY, 8);
  spell_level(SPELL_LIGHTNING_BOLT, CLASS_ARMY, 9);
  spell_level(SPELL_BLINDNESS, CLASS_ARMY, 9);
  spell_level(SPELL_DETECT_POISON, CLASS_ARMY, 10);
  spell_level(SPELL_COLOR_SPRAY, CLASS_ARMY, 11);
  spell_level(SPELL_ENERGY_DRAIN, CLASS_ARMY, 13);
  spell_level(SPELL_CURSE, CLASS_ARMY, 14);
  spell_level(SPELL_POISON, CLASS_ARMY, 14);
  spell_level(SPELL_FIREBALL, CLASS_ARMY, 15);
  spell_level(SPELL_CHARM, CLASS_ARMY, 16);
  spell_level(SPELL_IDENTIFY, CLASS_ARMY, 20);
  spell_level(SPELL_FLY, CLASS_ARMY, 22);
  spell_level(SPELL_ENCHANT_WEAPON, CLASS_ARMY, 26);
  spell_level(SPELL_CLONE, CLASS_ARMY, 30);

  /* MONKS */
  spell_level(SPELL_CURE_LIGHT, CLASS_NAVY, 1);
  spell_level(SPELL_ARMOR, CLASS_NAVY, 1);
  spell_level(SPELL_CREATE_FOOD, CLASS_NAVY, 2);
  spell_level(SPELL_CREATE_WATER, CLASS_NAVY, 2);
  spell_level(SPELL_DETECT_POISON, CLASS_NAVY, 3);
  spell_level(SPELL_DETECT_ALIGN, CLASS_NAVY, 4);
  spell_level(SPELL_CURE_BLIND, CLASS_NAVY, 4);
  spell_level(SPELL_BLESS, CLASS_NAVY, 5);
  spell_level(SPELL_DETECT_INVIS, CLASS_NAVY, 6);
  spell_level(SPELL_BLINDNESS, CLASS_NAVY, 6);
  spell_level(SPELL_INFRAVISION, CLASS_NAVY, 7);
  spell_level(SPELL_PROT_FROM_EVIL, CLASS_NAVY, 8);
  spell_level(SPELL_POISON, CLASS_NAVY, 8);
  spell_level(SPELL_GROUP_ARMOR, CLASS_NAVY, 9);
  spell_level(SPELL_CURE_CRITIC, CLASS_NAVY, 9);
  spell_level(SPELL_SUMMON, CLASS_NAVY, 10);
  spell_level(SPELL_REMOVE_POISON, CLASS_NAVY, 10);
  spell_level(SPELL_IDENTIFY, CLASS_NAVY, 11);
  spell_level(SPELL_WORD_OF_RECALL, CLASS_NAVY, 12);
  spell_level(SPELL_DARKNESS, CLASS_NAVY, 12);
  spell_level(SPELL_EARTHQUAKE, CLASS_NAVY, 12);
  spell_level(SPELL_DISPEL_EVIL, CLASS_NAVY, 14);
  spell_level(SPELL_DISPEL_GOOD, CLASS_NAVY, 14);
  spell_level(SPELL_SANCTUARY, CLASS_NAVY, 15);
  spell_level(SPELL_CALL_LIGHTNING, CLASS_NAVY, 15);
  spell_level(SPELL_HEAL, CLASS_NAVY, 16);
  spell_level(SPELL_CONTROL_WEATHER, CLASS_NAVY, 17);
  spell_level(SPELL_SENSE_LIFE, CLASS_NAVY, 18);
  spell_level(SPELL_HARM, CLASS_NAVY, 19);
  spell_level(SPELL_GROUP_HEAL, CLASS_NAVY, 22);
  spell_level(SPELL_REMOVE_CURSE, CLASS_NAVY, 26);

  /* THIEVES */
  spell_level(SKILL_SNEAK, CLASS_AIRFORCE, 1);
  spell_level(SKILL_PICK_LOCK, CLASS_AIRFORCE, 2);
  spell_level(SKILL_BACKSTAB, CLASS_AIRFORCE, 3);
  spell_level(SKILL_STEAL, CLASS_AIRFORCE, 4);
  spell_level(SKILL_HIDE, CLASS_AIRFORCE, 5);
  spell_level(SKILL_TRACK, CLASS_AIRFORCE, 6);

  /* WARRIORS */
  spell_level(SKILL_KICK, CLASS_MARINES, 1);
  spell_level(SKILL_RESCUE, CLASS_MARINES, 3);
  spell_level(SKILL_BANDAGE, CLASS_MARINES, 7);
  spell_level(SKILL_TRACK, CLASS_MARINES, 9);
  spell_level(SKILL_BASH, CLASS_MARINES, 12);
  spell_level(SKILL_WHIRLWIND, CLASS_MARINES, 16);
}

/* This is the exp given to implementors -- it must always be greater than the
 * exp required for immortality, plus at least 20,000 or so. */
#define EXP_MAX  10000000

/* Function to return the exp required for each class/level */
int level_exp(int chclass, int level)
{
  if (level > LVL_IMPL || level < 0) {
    log("SYSERR: Requesting exp for invalid level %d!", level);
    return 0;
  }

  /* Devas have exp close to EXP_MAX.  This statement should never have to
   * changed, regardless of how many mortal or immortal levels exist. */
   if (level > LVL_IMMORT) {
     return EXP_MAX - ((LVL_IMPL - level) * 1000);
   }

  /* Exp required for normal mortals is below */
  switch (level) {
    case  0: return 0;
    case  1: return 1;
    case  2: return 2500;
    case  3: return 5000;
    case  4: return 10000;
    case  5: return 20000;
    case  6: return 40000;
    case  7: return 60000;
    case  8: return 90000;
    case  9: return 135000;
    case 10: return 250000;
    case 11: return 375000;
    case 12: return 750000;
    case 13: return 1125000;
    case 14: return 1500000;
    case 15: return 1875000;
    case 16: return 2250000;
    case 17: return 2625000;
    case 18: return 3000000;
    case 19: return 3375000;
    case 20: return 3750000;
    case 21: return 4000000;
    case 22: return 4300000;
    case 23: return 4600000;
    case 24: return 4900000;
    case 25: return 5200000;
    case 26: return 5500000;
    case 27: return 5950000;
    case 28: return 6400000;
    case 29: return 6850000;
    case 30: return 7400000;
    /* add new levels here */
    case LVL_IMMORT: return 8000000;
  }

  /* This statement should never be reached if the exp tables in this function
   * are set up properly.  If you see exp of 123456 then the tables above are
   * incomplete. */
  log("SYSERR: XP tables not set up correctly in class.c!");
  return 123456;
}

/* Default titles of male characters. */
const char *title_male(int chclass, int level)
{
  if (level <= 0 || level > LVL_IMPL) {
    return "M";
  }
  if (level == LVL_IMPL) {
    return "DEV";
  }

  switch (level) {
    case  1: return "E0";
    case  2: return "E1";
    case  3: return "E2";
    case  4: return "E3";
    case  5: return "E4";
    case  6: return "E5";
    case  7: return "E6";
    case  8: return "E7";
    case  9: return "E8";
    case 10: return "E9";
    case 11: return "E10";
    case 12: return "E11";
    case 13: return "E12";
    case 14: return "W1";
    case 15: return "W2";
    case 16: return "W3";
    case 17: return "W4";
    case 18: return "W5";
    case 19: return "O1";
    case 20: return "O2";
    case 21: return "O3";
    case 22: return "O4";
    case 23: return "O5";
    case 24: return "O6";
    case 25: return "O7";
    case 26: return "O8";
    case 27: return "O9";
    case 28: return "O10";
    case 29: return "Q1";
    case 30: return "Q2";
    /*
    case LVL_IMMORT: return "Army Intel";
    case LVL_DEVA: return "Army SpecOps";
    case LVL_GRDEVA: return "Army BlackOps";
    */
    default: return "CIV";
  }
  /* Default title for classes which do not have titles defined */
  return "CIV";
}

/* Default titles of female characters. */
const char *title_female(int chclass, int level)
{
  if (level <= 0 || level > LVL_IMPL) {
    return "F";
  }
  if (level == LVL_IMPL) {
    return "DEV";
  }

    switch (level) {
      case  1: return "E0";
      case  2: return "E1";
      case  3: return "E2";
      case  4: return "E3";
      case  5: return "E4";
      case  6: return "E5";
      case  7: return "E6";
      case  8: return "E7";
      case  9: return "E8";
      case 10: return "E9";
      case 11: return "E10";
      case 12: return "E11";
      case 13: return "E12";
      case 14: return "W1";
      case 15: return "W2";
      case 16: return "W3";
      case 17: return "W4";
      case 18: return "W5";
      case 19: return "O1";
      case 20: return "O2";
      case 21: return "O3";
      case 22: return "O4";
      case 23: return "O5";
      case 24: return "O6";
      case 25: return "O7";
      case 26: return "O8";
      case 27: return "O9";
      case 28: return "O10";
      case 29: return "Q1";
      case 30: return "Q2";
      /*
      case LVL_IMMORT: return "Army Intel";
      case LVL_DEVA: return "Army SpecOps";
      case LVL_GRDEVA: return "Army BlackOps";
      */
      default: return "CIV";
    }

  /* Default title for classes which do not have titles defined */
  return "CIV";
}
