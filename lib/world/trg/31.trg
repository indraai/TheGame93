#3100
North: Agency Guard~
2 q 100
~
set vnum %self.vnum%
set secstr %vnum%:%actor.id%:%direction%
%echoaround% security:check:%secstr%
if %direction% == north && %actor.is_pc%
  %send% %actor% Access Denied
  %echoaround% security:deny:%secstr%
  return 0
else
  %echoaround% security:allow:%secstr%
end
~
#3101
East: Agency Guard~
2 q 100
~
set vnum %self.vnum%
set secstr %vnum%:%actor.id%:%direction%
%echoaround% security:check:%secstr%
if %direction% == east && %actor.is_pc%
  %send% %actor% Access Denied
  %echoaround% security:deny:%secstr%
  return 0
else
  %echoaround% security:allow:%secstr%
end
~
#3102
South: Agency Guard~
2 q 100
~
set vnum %self.vnum%
set secstr %vnum%:%actor.id%:%direction%
%echoaround% security:check:%secstr%
if %direction% == south && %actor.is_pc%
  %send% %actor% Access Denied
  %echoaround% security:deny:%secstr%
  return 0
else
  %echoaround% security:allow:%secstr%
end
~
#3103
West: Agency Guard~
2 q 100
~
set vnum %self.vnum%
set secstr %vnum%:%actor.id%:%direction%
%echoaround% security:check:%secstr%
if %direction% == west && %actor.is_pc%
  %send% %actor% Access Denied
  %echoaround% security:deny:%secstr%
  return 0
else
  %echoaround% security:allow:%secstr%
end
~
#3104
Up: Agency Guard~
2 q 100
~
set vnum %self.vnum%
set secstr %vnum%:%actor.id%:%direction%
%echoaround% security:check:%secstr%
if %direction% == up && %actor.is_pc%
  return 0
  %send% %actor% Access Denied
  %echoaround% security:deny:%secstr%
else
  %echoaround% security:allow:%secstr%
end
~
#3105
Down: Agency Guard~
2 q 100
~
set vnum %self.vnum%
set secstr %vnum%:%actor.id%:%direction%
%echoaround% security:check:%secstr%
if %direction% == down && %actor.is_pc%
  return 0
  %send% %actor% Access Denied
  %echoaround% security:deny:%secstr%
else
  %echoaround% security:allow:%secstr%
end
~
#3106
Security Check~
2 q 100
~
set secstr %actor.id%:%direction%:%self.vnum%
if %actor.align% < 0 || %actor.is_thief% || %actor.is_killer%
  %send% %actor% Security Alert... %actor.name%
  %echoaround% security:alert:%secstr%
  * teleport to The Love Shack
  %teleport% %actor% 28617
else
  %send% %actor% Have a nice day %actor.name%. -Security
  %echoaround% security:check:%secstr%
end
~
#3107
SecurityDEVA Patrol~
0 b 50
~
say Indra Agency patrol. Here to ensure your security and safety.
set actor %random.char%
if %actor%
  if %actor.align% < 0 || %actor.is_thief% || %actor.is_killer%
    %echo% security:alert:%actor.id%:%direction%:%actor.room.vnum%
    * teleport to The Love Shack
    %teleport% %actor% 28617
  end
end

* set patrol stuff
wait 10 sec
say Have a nice day! #IndraAgency
%random.dir%
~
$~
