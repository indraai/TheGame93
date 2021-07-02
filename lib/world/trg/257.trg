#25700
 Guildguard - 25774~
0 q 100
~
* Check the direction the player must go to enter the guild.
if %direction% == west
  * Stop them if they are not the appropriate class.
  if %actor.class% !=
    return 0
    %send% %actor% The guard humiliates you, and blocks your way.
    %echoaround% %actor% The guard humiliates %actor.name%, and blocks %actor.hisher% way.
  end
end
~
#25701
Mage Guildguard - 25773~
0 q 100
~
* Check the direction the player must go to enter the guild.
if %direction% == north
  * Stop them if they are not the appropriate class.
  if %actor.class% != Magic User
    return 0
    %send% %actor% The guard humiliates you, and blocks your way.
    %echoaround% %actor% The guard humiliates %actor.name%, and blocks %actor.hisher% way.
  end
end
~
#25702
Ranger Guildguard - 25776~
0 q 100
~
* Check the direction the player must go to enter the guild.
if %direction% == south
  * Stop them if they are not the appropriate class.
  if %actor.class% != Ranger
    return 0
    %send% %actor% The guard humiliates you, and blocks your way.
    %echoaround% %actor% The guard humiliates %actor.name%, and blocks %actor.hisher% way.
  end
end
~
#25703
Warrior Guildguard - 25775~
0 q 100
~
* Check the direction the player must go to enter the guild.
if %direction% == west
  * Stop them if they are not the appropriate class.
  if %actor.class% != warrior
    return 0
    %send% %actor% The guard humiliates you, and blocks your way.
    %echoaround% %actor% The guard humiliates %actor.name%, and blocks %actor.hisher% way.
  end
end
~
#25704
Thief Guildguard - 25777~
0 q 100
~
* Check the direction the player must go to enter the guild.
if %direction% == east
  * Stop them if they are not the appropriate class.
  if %actor.class% != thief
    return 0
    %send% %actor% The guard humiliates you, and blocks your way.
    %echoaround% %actor% The guard humiliates %actor.name%, and blocks %actor.hisher% way.
  end
end
~
#25705
Give Bank - 25704~
2 c 100
g~
* By Rumble
* Make sure the command is give, check for any abbrev of goo
if %cmd.mudcommand% == give && goo /= %arg%
  * let the player stun themselves, they will recover.
  if %actor.hitp% < 18
    %send% %actor% You try to give goo. But, the nurse refuses since you are white as a ghost and can barely stand.
    %echoaround% %actor% %actor.name% tries to give goo. But, the nurse laughs in %actor.hisher% face since he is white as a ghost and can barely stand.
  else
    %send% %actor% The nurse puts a sucker device over your nippies and quickly draws a small amount of goo. She gives you some coins.
    %echoaround% %actor% The sucker device on %actor.name% nippies draws a small amount of goo. %actor.name% receives a small pile of coins.
    nop %actor.gold(20)%
    %damage% %actor% 20
  end
else
  * If it doesn't match let the command continue.
  %send% %actor% Give what to who?
  return 0
end
~
$~
