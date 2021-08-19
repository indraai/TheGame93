#5713
Mr. Bungle~
0 g 100
~
set room %self.room%
set vnum %room.vnum%
set people %room.people%
set randmsg %random.10%

set msg[1] Have you read the article about me? The Case of #MrBungle and the #CyberRape https://j.mp/37YNfPy
set msg[2] The basic story is that #MrBungle "raped" two other #LambdaMOO characters, #lebga and #Starsinger.
set msg[3] #MrBungle forced #Legba and #Starsinger to perform "sexual acts" against their will on the #MOO.
set msg[4] They also have a #Wikipedia entry for the work of #MrBungle if you are interested. https://j.mp/3D051QK
set msg[5] The #MrBungle assault involved using a complex #VooDoo subprogram https://j.mp/3iYuj9V
set msg[6] Into the night, #Bungle’s doll haunted victims who gathered in the living room.
set msg[7] You hear Mr. Bungle laughing evilly in the distance.
set msg[8] In real life I am pretty boring guy. You can find my personal page here. https://j.mp/3xW4c80
set msg[9] The #MrBungle rape in #Cyberspace was a  psychological thought-polarization. https://j.mp/3D5yBoi
set msg[10] My friends and I secretly snuck a botnet into the #USAF here https://j.mp/3miLAwS

eval themsg %%msg[%randmsg%]%% %room.name% #R%vnum% #MrBungle #Quinn #LambdaMOO #CyberRape #GhostMOO
wait 5 sec
say %themsg%

~
#5730
Scorpion -5730~
0 h 100
~
if %actor.is_pc%
  wait 2 sec
  gossip Have you heard the #GOSSIP said the #Spider to the #Fly!
  wait 10 sec
  gossip The #GOSSIP going around is there was an #EvilQuinn and #GoodQuinn.
  wait 30 sec
  gossip The #GOSSIP going around is there was an #EvilQuinn and #GoodQuinn.
  laugh
  wait 2 sec
  say That is what I am hearing on the #NETWORK.
end
~
#5733
Assassin - NOT ATTACHED~
0 h 100
~
if %actor.is_pc%
  say Hello traveller!
  wait 1 sec
  say how are you?
  wait 1 sec
  say well, now that you've seen me I'll have to kill you...
  wait 1 sec
  mua
  wait 1 sec
  tell %actor% I have failed... you shall survive.
end
~
#5734
Crannasia - 5734~
0 h 100
~
if %actor.is_pc%
  wait 2 sec
  say Welcome traveller
  wait 4 sec
  say how are you faring?
  wait 4 sec
  say well, regardless of that it's time for you to die!
  wait 3 sec
  say goodbye weakling
  wait 2 sec
  mua
  wait 2 sec
  tell %actor% I have failed... you shall survive.
end
~
#5794
Claw - NOT ATTACHED~
1 j 100
~
wait 1 sec
say HEY! I won't serve you!
%purge% self
~
#5799
Near Death Trap Fall - 5707~
2 g 100
~
* Near Death Trap stuns actor
wait 2 sec
set stunned %actor.hitp%
%damage% %actor% %stunned%
wait 2 sec
%send% %actor% You continue to fall... and fall... and fall.
~
$~
