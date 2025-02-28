/**
* @file weather.c
* Functions that handle the in game progress of time and weather changes.
*
* Part of the core tbaMUD source code distribution, which is a derivative
* of, and continuation of, CircleMUD.
*
* All rights reserved.  See license for complete information.
* Copyright (C) 1993, 94 by the Trustees of the Johns Hopkins University
* CircleMUD is based on DikuMUD, Copyright (C) 1990, 1991.
*/

#include "conf.h"
#include "sysdep.h"
#include "structs.h"
#include "utils.h"
#include "comm.h"
#include "db.h"
#include "constants.h"

static void another_min(int mode);
static void weather_change(void);

/** Call this function every mud hour to increment the gametime (by one hour)
 * and the weather patterns.
 * @param mode Really, this parameter has the effect of a boolean. In the
 * current incarnation of the function and utility functions, as long as mode
 * is non-zero, the gametime will increment one hour and the weather will be
 * changed.
 */
void weather_and_time(int mode)
{
  another_min(mode);
  if (mode)
    weather_change();
}

/** Increment the game time by one hour (no matter what) and display any time
 * dependent messages via send_to_outdoors() (if parameter is non-zero).
 * @param mode Really, this parameter has the effect of a boolean. If non-zero,
 * display day/night messages to all eligible players.
 */
static void another_min(int mode)
{
  int weekday, day;
  time_info.minute++;

  // SEND THE TIME TO ALL EVERY MINUTE FOR WATCH SYNC
  send_to_all("\ntime: %d:%d",
    time_info.hours,
    time_info.minute + 1);

  // SWITCH OVER THE HOUR HERE
  // For this part when the minute is equal or greater to the hour we
  // then increment the hour and post the weather bulletin for the day state.
  if (time_info.minute >= MINS_PER_MUD_HOUR) {
    time_info.minute = 0;
    time_info.hours++;

    if (mode) {
      switch (time_info.hours) {
      case HOUR_SUN_RISE:
        weather_info.sunlight = SUN_RISE;
        send_to_outdoor("\nweather:The sun rises.\r");
        break;
      case HOUR_SUN_LIGHT:
        weather_info.sunlight = SUN_LIGHT;
        send_to_outdoor("\nweather:The day begins.\r");
        break;
      case HOUR_SUN_SET:
        weather_info.sunlight = SUN_SET;
        send_to_outdoor("\nweather:The sun sets.\r");
        break;
      case HOUR_SUN_DARK:
        weather_info.sunlight = SUN_DARK;
        send_to_outdoor("\nweather:The night begins.\r");
        break;
      default:
        break;
      }
    }

    // SWITCH OVER THE DAY HERE
    if (time_info.hours >= HOURS_PER_MUD_DAY) {	/* Changed by HHS due to bug ??? */
      time_info.hours = 0;
      time_info.day++;

      day = time_info.day + 1;
      weekday = ((DAYS_PER_MUD_MONTH * time_info.month) + day) % DAYS_PER_MUD_WEEK;
      send_to_all("\ndate:%s - %s %d, %d\r",
        weekdays[weekday],
        month_name[time_info.month],
    	  day,
        time_info.year);

      if (time_info.day > DAYS_PER_MUD_MONTH) {
        time_info.day = 0;
        time_info.month++;

        if (time_info.month > MONTHS_PER_MUD_YEAR) {
           time_info.month = 0;
           time_info.year++;
        }
      }
    }
  }
}

/** Controls the in game weather system. If the weather changes, an information
 * update is sent via send_to_outdoors().
 * @todo There are some hard coded values that could be extracted to make
 * customizing the weather patterns easier.
 */
static void weather_change(void)
{
  int diff, change;

  if ((time_info.month >= 9) && (time_info.month <= 16))
    diff = (weather_info.pressure > 985 ? -2 : 2);
  else
    diff = (weather_info.pressure > 1015 ? -2 : 2);

  weather_info.change += (dice(1, 4) * diff + dice(2, 6) - dice(2, 6));

  weather_info.change = MIN(weather_info.change, 12);
  weather_info.change = MAX(weather_info.change, -12);

  weather_info.pressure += weather_info.change;

  weather_info.pressure = MIN(weather_info.pressure, 1040);
  weather_info.pressure = MAX(weather_info.pressure, 960);

  change = 0;

  switch (weather_info.sky) {
  case SKY_CLOUDLESS:
    if (weather_info.pressure < 990)
      change = 1;
    else if (weather_info.pressure < 1010)
      if (dice(1, 4) == 1)
	change = 1;
    break;
  case SKY_CLOUDY:
    if (weather_info.pressure < 970)
      change = 2;
    else if (weather_info.pressure < 990) {
      if (dice(1, 4) == 1)
	change = 2;
      else
	change = 0;
    } else if (weather_info.pressure > 1030)
      if (dice(1, 4) == 1)
	change = 3;

    break;
  case SKY_RAINING:
    if (weather_info.pressure < 970) {
      if (dice(1, 4) == 1)
	change = 4;
      else
	change = 0;
    } else if (weather_info.pressure > 1030)
      change = 5;
    else if (weather_info.pressure > 1010)
      if (dice(1, 4) == 1)
	change = 5;

    break;
  case SKY_LIGHTNING:
    if (weather_info.pressure > 1010)
      change = 6;
    else if (weather_info.pressure > 990)
      if (dice(1, 4) == 1)
	change = 6;

    break;
  default:
    change = 0;
    weather_info.sky = SKY_CLOUDLESS;
    break;
  }

  switch (change) {
  case 0:
    break;
  case 1:
    send_to_outdoor("\nweather:The sky is cloudy.\r");
    weather_info.sky = SKY_CLOUDY;
    break;
  case 2:
    send_to_outdoor("\nweather:It starts to rain.\r");
    weather_info.sky = SKY_RAINING;
    break;
  case 3:
    send_to_outdoor("\nweather:The clouds disappear.\r");
    weather_info.sky = SKY_CLOUDLESS;
    break;
  case 4:
    send_to_outdoor("\nweather:Lightning starts in the sky.\r");
    weather_info.sky = SKY_LIGHTNING;
    break;
  case 5:
    send_to_outdoor("\nweather:The rain stops.\r");
    weather_info.sky = SKY_CLOUDY;
    break;
  case 6:
    send_to_outdoor("\nweather:The lightning stops.\r");
    weather_info.sky = SKY_RAINING;
    break;
  default:
    break;
  }
}
