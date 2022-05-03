#0
Non-attachable trigger~
0 g 100
~
* You can't attach trigger 0!
~
#2
indra.academy r2~
2 g 100
~
set msg Welcome to the Indra Academy. Where you learn what you want when you want and how you want based on your current level.
wait 2s
%echo% %msg%
~
#7
Talk to Harry~
0 d 100
*~
wait 1s
%send% %actor% talk:#pandora ask:harry %speech%
~
#8
Talk to Larry~
0 d 100
*~
wait 2s
%send% %actor% talk:#pandora ask:larry %speech%
~
#9
Talk to Barry~
0 d 100
*~
wait 3s
%send% %actor% talk:#pandora ask:larry %speech%
~
#95
Arjika Dayshift~
0 t 100
~
set wakeup %time.hour% == 7
set bedtime %time.hour% == 16
if %wakeup%
  wake
  sit
  wait 30 s
  stand
else if %bedtime%
  mgoto 168
  sit
  wait 60 s
  sleep
end
~
#96
Arjika Nightshift~
0 t 100
~
set wakeup %time.hour% == 15
set bedtime %time.hour% == 8
if %wakeup%
  wake
  sit
  wait 30 s
  stand
else if %bedtime%
  mgoto 168
  sit
  wait 60 s
  sleep
end
~
#97
Outfit Player~
2 g 100
~
if %actor.is_pc%
  wait 2 sec
  if !%actor.eq(light)%
    %load% obj 200 %actor% light
  end
  if !%actor.eq(body)%
    %load% obj 201 %actor% body
  end
  if !%actor.eq(head)%
    %load% obj 202 %actor% head
  end
  if !%actor.eq(legs)%
    %load% obj 203 %actor% legs
  end
  if !%actor.eq(feet)%
    %load% obj 204 %actor% feet
  end
  if !%actor.eq(hands)%
    %load% obj 205 %actor% hands
  end
  if !%actor.eq(arms)%
    %load% obj 206 %actor% arms
  end
  if !%actor.eq(shield)%
    %load% obj 207 %actor% shield
  end
  if !%actor.eq(waist)%
    %load% obj 208 %actor% waist
  end
  if !%actor.eq(rwrist)%
    %load% obj 209 %actor% rwrist
  end
  if !%actor.eq(lwrist)%
    %load% obj 210 %actor% lwrist
  end
  if !%actor.eq(wield)%
    %load% obj 211 %actor% wield
  end
else
  wait 1s
  west
end
~
#98


Mob Act - 98 Teleporter Give~
0 e 0
steps out of space and time.~
if %actor.is_pc%
  if !%actor.eq(*)%
    %load% obj 50 %actor% light
    %load% obj 51 %actor% rfinger
    %load% obj 52 %actor% lfinger
    %load% obj 53 %actor% neck1
    %load% obj 54 %actor% neck2
    %load% obj 55 %actor% body
    %load% obj 56 %actor% head
    %load% obj 57 %actor% legs
    %load% obj 58 %actor% feet
    %load% obj 59 %actor% hands
    %load% obj 60 %actor% arms
    %load% obj 61 %actor% shield
    %load% obj 62 %actor% about
    %load% obj 63 %actor% waist
    %load% obj 64 %actor% rwrist
    %load% obj 65 %actor% lwrist
    %load% obj 66 %actor% wield
    %load% obj 67 %actor% hold
  end
  wait 2 sec
  if !%actor.inventory(82)%
    wait 1 s
    say You are not prepared to travel these realms to their fullest.
    wait 1 s
    say Maybe I can help you.
    %load% obj 82
    give teleporter %actor.name%
    * If the players inventory is full drop it for them.
    if !%actor.inventory(82)%
      drop teleporter
    end
    wait 2 s
    say With this you may teleport to areas that may not be accessible in any other way.
    wait 2 s
    say HELP AREAS
  end
end
~
#99
Obj Command 82 - Teleporter~
1 c 3
teleport~
%send% %actor% You attempt to manipulate space and time.
%echoaround% %actor% %actor.name% attempts to manipulate space and time.
wait 1 sec
set academy 0
set arjika 100
if !%arg%
  *they didnt type a location
  set fail 1
else
  *take the first word they type after the teleport command
  *compare it to a variable above
  eval loc %%%arg.car%%%
  if !%loc%
    *they typed an invalid location
    set fail 1
  end
end
if %fail%
  %send% %actor% You fail.
  %echoaround% %actor% %actor.name% fails.
  halt
end
%echoaround% %actor% %actor.name% seems successful as %actor.heshe% steps into another realm.
%teleport% %actor% %loc%
%force% %actor% look
%echoaround% %actor% %actor.name% steps out of space and time.
~
$~
