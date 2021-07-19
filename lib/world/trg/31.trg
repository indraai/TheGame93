#3100
Agency Corridor Guard~
0 q 100
~
* Check the direction the player must go to enter the guild.
set inroom %self.room%
set item %inroom.contents%

if %actor.is_pc%
  return 0
  %send% %actor% Access Denied.
  %echoaround% security[access:denied:%item.vnum%]:%actor.id%:%actor.name%
end
~
$~
