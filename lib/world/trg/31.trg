#3100
North: Agency Guard~
2 q 100
~
set inroom %self.room%
set item %inroom.contents%
if %direction% == north && %actor.is_pc%
  return 0
  %send% %actor% Access Denied.
  %echoaround% security[access:denied:%item.vnum%]:%actor.id%:%actor.name%
end
~
#3101
East: Agency Guard~
2 q 100
~
set inroom %self.room%
set item %inroom.contents%
if %direction% == east && %actor.is_pc%
  return 0
  %send% %actor% Access Denied.
  %echoaround% security[access:denied:%item.vnum%]:%actor.id%:%actor.name%
end
~
#3102
South: Agency Guard~
2 q 100
~
set inroom %self.room%
set item %inroom.contents%
if %direction% == south && %actor.is_pc%
  return 0
  %send% %actor% Access Denied.
  %echoaround% security[access:denied:%item.vnum%]:%actor.id%:%actor.name%
end
~
#3103
West: Agency Guard~
2 q 100
~
set inroom %self.room%
set item %inroom.contents%
if %direction% == west && %actor.is_pc%
  return 0
  %send% %actor% Access Denied.
  %echoaround% security[access:denied:%item.vnum%]:%actor.id%:%actor.name%
end
~
#3104
Up: Agency Guard~
2 q 100
~
set inroom %self.room%
set item %inroom.contents%
if %direction% == up && %actor.is_pc%
  return 0
  %send% %actor% Access Denied.
  %echoaround% security[access:denied:%item.vnum%]:%actor.id%:%actor.name%
end
~
#3105
Down: Agency Guard~
2 q 100
~
set inroom %self.room%
set item %inroom.contents%
if %direction% == down && %actor.is_pc%
  return 0
  %send% %actor% Access Denied.
  %echoaround% security[access:denied:%item.vnum%]:%actor.id%:%actor.name%
end
~
$~
