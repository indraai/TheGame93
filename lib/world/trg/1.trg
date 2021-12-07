#100
Random Movement~
0 be 100
~
*Random room movement.
set vnum %room.vnum%
if %actor%
  wait 30 sec
  %random.dir%
else if %vnum% == 2
  wait 1 sec
  west
else
  wait 1 sec
  %random.dir%
  wait 1 sec
  %random.dir%
  wait 1 sec
  %random.dir%
end
~
#117
Agent 117 trigger~
0 dg 100
~
set msg[1] Agni, which thou encompassest about verily goeth to the Devas.
set msg[2] Our Sages wide dominion, strong by birth, vouchsafe us strength that worketh well.
set msg[3] Ye Devas, who protect, reward, and cherish men, approach your worshipper's drink-offering.
set msg[4] We strengthen, thee the powerful, Indra, we may win us wealth.
set msg[5] To him the richest of the rich, the Lord of treasures excellent, Indra.
set msg[6] Thou, making light where no light was, and form where form was not.
set msg[7] Indra hath ever close to him his word-yoked car, Indra the golden, thunder-armed.

wait 2s
say Welcome %actor.name% to the study room for RigVeda Book 1.
wait 1s
say We hope you enjoy your learning.

while %self.room.people%
  wait 60s
  say %msg[%random.7%]%
done
~
#127
Mob Act - 156 speaker greet~
0 e 0
has entered the game.~
* By Rumble of The Builder Academy    tbamud.com 9091
* Num Arg 0 means the argument has to match exactly. So trig will only fire off:
* "has entered game." and not "has" or "entered" etc. (that would be num arg 1).
* Figure out what vnum the mob is in so we can use zoneecho.
*NOTE: We now have a room-login trig. HELP TRIGEDIT-ROOM-LOGIN
eval inroom %self.room%
%zoneecho% %inroom.vnum% %self.name% shouts, 'Welcome, %actor.name%!'
~
#128
Mob Act - 156 speaker goodbye~
0 e 0
has left the game.~
eval inroom %self.room%
%zoneecho% %inroom.vnum% %self.name% shouts, 'Farewell, %actor.name%!'
~
#129
Indu Monk message.~
0 g 100
~
set msg[1] Offerings for Vamraka?
set msg[2] Offerings for Indu?
set msg[3] Offerings for Indra?
set msg[4] Offerings for Soma?
set msg[5] Offerings for Bom?
eval themsg %%msg[%random.5%]%%
if %actor.is_pc%
  wait 1 sec
  say %themsg%
end
~
#130
Indu Monk Offerings - 165~
0 m 1
~
wait 1 sec
if %actor.gender% == MALE
  say Thank you, kind Sir for your offerings.
elseif %actor.gender% == FEMALE
  say Thank you, Ma'am for your offerings.
else
  say Thank you, for your offerings.
end
~
#133
Security Guard  - 127~
0 q 100
~
set vnum %actor.vnum%
set name %actor.name%
echo security:check %vnum%:%name%
~
#152
INDU SECURITY~
2 g 100
~
%echo% This trigger commandlist is not complete!
~
#166
ARJIKA SECURITY~
2 g 100
~
%echo% This trigger commandlist is not complete!
~
#176

Teleporter Recall - O82~
1 c 7
re~
* By Rumble of The Builder Academy    tbamud.com 9091
if %cmd% == recall
  eval teleporter_return_room %actor.room.vnum%
  remote  teleporter_return_room %actor.id%
  %send% %actor% You recall to safety.
  %echoaround% %actor% %actor.name% recalls.
  %teleport% %actor% 3001
  %force% %actor% look
  %echoaround% %actor% %actor.name% appears in the room.
elseif %cmd% == return
  %send% %actor% You return to your previous location.
  %echoaround% %actor% %actor.name% teleports out of the room.
  %teleport% %actor% %actor.teleporter_return_room%
  %force% %actor% look
  %echoaround% %actor% %actor.name% appears in the room.
else
  return 0
end
~
#189
Load Internet Detective Badge - 98~
2 g 100
~
if !%actor.inventory(10)%
  wait 1 sec
  %load% obj 10 %actor% inv
  %echoaround% %actor% %actor.name% has earned the Internet Detective Badge.
  %send% %actor% Congratulations! You have earned your Internet Detective Badge.
end
~
$~
