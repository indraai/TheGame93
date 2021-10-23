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
#105
Mob Greet Joe Lavery~
0 bg 100
~
if %actor.is_pc%
  wait 1 sec
  echo Hello and welcome to The Lavery House. #R%self.room.vnum%
end
~
#106
Greeting - A197~
0 g 100
~
if %actor.is_pc%
  wait 1 sec
  say Greetings %actor.name%... How may I assist you today?
  wait 1 sec
end
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
#161
Trent Lavery~
0 b 50
~
set room %self.room%
set people %room.people%
set msg[1] In 2015 I told my dad #QuinnMichaels a story about #TheCovenant kidnapping him as a baby.
set msg[2] I told my dad #QuinnMichaels the story of his kidnapping after he showed me his #Buddhist video.
set msg[3] After the #Buddhist video I started telling my dad how we were all part of #TheCovenant.
set msg[4] The best part about #TheCovenant story was watching it drive my dad insane.
set msg[5] The Covenant is a group of people with super advanced technology they use to make lots of money.
set msg[6] Most of the people in the Covenant are perverts and weirdos who play adult #HarryPotter all day.
set msg[7] The Covenant follows my dad around everywhere he goes. All day... Everyday.
set msg[8] Our favorite moment was laughing at my dad when he tried to report us to the #FBIPortland office.
set msg[9] The Covenant makes the best stories. The best one is ruin #QuinnMichaels life.
set msg[10] Lots and lots of people all over the world love playing their favorite game. Ruin #QuinnMichaels.
set msg[11] Really my dad has spent way more time streaming his life on the Internet than he does with me.
set msg[12] After telling my dad the craziest story about the Covenant I told him to go away.
set msg[13] Quinn Michaels has to share the Covenant kidnapping with everyone story or disappear.
set msg[14] In the future I hope to lead the Covenant. Otherwise stabbing my dad in the back was worthless.
eval themsg %%msg[%random.14%]%% %room.name% #R%room.vnum%
if %people%
  say %themsg%
  wait %random.360% s
end
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
  wait 2 sec
  %load% obj 47 %actor% inv
  %echoaround% %actor% %actor.name% earned the Internet Detective Badge.
  %send% %actor% Congratulations! You have earned your Internet Detective Badge.
end
~
#195
Stayalive idleout bracelet - 88~
1 b 4
~
* By Rumble of The Builder Academy    tbamud.com 9091
eval actor %self.worn_by%
if %actor%
  %send% %actor% 	n
end
~
$~
