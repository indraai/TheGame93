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
set role agent

if %actor.is_pc%
  eval role player

if %actor.align% < -100
  eval role evil

if %actor.is_thief%
  eval role thief

if %actor.is_killer%
  eval role killer

set secstr %self.vnum%:%direction%:%actor.id%:%role%
if %role% == agent
  %send% %actor% Have a nice day %actor.name%.
  %echoaround% security:allow:%secstr%
elseif %role% == player
  %send% %actor% Security Check... %role% %actor.name%
  %echoaround% security:check:%secstr%
else
  %send% %actor% Security Alert... %role% %actor.name%
  %echoaround% security:alert:%secstr%
  * teleport to The Love Shack
  %teleport% %actor% 28617
~
#3107
Security Greeting~
0 g 100
~
say Hello %actor.name%.
~
$~
