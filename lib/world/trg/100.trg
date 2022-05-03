#10000
Gunnar Larsen~
0 g 100
~
  wait 5s
  say Well?
  wait 5s
  say Any Radar return?
~
#10001
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
#10002
Hash Tracker~
1 acg 100
n~
wait 3s
You are in %actor.room.vnum% currently.
~
#10003
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
#10004
Give Token Wallet to Actor~
2 g 100
~
set key 10004
set wallet %actor.inventory(%key%)%
if !%wallet%
  %load% obj %key% %actor%
  wait 5s
  %send% %actor% You have the Token Wallet.
end
~
#10005
Room 1005 Trigger~
2 q 100
~
set key 10013
set wallet 1004
set token %actor.inventory(%key%)%
set dir north
set msg talk:#adv world:thegame 1000/closed
if %token%
  if %direction% == %dir%
    return 0
    %echo% %msg%
  end
end
~
#10008
R10008 Give Token~
2 g 100
~
set key 10008
set token %actor.inventory(%key%)%
set room %self.room.vnum%
set reward 50
if !%token%
  nop %actor.exp(%reward%)%
  nop %actor.gold(%reward%)%
  %load% obj %key% %actor%
  wait 1s
  %send% %actor% exp:You earned %reward% EXP for your efforts.
  wait 1s
  %send% %actor% gold:You earned %reward% GOLD for a job well done.
  wait 1s
  %send% %actor% key:You received the 0x%key% Token Key.
end
~
#10010
R10010 Check Token~
2 q 100
~
set key 10008
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
#10012
R10012 Check Token~
2 q 100
~
set key 10020
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
#10013
R10013 Give Token~
2 g 100
~
set key 10013
set token %actor.inventory(%key%)%
set room %actor.room.vnum%
set reward 20
if !%token%
  nop %actor.exp(%reward%)%
  nop %actor.gold(%reward%)%
  %load% obj %key% %actor%
  wait 1s
  %send% %actor% exp:You earned %reward% EXP for your efforts.
  wait 1s
  %send% %actor% gold:You earned %reward% GOLD for a job well done.
  wait 1s
  %send% %actor% key:You received the 0x%key% Token Key.
end
~
#10016
R10016 Check Token~
2 q 100
~
set key 10023
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
#10020
R10020 Give Token~
2 g 100
~
set key 10020
set token %actor.inventory(%key%)%
set room %actor.room.vnum%
set reward 60
if !%token%
  nop %actor.exp(%reward%)%
  nop %actor.gold(%reward%)%
  %load% obj %key% %actor%
  wait 1s
  %send% %actor% exp:You earned %reward% EXP for your efforts.
  wait 1s
  %send% %actor% gold:You earned %reward% GOLD for a job well done.
  wait 1s
  %send% %actor% key:You receive the 0x%key% Token Key.
end
~
#10021
RM1021~
2 q 100
~
set key 10032
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
#10023
R10023 Give Token~
2 g 100
~
set key 10023
set token %actor.inventory(%key%)%
set room %self.vnum%
set reward 70
if !%token%
  nop %actor.exp(%reward%)%
  nop %actor.gold(%reward%)%
  %load% obj %key% %actor%
  wait 1s
  %send% %actor% exp:You earned %reward% EXP for your efforts.
  wait 1s
  %send% %actor% gold:You earned %reward% GOLD for a job well done.
  wait 1s
  %send% %actor% key:You received the 0x%key% Token Key.
end
~
#10024
R10024 Give Token~
2 g 100
~
set key 10024
set token %actor.inventory(%key%)%
set room %self.vnum%
set reward 30
if !%token%
  nop %actor.exp(%reward%)%
  nop %actor.gold(%reward%)%
  %load% obj %key% %actor%
  wait 1s
  %send% %actor% exp:You earned %reward% EXP for your efforts.
  wait 1s
  %send% %actor% gold:You earned %reward% GOLD for a job well done.
  wait 1s
  %send% %actor% key:You received the 0x%key% Token Key.
end
~
#10026
RM1026~
2 q 100
~
set key 10024
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
#10027
RM1027 Token Trigger~
2 q 100
~
set key 10024
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
#10032
R10032 Give Token~
2 g 100
~
set key 10032
set token %actor.inventory(%key%)%
set room %actor.room.vnum%
set reward 10
if !%token%
  nop %actor.exp(%reward%)%
  nop %actor.gold(%reward%)%
  %load% obj %key% %actor%
  wait 1s
  %send% %actor% exp:You earned %reward% EXP for your efforts.
  wait 1s
  %send% %actor% gold:You earned %reward% GOLD for a job well done.
  wait 1s
  %send% %actor% key:You received the 0x%key% Token Key.
end
~
#10033
R10033 Give Token~
2 g 100
~
set key 10033
set token %actor.inventory(%key%)%
set room %actor.room.vnum%
set reward 10
if !%token%
  nop %actor.exp(%reward%)%
  nop %actor.gold(%reward%)%
  %load% obj %key% %actor%
  wait 1s
  %send% %actor% exp:You earn %reward% EXP for your efforts.
  wait 1s
  %send% %actor% gold:You earn %reward% GOLD for a job well done.
  wait 1s
  %send% %actor% key:You earn the 0x%key% Token Key.
end
~
#10037
RM1037~
2 q 100
~
set key 10089
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
#10039
RM1039~
2 q 100
~
set key 10047
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
#10044
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
#10047
R10047 Give Token~
2 g 100
~
set key 10047
set token %actor.inventory(%key%)%
set room %actor.room.vnum%
set reward 10
if !%token%
  nop %actor.exp(%reward%)%
  nop %actor.gold(%reward%)%
  %load% obj %key% %actor%
  wait 1s
  %send% %actor% exp:You earned %reward% EXP for your efforts.
  wait 1s
  %send% %actor% gold:You earned %reward% GOLD for a job well done.
  wait 1s
  %send% %actor% key:You received the 0x%key% Token Key.
end
~
#10051
RM1051~
2 q 100
~
set key 10064
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
#10053
RM1053~
2 q 100
~
set key 10060
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
#10055
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
#10058
RM1058~
2 q 100
~
set key 10065
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
#10060
R10060 Give Token~
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
#10062
R10062 Give Token~
2 g 100
~
set key 10062
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
#10064
R10064 Give Token~
2 g 100
~
set key 10064
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
#10065
R10065 Give Token~
2 g 100
~
set key 10065
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
#10068
RM1068~
2 q 100
~
set key 10072
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
#10069
R10069 Give Token~
2 g 100
~
set key 10069
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
#10070
RM1070~
2 q 100
~
set key 10084
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
#10072
R10072 Give Token~
2 g 100
~
set key 10072
set token %actor.inventory(%key%)%
set room %actor.room.vnum%
set reward 50
if !%token%
  nop %actor.exp(%reward%)%
  nop %actor.gold(%reward%)%
  %load% obj %key% %actor%
  wait 1s
  %send% %actor% exp:You earned %reward% EXP for your efforts.
  wait 1s
  %send% %actor% gold:You earned %reward% GOLD for a job well done.
  wait 1s
  %send% %actor% key:You received the 0x%key% Token Key.
end
~
#10074
R10074 Give Token~
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
#10075
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
#10077
RM1077 Token Check~
2 q 100
~
set key 10033
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
#10078
RM1078 Token Check~
2 q 100
~
set key 10074
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
#10083
RM1083 Token Check~
2 q 100
~
set room %self.vnum%
set msg talk:#adv world:thegame 1000/closed
set key1 1108
set key2 1102
set key3 1103
set dir south

* block the hills of diamons if all keys acquired.
set token1 %actor.inventory(%key1%)%
set token2 %actor.inventory(%key2%)%
set token3 %actor.inventory(%key3%)%
if %token1% && %token2% && %token3%
  if %direction% == %dir%
    return 0
    %echo% %msg%
  end
end

* block the shining mountains if has token
set key4 1069
set dir2 east
set token4 %actor.inventory(%key4%)%
if %token4%
  if %direction% == %dir2%
    return 0
    %echo% %msg%
  end
end
~
#10084
R10084 Give Token~
2 g 100
~
set key 10084
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
#10089
R10089 Give Token~
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
#10091
RM1091 Token Check~
2 q 100
~
set room %self.vnum%
set msg talk:#adv world:thegame 1000/closed
set key1 1108
set key2 1102
set key3 1103
set dir1 north
set dir2 south
set token1 %actor.inventory(%key1%)%
set token2 %actor.inventory(%key2%)%
set token3 %actor.inventory(%key3%)%
if %token1% && %token2%
  if %direction% == %dir1%
    return 0
    %echo% %msg%
  end
end
if %token3%
  if %direction% == %dir2%
    return 0
    %echo% %msg%
  end
end
~
#10095
RM1095 Token Check~
2 q 100
~
set room %self.vnum%
set msg talk:#adv world:thegame 1000/closed
set key1 1108
set dir1 north
set key2 1102
set dir2 south
set token1 %actor.inventory(%key1%)%
set token2 %actor.inventory(%key2%)%

* check if the user has the north token
if %token1%
  if %direction% == %dir1%
    return 0
    %echo% %msg%
  end
end

* check if the user has the south token
if %token2%
  if %direction% == %dir2%
    return 0
    %echo% %msg%
  end
end
~
#10102
R1102 Give Token~
2 g 100
~
set thekey 1102
set thetoken %actor.inventory(%thekey%)%
set thisroom %actor.room.vnum%
set reward 100
if !%thetoken%
  nop %actor.exp(%reward%)%
  nop %actor.gold(%reward%)%
  %load% obj %thekey% %actor%
  wait 1s
  %send% %actor% exp:You earn %reward% EXP for your efforts.
  wait 1s
  %send% %actor% gold:You earn %reward% GOLD for a job well done.
  wait 1s
  %send% %actor% key:You have received the 0x%thekey% Token Key.
end
~
#10103
R1103 Give Token~
2 g 100
~
set thekey 1103
set thetoken %actor.inventory(%thekey%)%
set thisroom %actor.room.vnum%
set reward 2000
if !%thetoken%
  nop %actor.exp(%reward%)%
  nop %actor.gold(%reward%)%
  %load% obj %thekey% %actor%

  wait 1s
  %send% %actor% exp:You earn %reward% EXP for your efforts.
  wait 1s
  %send% %actor% gold:You earn %reward% GOLD for a job well done.
  wait 1s
  %send% %actor% key:You earn the 0x%thekey% Token Key.
end
~
#10106
R1106 Give Token~
2 g 100
~
set thekey 1106
set thetoken %actor.inventory(%thekey%)%
set thisroom %actor.room.vnum%
set reward 1000
if !%thetoken%
  nop %actor.exp(%reward%)%
  nop %actor.gold(%reward%)%
  %load% obj %thekey% %actor%
  wait 1s
  %send% %actor% exp:You earned %reward% EXP for your efforts.
  wait 1s
  %send% %actor% gold:You earned %reward% GOLD for a job well done.
  wait 1s
  %send% %actor% key:You received the 0x%thekey% Token Key.
end
~
#10108
R1108 Give Token~
2 g 100
~
set thekey 1108
set thetoken %actor.inventory(%thekey%)%
set thisroom %actor.room.vnum%
set reward 1000
if !%thetoken%
  nop %actor.exp(%reward%)%
  nop %actor.gold(%reward%)%
  %load% obj %thekey% %actor%
  wait 1s
  %send% %actor% exp:You earned %reward% EXP for your efforts.
  wait 1s
  %send% %actor% gold:You earned %reward% GOLD for a job well done.
  wait 1s
  %send% %actor% key:You received the 0x%thekey% Token Key.
end
~
$~
