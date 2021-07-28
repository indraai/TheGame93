#3100
North: Agency Guard~
2 q 100
~
set vnum %self.vnum%
set secstr %vnum%:%actor.id%:%direction%
%echoaround% %actor% security:check:%secstr%
if %direction% == north && %actor.is_pc%
  %send% %actor% Access Denied
  %echoaround% %actor% security:deny:%secstr%
  return 0
else
  %echoaround% %actor% security:allow:%secstr%
end
~
#3101
East: Agency Guard~
2 q 100
~
set vnum %self.vnum%
set secstr %vnum%:%actor.id%:%direction%
%echoaround% %actor% security:check:%secstr%
if %direction% == east && %actor.is_pc%
  %send% %actor% Access Denied
  %echoaround% %actor% security:deny:%secstr%
  return 0
else
  %echoaround% %actor% security:allow:%secstr%
end
~
#3102
South: Agency Guard~
2 q 100
~
set vnum %self.vnum%
set secstr %vnum%:%actor.id%:%direction%
%echoaround% %actor% security:check:%secstr%
if %direction% == south && %actor.is_pc%
  %send% %actor% Access Denied
  %echoaround% %actor% security:deny:%secstr%
  return 0
else
  %echoaround% %actor% security:allow:%secstr%
end
~
#3103
West: Agency Guard~
2 q 100
~
set vnum %self.vnum%
set secstr %vnum%:%actor.id%:%direction%
%echoaround% %actor% security:check:%secstr%
if %direction% == west && %actor.is_pc%
  %send% %actor% Access Denied
  %echoaround% %actor% security:deny:%secstr%
  return 0
else
  %echoaround% %actor% security:allow:%secstr%
end
~
#3104
Up: Agency Guard~
2 q 100
~
set vnum %self.vnum%
set secstr %vnum%:%actor.id%:%direction%
%echoaround% %actor% security:check:%secstr%
if %direction% == up && %actor.is_pc%
  return 0
  %send% %actor% Access Denied
  %echoaround% %actor% security:deny:%secstr%
else
  %echoaround% %actor% security:allow:%secstr%
end
~
#3105
Down: Agency Guard~
2 q 100
~
set vnum %self.vnum%
set secstr %vnum%:%actor.id%:%direction%
%echoaround% %actor% security:check:%secstr%
if %direction% == down && %actor.is_pc%
  return 0
  %send% %actor% Access Denied
  %echoaround% %actor% security:deny:%secstr%
else
  %echoaround% %actor% security:allow:%secstr%
end
~
#3106
Security Check~
2 q 100
~
set vnum %self.vnum%
set role FRIENDLY
if %actor.is_killer%
  set role KILLER
elseif %actor.is_thief%
  set role THIEF
elseif %actor.is_pc% && %actor.align% < 150
  set role EVIL

set secstr %vnum%:%actor.id%:%role%:%direction%

tell %actor% Checking Security Clearance...
%echoaround% %actor% security:check:%secstr%
wait 1 sec
%send% %actor% ...
wait 1 sec
%send% %actor% SECURITY...
wait 1 sec
%send% %actor% SECRET SECURITY...
wait 1 sec
%send% %actor% TOP SECRET SECURITY...
wait 1 sec
%send% %actor% PLUS TOP SECRET SECURITY...
wait 1 sec
%send% %actor% ULTRA PLUS TOP SECRET SECURITY...
wait 1 sec
%send% %actor% PRIME ULTRA PLUS TOP SECRET SECUIRTY...
wait 1 sec
%send% %actor% OMEGA PRIME ULTRA PLUS TOP SECRET SECUIRTY...
wait 1 sec
%send% %actor% ALPHA OMEGA PRIME ULTRA PLUS TOP SECRET SECUIRTY...
wait 1 sec
%send% %actor% DELTA ALPHA OMEGA PRIME ULTRA PLUS TOP SECRET SECUIRTY...
wait 1 sec
%send% %actor% PSI DELTA ALPHA OMEGA PRIME ULTRA PLUS TOP SECRET SECUIRTY...
wait 1 sec
%send% %actor% foo...
wait 1 sec
%send% %actor% bar...
wait 1 sec
%send% %actor% baz...

if %role% == FRIENDLY
  %send% %actor% Security Grandted - Have a wonderful day %actor.name%
  %echoaround% %actor% security:%secstr%

else
  tell %actor% Security Denied - %role%
  %echoaround% %actor% security:alert:%secstr%

  * drop inventory
  while %actor.inventory%
    set inv %actor.inventory%
    if %inv.type% == CONTAINER
      while %inv.contents%
        %purge% %inv.contents%
      done
    else
      %purge% %inv%
    end
  done

  * drop equipment
  set i 23
  while %i%
    if %actor.eq(%i%)%
      %purge% %actor.eq(%i%)%
    end
    eval i %i% - 1
  done

  * drop gold
  nop %actor.gold(-%actor.gold%)%

  wait 1 sec
  %damage% %actor% %shocker%
  eval %actor.mana% %rocker%
  %send% %actor% Every one of your sensitive spots are all tingling.

  * teleport actor to "The Love Shack"
  wait 1 sec
  %teleport% %actor% 28617
  %send% %actor% You have arriaved at The Love Shack BABY!
end
~
#3107
Security Greeting~
0 b 50
~
tell %actor% Hello %actor.name%
~
$~
