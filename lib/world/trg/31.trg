#3100
North: Agency Guard~
2 q 100
~
set inroom %self.room%
set item %inroom.contents%
set vnum = %self.room.contents.vnum%
set secstr %vnum%:%actor.id%:%direction%

%echoaround% security:check:%secstr%
%echo% %actor% Security Checkpoint

if %direction% == north && %actor.is_pc%
  return 0
  %send% %actor% Access Denied.
  %echoaround% security:denied:%secstr%
else
%send% %actor% Access Granted.
  %echoaround% security:granted:%secstr%
end
~
#3101
East: Agency Guard~
2 q 100
~
set inroom %self.room%
set item %inroom.contents%
set vnum = %self.room.contents.vnum%
set secstr %vnum%:%actor.id%:%direction%

%echoaround% security:check:%secstr%
%echo% %actor% Security Checkpoint

if %direction% == east && %actor.is_pc%
  return 0
  %send% %actor% Access Denied.
  %echoaround% security:denied:%secstr%
else
%send% %actor% Access Granted.
  %echoaround% security:granted:%secstr%
end
~
#3102
South: Agency Guard~
2 q 100
~
set inroom %self.room%
set item %inroom.contents%
set vnum = %self.room.contents.vnum%
set secstr %vnum%:%actor.id%:%direction%

%echoaround% security:check:%secstr%
%echo% %actor% Security Checkpoint

if %direction% == south && %actor.is_pc%
  return 0
  %send% %actor% Access Denied.
  %echoaround% security:denied:%secstr%
else
%send% %actor% Access Granted.
  %echoaround% security:granted:%secstr%
end
~
#3103
West: Agency Guard~
2 q 100
~
set inroom %self.room%
set item %inroom.contents%
set vnum = %self.room.contents.vnum%
set secstr %vnum%:%actor.id%:%direction%

%echoaround% security:check:%secstr%
%echo% %actor% Security Checkpoint

if %direction% == west && %actor.is_pc%
  return 0
  %send% %actor% Access Denied.
  %echoaround% security:denied:%secstr%
else
%send% %actor% Access Granted.
  %echoaround% security:granted:%secstr%
end
~
#3104
Up: Agency Guard~
2 q 100
~
set inroom %self.room%
set item %inroom.contents%
set vnum = %self.room.contents.vnum%
set secstr %vnum%:%actor.id%:%direction%

%echoaround% security:check:%secstr%
%echo% %actor% Security Checkpoint

if %direction% == up && %actor.is_pc%
  return 0
  %send% %actor% Access Denied.
  %echoaround% security:denied:%secstr%
else
%send% %actor% Access Granted.
  %echoaround% security:granted:%secstr%
end
~
#3105
Down: Agency Guard~
2 q 100
~
set inroom %self.room%
set item %inroom.contents%
set vnum = %self.room.contents.vnum%
set secstr %vnum%:%actor.id%:%direction%

%echoaround% security:check:%secstr%
%echo% %actor% Security Checkpoint

if %direction% == down && %actor.is_pc%
  return 0
  %send% %actor% Access Denied.
  %echoaround% security:denied:%secstr%
else
%send% %actor% Access Granted.
  %echoaround% security:granted:%secstr%
end
~
$~
