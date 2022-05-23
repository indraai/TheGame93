/**************************************************************************
*  File: sedit.c                                           Part of tbaMUD *
*  Usage: Oasis OLC - Shops.                                              *
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
#include "shop.h"
#include "genolc.h"
#include "genshp.h"
#include "genzon.h"
#include "oasis.h"
#include "constants.h"
#include "shop.h"

/* local functions */
static void sedit_setup_new(struct descriptor_data *d);
static void sedit_save_to_disk(int zone_num);
static void sedit_products_menu(struct descriptor_data *d);
static void sedit_compact_rooms_menu(struct descriptor_data *d);
static void sedit_rooms_menu(struct descriptor_data *d);
static void sedit_namelist_menu(struct descriptor_data *d);
static void sedit_shop_flags_menu(struct descriptor_data *d);
static void sedit_no_trade_menu(struct descriptor_data *d);
static void sedit_types_menu(struct descriptor_data *d);
static void sedit_disp_menu(struct descriptor_data *d);


void sedit_save_internally(struct descriptor_data *d)
{
  OLC_SHOP(d)->vnum = OLC_NUM(d);
  add_shop(OLC_SHOP(d));
}

static void sedit_save_to_disk(int num)
{
  save_shops(num);
}

/* utility functions */
ACMD(do_oasis_sedit)
{
  int number = NOWHERE, save = 0;
  shop_rnum real_num;
  struct descriptor_data *d;
  char buf1[MAX_INPUT_LENGTH];
  char buf2[MAX_INPUT_LENGTH];

  /* No building as a mob or while being forced. */
  if (IS_NPC(ch) || !ch->desc || STATE(ch->desc) != CON_PLAYING)
    return;

  /* Parse any arguments. */
  two_arguments(argument, buf1, buf2);

  if (!*buf1) {
    send_to_char(ch, "\ninfo:Specify a shop VNUM to edit.\r");
    return;
  } else if (!isdigit(*buf1)) {
    if (str_cmp("save", buf1) != 0) {
      send_to_char(ch, "\nalert:Yikes!  Stop that, someone will get hurt!\r");
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

  /* If a numeric argument was given, get it. */
  if (number == NOWHERE)
    number = atoi(buf1);

  if (number < IDXTYPE_MIN || number > IDXTYPE_MAX) {
    send_to_char(ch, "\ninfo:That shop VNUM can't exist.\r");
    return;
  }

  /* Check that the shop isn't already being edited. */
  for (d = descriptor_list; d; d = d->next) {
    if (STATE(d) == CON_SEDIT) {
      if (d->olc && OLC_NUM(d) == number) {
        send_to_char(ch, "\ninfo:That shop is currently being edited by %s.\r",
          PERS(d->character, ch));
        return;
      }
    }
  }

  /* Point d to the builder's descriptor. */
  d = ch->desc;

  /* Give the descriptor an OLC structure. */
  if (d->olc) {
    mudlog(BRF, LVL_IMMORT, TRUE,
      "SYSERR: do_oasis_sedit: Player already had olc structure.");
    free(d->olc);
  }

  CREATE(d->olc, struct oasis_olc_data, 1);

  /* Find the zone. */
  OLC_ZNUM(d) = save ? real_zone(number) : real_zone_by_thing(number);
  if (OLC_ZNUM(d) == NOWHERE) {
    send_to_char(ch, "\ninfo:Sorry, there is no zone for that number!\r");
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

  if (save) {
    send_to_char(ch, "\nsave:Saving all shops in zone %d.\r",
      zone_table[OLC_ZNUM(d)].number);
    mudlog(CMP, MAX(LVL_BUILDER, GET_INVIS_LEV(ch)), TRUE,
      "OLC: %s saves shop info for zone %d.",
      GET_NAME(ch), zone_table[OLC_ZNUM(d)].number);

    /* Save the shops to the shop file. */
    save_shops(OLC_ZNUM(d));

    /* Free the OLC structure. */
    free(d->olc);
    d->olc = NULL;
    return;
  }

  OLC_NUM(d) = number;

  if ((real_num = real_shop(number)) != NOTHING)
    sedit_setup_existing(d, real_num);
  else
    sedit_setup_new(d);

  sedit_disp_menu(d);
  STATE(d) = CON_SEDIT;

  act("$n starts using OLC.", TRUE, d->character, 0, 0, TO_ROOM);
  SET_BIT_AR(PLR_FLAGS(ch), PLR_WRITING);

  mudlog(CMP, MAX(LVL_IMMORT, GET_INVIS_LEV(ch)), TRUE, "OLC: %s starts editing zone %d allowed zone %d",
    GET_NAME(ch), zone_table[OLC_ZNUM(d)].number, GET_OLC_ZONE(ch));
}

static void sedit_setup_new(struct descriptor_data *d)
{
  struct shop_data *shop;

  /* Allocate a scratch shop structure. */
  CREATE(shop, struct shop_data, 1);

  /* Fill in some default values. */
  S_KEEPER(shop) = NOBODY;
  S_CLOSE1(shop) = 28;
  S_BUYPROFIT(shop) = 1.0;
  S_SELLPROFIT(shop) = 1.0;
  S_NOTRADE(shop) = 0;
  /* Add a spice of default strings. */
  S_NOITEM1(shop) = strdup("%s Sorry, I don't stock that item.");
  S_NOITEM2(shop) = strdup("%s You don't seem to have that.");
  S_NOCASH1(shop) = strdup("%s I can't afford that!");
  S_NOCASH2(shop) = strdup("%s You are too poor!");
  S_NOBUY(shop) = strdup("%s I don't trade in such items.");
  S_BUY(shop) = strdup("%s That'll be %d coins, thanks.");
  S_SELL(shop) = strdup("%s I'll give you %d coins for that.");
  /* Stir the lists lightly. */
  CREATE(S_PRODUCTS(shop), obj_vnum, 1);

  S_PRODUCT(shop, 0) = NOTHING;
  CREATE(S_ROOMS(shop), room_rnum, 1);

  S_ROOM(shop, 0) = NOWHERE;
  CREATE(S_NAMELISTS(shop), struct shop_buy_data, 1);

  S_BUYTYPE(shop, 0) = NOTHING;

   /* Presto! A shop. */
  OLC_SHOP(d) = shop;
}

void sedit_setup_existing(struct descriptor_data *d, int rshop_num)
{
  /* Create a scratch shop structure. */
  CREATE(OLC_SHOP(d), struct shop_data, 1);

  /* don't waste time trying to free NULL strings -- Welcor */
  copy_shop(OLC_SHOP(d), shop_index + rshop_num, FALSE);
}

/* Menu functions */
static void sedit_products_menu(struct descriptor_data *d)
{
  struct shop_data *shop;
  int i;

  shop = OLC_SHOP(d);
  get_char_colors(d->character);

  clear_screen(d);
  write_to_output(d, "\n## Products\r");
  for (i = 0; S_PRODUCT(shop, i) != NOTHING; i++) {
    write_to_output(d, "\n%d. %s\r",
	    obj_index[S_PRODUCT(shop, i)].vnum,
	    obj_proto[S_PRODUCT(shop, i)].short_description);
  }
  write_to_output(d, "\nmenu[add product]:a\r"
	  "\nmenu[delete product]:b\r"
	  "\nmenu[done]:0\r"
  );

  OLC_MODE(d) = SEDIT_PRODUCTS_MENU;
}

static void sedit_compact_rooms_menu(struct descriptor_data *d)
{
  struct shop_data *shop;
  int i;

  shop = OLC_SHOP(d);
  get_char_colors(d->character);

  clear_screen(d);
  for (i = 0; S_ROOM(shop, i) != NOWHERE; i++) {
    if (real_room(S_ROOM(shop, i)) != NOWHERE) {
      write_to_output(d, "%2d - [@\t%5d\tn] - \ty%s\tn\r\n", i, S_ROOM(shop, i), world[real_room(S_ROOM(shop, i))].name);
    } else {
      write_to_output(d, "%2d - [\tR!Removed Room!\tn]\r\n", i);
    }
  }
  write_to_output(d, "\nmenu[Add Room]:a\r"
	  "\nmenu[Delete Room]:b\r"
	  "\nmenu[Long Display]:d\r"
	  "\nmenu[Quit]:0\r");

  OLC_MODE(d) = SEDIT_ROOMS_MENU;
}

static void sedit_rooms_menu(struct descriptor_data *d)
{
  struct shop_data *shop;
  int i;
  room_rnum rnum;

  shop = OLC_SHOP(d);
  get_char_colors(d->character);

  clear_screen(d);
  write_to_output(d, "\n## Rooms\r");
  for (i = 0; S_ROOM(shop, i) != NOWHERE; i++) {
    rnum = real_room(S_ROOM(shop, i));
    /* if the room has been deleted, this may crash us otherwise. */
    /* set to 0 to be deletable.   -- Welcor 09/04                */
    if (rnum == NOWHERE)
      S_ROOM(shop, i) = rnum = 0;

    write_to_output(d, "%2d - [%s%5d%s] - %s%s%s\r\n", i, cyn, S_ROOM(shop, i), nrm,
	    yel, world[rnum].name, nrm);
  }
  write_to_output(d, "\nmenu[Add Store Room]:a\r"
	  "\nmenu[Delete Store Room]:b\r"
	  "\nmenu[Compact Dispaly]:c\r"
	  "\rmenu[done]:0\r");

  OLC_MODE(d) = SEDIT_ROOMS_MENU;
}

static void sedit_namelist_menu(struct descriptor_data *d)
{
  struct shop_data *shop;
  int i;

  shop = OLC_SHOP(d);
  get_char_colors(d->character);

  clear_screen(d);
  write_to_output(d, "\n## Types\r");
  for (i = 0; S_BUYTYPE(shop, i) != NOTHING; i++) {
    write_to_output(d, "\n%d. %s - %s\r", i,
    item_types[S_BUYTYPE(shop, i)],
    S_BUYWORD(shop, i) ? S_BUYWORD(shop, i) : "<None>");
  }
  write_to_output(d, "\r\n"
	  "\nmenu[Add New Entry]:A\r"
	  "\nmenu[Delete Entry]:D\r"
	  "\nmenu[done]:0\r");

  OLC_MODE(d) = SEDIT_NAMELIST_MENU;
}

static void sedit_shop_flags_menu(struct descriptor_data *d)
{
  char bits[MAX_STRING_LENGTH];
  int i, count = 0;

  get_char_colors(d->character);
  clear_screen(d);
  for (i = 0; i < NUM_SHOP_FLAGS; i++) {
    write_to_output(d, "%s%2d%s) %-20.20s   %s", grn, i + 1, nrm, shop_bits[i],
		!(++count % 2) ? "\r\n" : "");
  }
  sprintbit(S_BITVECTOR(OLC_SHOP(d)), shop_bits, bits, sizeof(bits));
  write_to_output(d, "\r\nCurrent Shop Flags : %s%s%s\r\nEnter choice : ",
		cyn, bits, nrm);
  OLC_MODE(d) = SEDIT_SHOP_FLAGS;
}

static void sedit_no_trade_menu(struct descriptor_data *d)
{
  char bits[MAX_STRING_LENGTH];
  int i, count = 0;

  clear_screen(d);

  for (i = 0; i < NUM_TRADERS; i++) {
    write_to_output(d, "\n%d. %s\r",
     i + 1,
     trade_letters[i]);
  }
  sprintbit(S_NOTRADE(OLC_SHOP(d)), trade_letters, bits, sizeof(bits));
  write_to_output(d, "\nbits: %s\r", bits);
  OLC_MODE(d) = SEDIT_NOTRADE;
}

static void sedit_types_menu(struct descriptor_data *d)
{
  int i, count = 0;
  get_char_colors(d->character);

  clear_screen(d);
  for (i = 0; i < NUM_ITEM_TYPES; i++) {
    write_to_output(d, "%s%2d%s) %s%-20s%s  %s", grn, i, nrm, cyn, item_types[i],
		nrm, !(++count % 3) ? "\r\n" : "");
  }
  write_to_output(d, "%sEnter choice : ", nrm);
  OLC_MODE(d) = SEDIT_TYPE_MENU;
}

/* Display main menu. */
static void sedit_disp_menu(struct descriptor_data *d)
{
  char buf1[MAX_STRING_LENGTH];
  char buf2[MAX_STRING_LENGTH];
  struct shop_data *shop;

  shop = OLC_SHOP(d);
  get_char_colors(d->character);

  clear_screen(d);
  sprintbit(S_NOTRADE(shop), trade_letters, buf1, sizeof(buf1));
  sprintbit(S_BITVECTOR(shop), shop_bits, buf2, sizeof(buf2));
  write_to_output(d,
	  "\n# Shop: %d\r"
	  "\nselect[a:keeper]:%d - %s\r"
    "\nselect[b:Open 1]:%d\r"
    "\nselect[c:Close 1]:%d\r"
    "\nselect[d:Open 2]:%d\r"
    "\nselect[e:Close 2]:%d\r"
    "\nselect[f:Buy Success]:%s\r"
	  "\nselect[g:Buy Profit]:%1.2f\r"
    "\nselect[h:Sell Success]:%s\r"
    "\nselect[i:Sell Profit]:%1.2f\r"
	  "\nselect[j:No Trade]:%s\r"
	  "\nselect[k:Shop flags]:%s\r"
    "\n## No Item\r"
	  "\nselect[l:keeper]:%s\r"
	  "\nselect[m:player]:%s\r"
    "\n## No Cash\r"
	  "\nselect[n:keeper]:%s\r"
	  "\nselect[o:player]:%s\r"
    "\n## No Buy"
	  "\nselect[p:keeper]:%s\r"
    "\n::begin:buttons\r"
	  "\nbmud[products]:1\r"
    "\nbmud[rooms]:2\r"
	  "\nbmud[types]:3\r"
    "\nbmud[copy]:4\r"
    "\n::end:buttons\r"
	  "\nmenu[quit]:0\r",
	  OLC_NUM(d),
	  S_KEEPER(shop) == NOBODY ? -1 : mob_index[S_KEEPER(shop)].vnum,
	  S_KEEPER(shop) == NOBODY ? "None" : mob_proto[S_KEEPER(shop)].player.short_descr,
	  S_OPEN1(shop),
	  S_CLOSE1(shop),
	  S_OPEN2(shop),
	  S_CLOSE2(shop),
    S_BUY(shop),
	  S_BUYPROFIT(shop),
    S_SELL(shop),
	  S_SELLPROFIT(shop),
    buf1,
	  buf2,
	  S_NOITEM1(shop),
	  S_NOITEM2(shop),
	  S_NOCASH1(shop),
	  S_NOCASH2(shop),
	  S_NOBUY(shop)
  );

  OLC_MODE(d) = SEDIT_MAIN_MENU;
}

/* The GARGANTUAN event handler */
void sedit_parse(struct descriptor_data *d, char *arg)
{
  int i;

  if (OLC_MODE(d) > SEDIT_NUMERICAL_RESPONSE) {
    if (!isdigit(arg[0]) && ((*arg == '-') && (!isdigit(arg[1])))) {
      write_to_output(d, "\nField must be numerical, try again.\r");
      return;
    }
  }
  switch (OLC_MODE(d)) {
  case SEDIT_CONFIRM_SAVESTRING:
    switch (*arg) {
    case 'y':
    case 'Y':
      sedit_save_internally(d);
      mudlog(CMP, MAX(LVL_BUILDER, GET_INVIS_LEV(d->character)), TRUE,
             "OLC: %s edits shop %d", GET_NAME(d->character),
             OLC_NUM(d));
      if (CONFIG_OLC_SAVE) {
        sedit_save_to_disk(real_zone_by_thing(OLC_NUM(d)));
        write_to_output(d, "\nsave:Shop saved to disk.\r");
      } else
        write_to_output(d, "\nsave:Shop saved to memory.\r");

      cleanup_olc(d, CLEANUP_STRUCTS);
      return;
    case 'n':
    case 'N':
      write_to_output(d, "\nsave:Shop not saved.\r");
      cleanup_olc(d, CLEANUP_ALL);
      return;
    default:
      write_to_output(d, "\nInvalid choice!\r");
      write_to_output(d, "%s", confirm_msg);
      return;
    }

  case SEDIT_MAIN_MENU:
    i = 0;
    switch (*arg) {
    case '1':
      sedit_products_menu(d);
      return;
    case '2':
      sedit_rooms_menu(d);
      return;
    case '3':
      sedit_namelist_menu(d);
      return;
    case '4':
      write_to_output(d, "\nCopy what shop?\r");
      OLC_MODE(d) = SEDIT_COPY;
      return;
    case '0':
      if (OLC_VAL(d)) {		/* Anything been changed? */
        write_to_output(d, "%s", confirm_msg);
	     OLC_MODE(d) = SEDIT_CONFIRM_SAVESTRING;
      } else {
        write_to_output(d, "\nsave:Shop unchanged.\r");
        cleanup_olc(d, CLEANUP_ALL);
      }
      return;
    case 'a':
      OLC_MODE(d) = SEDIT_KEEPER;
      write_to_output(d, "\nWho is the shopkeeper?\r");
      return;
    case 'b':
      OLC_MODE(d) = SEDIT_OPEN1;
      i++;
      break;
    case 'c':
      OLC_MODE(d) = SEDIT_CLOSE1;
      i++;
      break;
    case 'd':
      OLC_MODE(d) = SEDIT_OPEN2;
      i++;
      break;
    case 'e':
      OLC_MODE(d) = SEDIT_CLOSE2;
      i++;
      break;
    case 'f':
      OLC_MODE(d) = SEDIT_BUY;
      i--;
      break;
    case 'g':
      OLC_MODE(d) = SEDIT_BUY_PROFIT;
      i++;
      break;
    case 'h':
      OLC_MODE(d) = SEDIT_SELL;
      i--;
      break;
    case 'i':
      OLC_MODE(d) = SEDIT_SELL_PROFIT;
      i++;
      break;
    case 'j':
      sedit_no_trade_menu(d);
      return;
    case 'k':
      sedit_shop_flags_menu(d);
      return;
    case 'l':
      OLC_MODE(d) = SEDIT_NOITEM1;
      i--;
      break;
    case 'm':
      OLC_MODE(d) = SEDIT_NOITEM2;
      i--;
      break;
    case 'n':
      OLC_MODE(d) = SEDIT_NOCASH1;
      i--;
      break;
    case 'o':
      OLC_MODE(d) = SEDIT_NOCASH2;
      i--;
      break;
    case 'p':
      OLC_MODE(d) = SEDIT_NOBUY;
      i--;
      break;
    default:
      sedit_disp_menu(d);
      return;
    }

    if (i == 0)
      break;
    else if (i == 1)
      write_to_output(d, "\nEnter new value:\r");
    else if (i == -1)
      write_to_output(d, "\nEnter new text:\r");
    else
      write_to_output(d, "Oops...\r\n");
    return;

  case SEDIT_NAMELIST_MENU:
    switch (*arg) {
    case 'a':
    case 'A':
      sedit_types_menu(d);
      return;
    case 'd':
    case 'D':
      write_to_output(d, "\r\nDelete which entry? : ");
      OLC_MODE(d) = SEDIT_DELETE_TYPE;
      return;
    case '0':
      break;
    }
    break;

  case SEDIT_PRODUCTS_MENU:
    switch (*arg) {
    case 'a':
      write_to_output(d, "\r\nEnter new product vnum number : ");
      OLC_MODE(d) = SEDIT_NEW_PRODUCT;
      return;
    case 'b':
      write_to_output(d, "\r\nDelete which product? : ");
      OLC_MODE(d) = SEDIT_DELETE_PRODUCT;
      return;
    case '0':
      break;
    }
    break;

  case SEDIT_ROOMS_MENU:
    switch (*arg) {
    case 'a':
      write_to_output(d, "\r\nEnter new room vnum number : ");
      OLC_MODE(d) = SEDIT_NEW_ROOM;
      return;
    case 'b':
      write_to_output(d, "\r\nDelete which room? : ");
      OLC_MODE(d) = SEDIT_DELETE_ROOM;
      return;
    case 'c':
      sedit_compact_rooms_menu(d);
      return;
    case 'd':
      sedit_rooms_menu(d);
      return;
    case '0':
      break;
    }
    break;

    /* String edits. */
  case SEDIT_NOITEM1:
    if (genolc_checkstring(d, arg))
      modify_shop_string(&S_NOITEM1(OLC_SHOP(d)), arg);
    break;
  case SEDIT_NOITEM2:
    if (genolc_checkstring(d, arg))
      modify_shop_string(&S_NOITEM2(OLC_SHOP(d)), arg);
    break;
  case SEDIT_NOCASH1:
    if (genolc_checkstring(d, arg))
      modify_shop_string(&S_NOCASH1(OLC_SHOP(d)), arg);
    break;
  case SEDIT_NOCASH2:
    if (genolc_checkstring(d, arg))
      modify_shop_string(&S_NOCASH2(OLC_SHOP(d)), arg);
    break;
  case SEDIT_NOBUY:
    if (genolc_checkstring(d, arg))
      modify_shop_string(&S_NOBUY(OLC_SHOP(d)), arg);
    break;
  case SEDIT_BUY:
    if (genolc_checkstring(d, arg))
      modify_shop_string(&S_BUY(OLC_SHOP(d)), arg);
    break;
  case SEDIT_SELL:
    if (genolc_checkstring(d, arg))
      modify_shop_string(&S_SELL(OLC_SHOP(d)), arg);
    break;
  case SEDIT_NAMELIST:
    if (genolc_checkstring(d, arg)) {
      struct shop_buy_data new_entry;

      BUY_TYPE(new_entry) = OLC_VAL(d);
      BUY_WORD(new_entry) = strdup(arg);
      add_shop_to_type_list(&(S_NAMELISTS(OLC_SHOP(d))), &new_entry);
    }
    sedit_namelist_menu(d);
    return;

    /* Numerical responses. */
  case SEDIT_KEEPER:
    if ((i = atoi(arg)) != -1)
      if ((i = real_mobile(i)) == NOBODY) {
	write_to_output(d, "That mobile does not exist, try again : ");
	return;
      }
    S_KEEPER(OLC_SHOP(d)) = i;
    if (i == -1)
      break;
    /* Fiddle with special procs. */
    S_FUNC(OLC_SHOP(d)) = mob_index[i].func != shop_keeper ? mob_index[i].func : NULL;
    mob_index[i].func = shop_keeper;
    break;
  case SEDIT_OPEN1:
    S_OPEN1(OLC_SHOP(d)) = LIMIT(atoi(arg), 0, 28);
    break;
  case SEDIT_OPEN2:
    S_OPEN2(OLC_SHOP(d)) = LIMIT(atoi(arg), 0, 28);
    break;
  case SEDIT_CLOSE1:
    S_CLOSE1(OLC_SHOP(d)) = LIMIT(atoi(arg), 0, 28);
    break;
  case SEDIT_CLOSE2:
    S_CLOSE2(OLC_SHOP(d)) = LIMIT(atoi(arg), 0, 28);
    break;
  case SEDIT_BUY_PROFIT:
    sscanf(arg, "%f", &S_BUYPROFIT(OLC_SHOP(d)));
    break;
  case SEDIT_SELL_PROFIT:
    sscanf(arg, "%f", &S_SELLPROFIT(OLC_SHOP(d)));
    break;
  case SEDIT_TYPE_MENU:
    OLC_VAL(d) = LIMIT(atoi(arg), 0, NUM_ITEM_TYPES - 1);
    write_to_output(d, "Enter namelist (return for none) :-\r\n] ");
    OLC_MODE(d) = SEDIT_NAMELIST;
    return;
  case SEDIT_DELETE_TYPE:
    remove_shop_from_type_list(&(S_NAMELISTS(OLC_SHOP(d))), atoi(arg));
    sedit_namelist_menu(d);
    return;
  case SEDIT_NEW_PRODUCT:
    if ((i = atoi(arg)) != -1)
      if ((i = real_object(i)) == NOTHING) {
	write_to_output(d, "That object does not exist, try again : ");
	return;
      }
    if (i > 0)
      add_shop_to_int_list(&(S_PRODUCTS(OLC_SHOP(d))), i);
    sedit_products_menu(d);
    return;
  case SEDIT_DELETE_PRODUCT:
    remove_shop_from_int_list(&(S_PRODUCTS(OLC_SHOP(d))), atoi(arg));
    sedit_products_menu(d);
    return;
  case SEDIT_NEW_ROOM:
    if ((i = atoi(arg)) != -1)
      if ((i = real_room(i)) == NOWHERE) {
	write_to_output(d, "That room does not exist, try again : ");
	return;
      }
    if (i >= 0)
      add_shop_to_int_list(&(S_ROOMS(OLC_SHOP(d))), atoi(arg));
    sedit_rooms_menu(d);
    return;
  case SEDIT_DELETE_ROOM:
    remove_shop_from_int_list(&(S_ROOMS(OLC_SHOP(d))), atoi(arg));
    sedit_rooms_menu(d);
    return;
  case SEDIT_SHOP_FLAGS:
    if ((i = LIMIT(atoi(arg), 0, NUM_SHOP_FLAGS)) > 0) {
      TOGGLE_BIT(S_BITVECTOR(OLC_SHOP(d)), 1 << (i - 1));
      sedit_shop_flags_menu(d);
      return;
    }
    break;
  case SEDIT_NOTRADE:
    if ((i = LIMIT(atoi(arg), 0, NUM_TRADERS)) > 0) {
      TOGGLE_BIT(S_NOTRADE(OLC_SHOP(d)), 1 << (i - 1));
      sedit_no_trade_menu(d);
      return;
    }
    break;
  case SEDIT_COPY:
    if ((i = real_shop(atoi(arg))) != NOWHERE) {
      sedit_setup_existing(d, i);
    } else
      write_to_output(d, "That shop does not exist.\r\n");
    break;

  default:
    /* We should never get here. */
    cleanup_olc(d, CLEANUP_ALL);
    mudlog(BRF, LVL_BUILDER, TRUE, "SYSERR: OLC: sedit_parse(): Reached default case!");
    write_to_output(d, "Oops...\r\n");
    break;
  }

/* If we get here, we have probably changed something, and now want to return
   to main menu.  Use OLC_VAL as a 'has changed' flag. */
  OLC_VAL(d) = 1;
  sedit_disp_menu(d);
}
