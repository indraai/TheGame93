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

wait 2 sec
%echo% Checking Security Clearance...
%echoaround% %actor% security:check:%secstr%
~
#3107
Security Greeting~
0 b 50
~
tell %actor% Hello %actor.name%
~
$~
