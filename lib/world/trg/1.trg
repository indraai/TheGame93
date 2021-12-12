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
Veda Library Agent Greeting 1~
0 g 100
0~
set room %self.room.vnum%
wait 1s
%echo% talk:#twitter tweet:devabuddhism Welcome to the #VedaLibrary #R%room% of #DevaWorld. #Indu #Indra #Deva http://indra.church/rigveda/01.html

wait 5s
say Hello there %actor.name%

wait 5s
say Welcome to Veda Library Room 1.

wait 5s
say The Librarians have put together a collection of materials for study, and reflection.

wait 5s
say If you have any questions remember to ask for help.

wait 5s
say Make sure to pick up your academy lesson plan across the way.

wait 5s
say There are librarians in each of the Library Halls to assist you.

wait 2s
say Have a wonderful day!
~
#118
Veda Library Agent Greeting 2~
0 g 100
0~
set room %self.room.vnum%

wait 1s
%echo% talk:#twitter tweet:devabuddhism Announcing %actor.name% has entered #VedaLibrary in #R%room% of #DevaWorld. #Indu #Indra #Deva http://indra.church/rigveda/02.html

wait 5s
say Greetings %actor.name%

wait 5s
say You have arrived in Library room 2.

wait 5s
say Remember to ask questions.

wait 2s
say Have a wonderful day!
~
#122
Veda Library Agent Greeting 3~
0 g 100
0~
set room %self.room.vnum%

wait 1s
%echo% talk:#twitter tweet:devabuddhism %actor.name% has entered #VedaLibrary #R%room% of #DevaWorld. #Indu #Indra #Deva http://indra.church/rigveda/03.html

wait 5s
say Hi %actor.name%,
wait 5s
say You've made it to Veda Library room 3.

wait 5s
say Looks like you are moving through your studies.

wait 5s
say If you got your Academy lessons your stats will increase as you study.

wait 5s
say If you have questions about the hymns or any of the deities just ask.
~
#127
Mob Act - 156 speaker greet~
0 e 0
has entered the game.~
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
set msg[1] Offerings for Vamraka!
set msg[2] Offerings for Indu!
set msg[3] Offerings for Indra!
set msg[4] Offerings for Soma1
set msg[5] Offerings for Bom!
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
%echo% security:check %vnum%:%name%
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
