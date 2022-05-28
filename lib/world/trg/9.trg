#900
Triggers North~
2 g 100
~
set room %actor.room.vnum%
if %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#adv world:thegame %room%/main:trg1
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg2
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg3
  wait 16s
  %send% %actor% talk:#adv world:thegame %room%/main:trg4
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg5
  wait 30s
  %send% %actor% gui:#mud north
en8
~
#901
Triggers East~
2 g 100
~
set room %actor.room.vnum%
if %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#adv world:thegame %room%/main:trg1
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg2
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg3
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg4
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg5
  wait 30s
  %send% %actor% gui:#mud east
end
~
#902
Triggers South~
2 g 100
~
set room %actor.room.vnum%
if %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#adv world:thegame %room%/main:trg1
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg2
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg3
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg4
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg5
  wait 30s
  %send% %actor% gui:#mud south
end
~
#903
Triggers West~
2 g 100
~
set room %actor.room.vnum%
if %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#adv world:thegame %room%/main:trg1
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg2
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg3
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg4
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg5
  wait 30s
  %send% %actor% gui:#mud west
end
~
#904
Triggers North East~
2 g 100
~
set room %actor.room.vnum%
if %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#adv world:thegame %room%/main:trg1
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg2
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg3
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg4
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg5
  wait 30s
  %send% %actor% gui:#mud northeast
end
~
#905
Triggers South East~
2 g 100
~
set room %actor.room.vnum%
if %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#adv world:thegame %room%/main:trg1
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg2
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg3
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg4
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg5
  wait 30s
  %send% %actor% gui:#mud southeast
end
~
#906
Triggers South West~
2 g 100
~
set room %actor.room.vnum%
if %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#adv world:thegame %room%/main:trg1
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg2
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg3
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg4
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg5
  wait 30s
  %send% %actor% gui:#mud southwest
end
~
#907
Triggers North West~
2 g 100
~
set room %actor.room.vnum%
if %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#adv world:thegame %room%/main:trg1
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg2
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg3
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg4
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg5
  wait 30s
  %send% %actor% gui:#mud northwest
end
~
#908
Triggers Random~
2 g 100
~
set room %actor.room.vnum%
set d %random.dir%

wait 1s
if dir(%room%)
  eval prev %dir(%%room%%)%
  %echo% prev - %prev% ... d - %d%
  while %d% == %prev%
    set d %random.dir%
    %echo% ndir %prev% %d%
  done
  set dir(%room%) %d%
else
  set dir(%room%) %d%
  global dir(%room%)
  %echo% random dir dir(%room%) %d%
end

if %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#adv world:thegame %room%/main:trg1
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg2
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg3
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg4
  wait 20s
  %send% %actor% talk:#adv world:thegame %room%/main:trg5
  wait 30s
  %send% %actor% gui:#mud %%dir(%room%)%%
end
~
$~
