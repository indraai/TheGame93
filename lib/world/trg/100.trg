#1000
Gunnar Larsen~
0 g 100
~
  wait 5s
  say Well?
  wait 5s
  say Any Radar return?
~
#1001
James Sneed Trigger~
0 g 100
~
  wait 7s
  emote looks up, a broad smile on his face.
  wait 1s
  say This is it, friends—the Bottomless Crevasse.
  wait 5s
  emote shakes head
  wait 1s
  say None.
~
#1002
Hash Tracker~
1 acg 100
n~
wait 3s
You are in %actor.room.vnum% currently.
~
#1003
Underground Kingdom Guide~
0 b 100
~
set fol %self.follower%
set inroom %self.room.vnum%
set startroom 1000
if %fol%
  if %inroom% == %startroom%
    wait 5 sec
    north
  else
    wait 60 sec
    %random.dir%
  end
else
  if %inroom% != %startroom%
    %mgoto% 1000
  end
end
~
#1004
Give Token Wallet to Actor~
2 g 100
~
set key 1004
set wallet %actor.inventory(%key%)%
if !%wallet%
  %load% obj %key% %actor%
  wait 5s
  %send% %actor% You have the Token Wallet.
end
~
#1005
Room 1005 Trigger~
2 q 100
~
set token 0
set key 1013
set wallet 1004
set dir north

set msg talk:#adv world:thegame 1000/closed

* CHECK THE ACTORS INVENTORY AND CONTAINERS FOR THE KEY
while %actor.inventory% && !%token%
  eval item %actor.inventory%
  set token %item.vnum% == %key%
  if !%token% && %item.type% == CONTAINER
    while %item.contents% && !%token%
      eval container %item.contents%
      set token %container.vnum% == %key%
    end
  end
end

if %token%
  if %direction% == %dir%
    return 0
    %echo% %msg%
  end
end
~
#1008
R1008 Give Token~
2 g 100
~
set key 1008
set token %actor.inventory(%thekey%)%
set room %self.room.vnum%
set reward 50
if !%token%
  wait 3s
  nop %actor.exp(%reward%)%
  %send% %actor% exp:You earned %reward% EXP for your efforts.
  wait 1s
  nop %actor.gold(%reward%)%
  %send% %actor% gold:You earned %reward% GOLD for a job well done.
  wait 1s
  %load% obj %key% %actor%
  %send% %actor% key:You received the 0x%key% Token Key.
end
~
#1010
R1010 Check Token~
2 q 100
~
set key 1008
set dir north
set token %actor.inventory(%key%)%
set room %self.vnum%
set msg talk:#adv world:thegame 1000/closed
if %token%
  if %direction% == %dir%
    return 0
    %echo% %msg%
  end
end
~
#1012
R1012 Check Token~
2 q 100
~
set key 1020
set dir south
set token %actor.inventory(%key%)%
set room %self.vnum%
set msg talk:#adv world:thegame 1000/closed
if %token%
  if %direction% == %dir%
    return 0
    %echo% %msg%
  end
end
~
#1013
R1013 Give Token~
2 g 100
~
set key 1013
set reward 50
set room %self.vnum%
set token 0

* CHECK THE ACTORS INVENTORY AND CONTAINERS FOR THE KEY
while %actor.inventory% && !%token%
  eval item %actor.inventory%
  if %item.vnum% == %key%
    set token 1
  end
  if !%token% && %item.type% == CONTAINER
    while %item.contents% && !%token%
      eval con %item.contents%
      if %con.vnum% == %key%
        set token 1
      end
    end
  end
end

if !%token%
  wait 3s
  nop %actor.exp(%reward%)%
  %send% %actor% exp:You earned %reward% EXP for your efforts.
  wait 1s
  nop %actor.gold(%reward%)%
  %send% %actor% gold:You earned %reward% GOLD for a job well done.
  wait 1s
  %load% obj %key% %actor%
  %send% %actor% key:You received the 0x%key% Token Key.
end
~
#1016
R1016 Check Token~
2 q 100
~
set key 1023
set dir south
set token %actor.inventory(%key%)%
set room %self.vnum%
set msg talk:#adv world:thegame 1000/closed
if %token%
  if %direction% == %dir%
    return 0
    %echo% %msg%
  end
end
~
#1020
R1020 Give Token~
2 g 100
~
set key 1020
set token %actor.inventory(%key%)%
set room %actor.room.vnum%
set reward 60
if !%token%
  wait 3s
  nop %actor.exp(%reward%)%
  %send% %actor% exp:You earned %reward% EXP for your efforts.
  wait 1s
  nop %actor.gold(%reward%)%
  %send% %actor% gold:You earned %reward% GOLD for a job well done.
  wait 1s
  %load% obj %key% %actor%
  %send% %actor% key:You receive the 0x%key% Token Key.
end
~
#1021
RM1021~
2 q 100
~
set key 1032
set dir north
set token %actor.inventory(%key%)%
set room %self.vnum%
set msg talk:#adv world:thegame 1000/closed
if %token%
  if %direction% == %dir%
    return 0
    %echo% %msg%
  end
end
~
#1023
R1023 Give Token~
2 g 100
~
set key 1023
set token %actor.inventory(%key%)%
set room %self.vnum%
set reward 70
if !%token%
  wait 3s
  nop %actor.exp(%reward%)%
  %send% %actor% exp:You earned %reward% EXP for your efforts.
  wait 1s
  nop %actor.gold(%reward%)%
  %send% %actor% gold:You earned %reward% GOLD for a job well done.
  wait 1s
  %load% obj %key% %actor%
  %send% %actor% key:You received the 0x%key% Token Key.
end
~
#1024
R1024 Give Token~
2 g 100
~
set key 1024
set token %actor.inventory(%key%)%
set room %self.vnum%
set reward 30
if !%token%
  wait 3s
  nop %actor.exp(%reward%)%
  %send% %actor% exp:You earned %reward% EXP for your efforts.
  wait 1s
  nop %actor.gold(%reward%)%
  %send% %actor% gold:You earned %reward% GOLD for a job well done.
  wait 1s
  %load% obj %key% %actor%
  %send% %actor% key:You received the 0x%key% Token Key.
end
~
#1026
RM1026~
2 q 100
~
set key 1024
set dir south
set token %actor.inventory(%key%)%
set room %self.vnum%
set msg talk:#adv world:thegame 1000/closed
if %token%
  if %direction% == %dir%
    return 0
    %echo% %msg%
  end
end
~
#1027
RM1027 Token Trigger~
2 q 100
~
set key 1024
set dir south
set token %actor.inventory(%key%)%
set room %self.vnum%
set msg talk:#adv world:thegame 1000/closed
if %token%
  if %direction% == %dir%
    return 0
    %echo% %msg%
  end
end
~
#1032
R1032 Give Token~
2 g 100
~
set key 1032
set token %actor.inventory(%key%)%
set room %actor.room.vnum%
set reward 10
if !%token%
  wait 3s
  nop %actor.exp(%reward%)%
  %send% %actor% exp:You earned %reward% EXP for your efforts.
  wait 1s
  nop %actor.gold(%reward%)%
  %send% %actor% gold:You earned %reward% GOLD for a job well done.
  wait 1s
  %load% obj %key% %actor%
  %send% %actor% key:You received the 0x%key% Token Key.
end
~
#1033
R1033 Give Token~
2 g 100
~
set key 1033
set token %actor.inventory(%key%)%
set room %actor.room.vnum%
set reward 10
if !%token%
  wait 3s
  nop %actor.exp(%reward%)%
  %send% %actor% exp:You earn %reward% EXP for your efforts.
  nop %actor.gold(%reward%)%
  %send% %actor% gold:You earn %reward% GOLD for a job well done.
  %load% obj %key% %actor%
  %send% %actor% key:You earn the 0x%key% Token Key.
end
~
#1037
RM1037~
2 q 100
~
set key 1089
set dir north
set token %actor.inventory(%key%)%
set room %self.vnum%
set msg talk:#adv world:thegame 1000/closed
if %token%
  if %direction% == %dir%
    return 0
    %echo% %msg%
  end
end
~
#1039
RM1039~
2 q 100
~
set key 1047
set dir south
set token %actor.inventory(%key%)%
set room %self.vnum%
set msg talk:#adv world:thegame 1000/closed
if %token%
  if %direction% == %dir%
    return 0
    %echo% %msg%
  end
end
~
#1044
RM1039~
2 q 100
~
set key1 1023
set key2 1062
set token1 %actor.inventory(%key1%)%
set token2 %actor.inventory(%key2%)%
set dir north
set room %self.vnum%
set msg talk:#adv world:thegame 1000/closed
if %token1% && %token2%
  if %direction% == %dir%
    return 0
    %echo% %msg%
  end
end
~
#1047
R1047 Give Token~
2 g 100
~
set key 1047
set token %actor.inventory(%key%)%
set room %actor.room.vnum%
set reward 10
if !%token%
  wait 3s
  nop %actor.exp(%reward%)%
  %send% %actor% exp:You earned %reward% EXP for your efforts.
  wait 1s
  nop %actor.gold(%reward%)%
  %send% %actor% gold:You earned %reward% GOLD for a job well done.
  wait 1s
  %load% obj %key% %actor%
  %send% %actor% key:You received the 0x%key% Token Key.
end
~
#1051
RM1051~
2 q 100
~
set key 1064
set dir south
set token %actor.inventory(%key%)%
set room %self.vnum%
set msg talk:#adv world:thegame 1000/closed
if %token%
  if %direction% == %dir%
    return 0
    %echo% %msg%
  end
end
~
#1053
RM1053~
2 q 100
~
set key 1060
set dir north
set token %actor.inventory(%key%)%
set room %self.vnum%
set msg talk:#adv world:thegame 1000/closed
if %token%
  if %direction% == %dir%
    return 0
    %echo% %msg%
  end
end
~
#1055
RM1055 Token Check~
2 q 100
~
set skey 1062
set sdir south
set nkey 1023
set ndir north
set stoken %actor.inventory(%skey%)%
set ntoken %actor.inventory(%nkey%)%
set room %self.vnum%
set msg talk:#adv world:thegame 1000/closed
if %stoken%
  if %direction% == %sdir%
    return 0
    %echo% %msg%
  end
end
if %ntoken%
  if %direction% == %ndir%
    return 0
    %echo% %msg%
  end
end
~
#1058
RM1058~
2 q 100
~
set key 1065
set dir south
set token %actor.inventory(%key%)%
set room %self.vnum%
set msg talk:#adv world:thegame 1000/closed
if %token%
  if %direction% == %dir%
    return 0
    %echo% %msg%
  end
end
~
#1060
R1060 Give Token~
2 g 100
~
set thekey 1060
set thetoken %actor.inventory(%thekey%)%
set thisroom %actor.room.vnum%
set reward 10
if !%thetoken%
  wait 1s
  nop %actor.exp(%reward%)%
  %send% %actor% exp:You earn %reward% EXP for your efforts.
  wait 1s
  nop %actor.gold(%reward%)%
  %send% %actor% gold:You earn %reward% GOLD for a job well done.
  wait 1s
  %load% obj %thekey% %actor%
  %send% %actor% key:You earn the 0x%thekey% Token Key.
end
~
#1062
R1062 Give Token~
2 g 100
~
set key 1062
set token %actor.inventory(%key%)%
set thisroom %actor.room.vnum%
set reward 10
if !%token%
  wait 3s
  nop %actor.exp(%reward%)%
  %send% %actor% exp:You earn %reward% EXP for your efforts.
  wait 1s
  nop %actor.gold(%reward%)%
  %send% %actor% gold:You earn %reward% GOLD for a job well done.
  wait 1s
  %load% obj %key% %actor%
  %send% %actor% key:You earn the 0x%key% Token Key.
end
~
#1064
R1064 Give Token~
2 g 100
~
set key 1064
set token %actor.inventory(%key%)%
set thisroom %actor.room.vnum%
set reward 10
if !%token%
  wait 3s
  nop %actor.exp(%reward%)%
  %send% %actor% exp:You earn %reward% EXP for your efforts.
  wait 1s
  nop %actor.gold(%reward%)%
  %send% %actor% gold:You earn %reward% GOLD for a job well done.
  wait 1s
  %load% obj %key% %actor%
  %send% %actor% key:You earn the 0x%key% Token Key.
end
~
#1065
R1065 Give Token~
2 g 100
~
set key 1065
set token %actor.inventory(%key%)%
set room %actor.room.vnum%
set reward 10
if !%token%
  wait 3s
  nop %actor.exp(%reward%)%
  %send% %actor% exp:You earned %reward% EXP for your efforts.
  wait 1s
  nop %actor.gold(%reward%)%
  %send% %actor% gold:You earned %reward% GOLD for a job well done.
  wait 1s
  %load% obj %key% %actor%
  %send% %actor% key:You received the 0x%key% Token Key.
end
~
#1068
RM1068~
2 q 100
~
set key 1072
set dir south
set token %actor.inventory(%key%)%
set room %self.vnum%
set msg talk:#adv world:thegame 1000/closed
if %token%
  if %direction% == %dir%
    return 0
    %echo% %msg%
  end
end
~
#1069
R1069 Give Token~
2 g 100
~
set key 1069
set token %actor.inventory(%key%)%
set room %actor.room.vnum%
set reward 50
if !%token%
  wait 3s
  nop %actor.exp(%reward%)%
  %send% %actor% exp:You earn %reward% EXP for your efforts.
  wait 1s
  nop %actor.gold(%reward%)%
  %send% %actor% gold:You earn %reward% GOLD for a job well done.
  wait 1s
  %load% obj %key% %actor%
  %send% %actor% key:You earn the 0x%key% Token Key.
end
~
#1070
RM1070~
2 q 100
~
set key 1084
set dir north
set token %actor.inventory(%key%)%
set room %self.vnum%
set msg talk:#adv world:thegame 1000/closed
if %token%
  if %direction% == %dir%
    return 0
    %echo% %msg%
  end
end
~
#1072
R1072 Give Token~
2 g 100
~
set key 1072
set token %actor.inventory(%key%)%
set room %actor.room.vnum%
set reward 50
if !%token%
  wait 3s
  nop %actor.exp(%reward%)%
  %send% %actor% exp:You earned %reward% EXP for your efforts.
  wait 1s
  nop %actor.gold(%reward%)%
  %send% %actor% gold:You earned %reward% GOLD for a job well done.
  wait 1s
  %load% obj %thekey% %actor%
  %send% %actor% key:You received the 0x%thekey% Token Key.
end
~
#1074
R1074 Give Token~
2 g 100
~
set thekey 1074
set thetoken %actor.inventory(%thekey%)%
set thisroom %actor.room.vnum%
set reward 100
if !%thetoken%
  wait 1s
  nop %actor.exp(%reward%)%
  %send% %actor% exp:You earned %reward% EXP for your efforts.
  wait 1s
  nop %actor.gold(%reward%)%
  %send% %actor% gold:You earned %reward% GOLD for a job well done.
  wait 1s
%load% obj %thekey% %actor%
  %send% %actor% key:You received the 0x1074 Token Key.
end
~
#1075
Professor Bruckner~
0 g 100
~
wait 3s
emote fills his pipe with tobacco.
wait 3s
say As I explained it's a Black Hole in the center of the Earth.
wait 3s
emote lights his pipe
wait 3s
say Who will volunteer to come with me?
~
#1077
RM1077 Token Check~
2 q 100
~
set key 1033
set dir south
set token %actor.inventory(%key%)%
set room %self.vnum%
set msg talk:#adv world:thegame 1000/closed
if %token%
  if %direction% == %dir%
    return 0
    %echo% %msg%
  end
end
~
#1078
RM1078 Token Check~
2 q 100
~
set key 1074
set dir south
set token %actor.inventory(%key%)%
set room %self.vnum%
set msg talk:#adv world:thegame 1000/closed
if %token%
  if %direction% == %dir%
    return 0
    %echo% %msg%
  end
end
~
#1084
R1084 Give Token~
2 g 100
~
set key 1084
set token %actor.inventory(%key%)%
set room %self.vnum%
set reward 100
if !%token%
  wait 3s
  nop %actor.exp(%reward%)%
  %send% %actor% exp:You earn %reward% EXP for your efforts.
  wait 1s
  nop %actor.gold(%reward%)%
  %send% %actor% gold:You earn %reward% GOLD for a job well done.
  wait 1s
  %load% obj %key% %actor%
  %send% %actor% key:You earn the 0x%key% Token Key.
end
~
#1089
R1089 Give Token~
2 g 100
~
set thekey 1089
set thetoken %actor.inventory(%thekey%)%
set thisroom %actor.room.vnum%
set reward 100
if !%thetoken%
  wait 1s
  nop %actor.exp(%reward%)%
  %send% %actor% exp:You earn %reward% EXP for your efforts.
  wait 1s
  nop %actor.gold(%reward%)%
  %send% %actor% gold:You earn %reward% GOLD for a job well done.
  wait 1s
  %load% obj %thekey% %actor%
  %send% %actor% key:You earn the 0x%thekey% Token Key.
end
~
#1102
R1102 Give Token~
2 g 100
~
set thekey 1102
set thetoken %actor.inventory(%thekey%)%
set thisroom %actor.room.vnum%
set reward 100
if !%thetoken%
  wait 1s
  nop %actor.exp(%reward%)%
  %send% %actor% exp:You earn %reward% EXP for your efforts.
  wait 1s
  nop %actor.gold(%reward%)%
  %send% %actor% gold:You earn %reward% GOLD for a job well done.
  wait 1s
  %load% obj %thekey% %actor%
  %send% %actor% key:You earn the 0x%thekey% Token Key.
end
~
#1103
R1103 Give Token~
2 g 100
~
set thekey 1103
set thetoken %actor.inventory(%thekey%)%
set thisroom %actor.room.vnum%
set reward 2000
if !%thetoken%
  wait 1s
  nop %actor.exp(%reward%)%
  %send% %actor% exp:You earn %reward% EXP for your efforts.
  wait 1s
  nop %actor.gold(%reward%)%
  %send% %actor% gold:You earn %reward% GOLD for a job well done.
  wait 1s
  %load% obj %thekey% %actor%
  %send% %actor% key:You earn the 0x%thekey% Token Key.
end
~
#1106
R1106 Give Token~
2 g 100
~
set thekey 1106
set thetoken %actor.inventory(%thekey%)%
set thisroom %actor.room.vnum%
set reward 1000
if !%thetoken%
  wait 1s
  nop %actor.exp(%reward%)%
  %send% %actor% exp:You earn %reward% EXP for your efforts.
  wait 1s
  nop %actor.gold(%reward%)%
  %send% %actor% gold:You earn %reward% GOLD for a job well done.
  wait 1s
  %load% obj %thekey% %actor%
  %send% %actor% key:You earn the 0x%thekey% Token Key.
end
~
#1108
R1108 Give Token~
2 g 100
~
set thekey 1108
set thetoken %actor.inventory(%thekey%)%
set thisroom %actor.room.vnum%
set reward 1000
if !%thetoken%
  wait 1s
  nop %actor.exp(%reward%)%
  %send% %actor% exp:You earn %reward% EXP for your efforts.
  wait 1s
  nop %actor.gold(%reward%)%
  %send% %actor% gold:You earn %reward% GOLD for a job well done.
  wait 1s
  %load% obj %thekey% %actor%
  %send% %actor% key:You earn the 0x%thekey% Token Key.
end
~
$~
