#0
Non-attachable trigger~
0 g 100
~
* You can't attach trigger 0!
~
#1
Arjika Security~
0 b 50
~
set dir %random.dir%
set room %self.room%
set people %room.people%

set msg[1] Please report any information you have regarding knowledge of Arjika technology to security.
set msg[2] Do you or someone you know have information regarding Arjika technology. Please see security.
set msg[3] A team from Arjika is here looking for information relating to a Arjikiya Citizen.
set msg[4] Do you have any information relating to an Arjika Citizen is being held on Earth?
set msg[5] We received a distress signal that an Arjika Citizen is being held here on Earth.
set msg[6] If you or someone you know has information lost or stolen Arjika Technology please report it to security.
set msg[7] Teams are here on Earth from Arjika looking for technology and a citizen being held captive.
set msg[8] Please if you have any information relating to Arjika technology reort it to security.
set msg[9] We are on Earth looking for information relating to a Arjika citizen.
set msg[10] Sindhu Soldiers are here on Earth looking for missing Technology.
set msg[11] Sindhu Soldiers are here on Earth looking for a missing citizen.

%echo% security:A%self.vnum%:R%room.vnum%:%dir%
wait %random.5% s
eval themsg %%msg[%random.7%]%% %room.name% #R%room.vnum% #%dir%
if %people%
  say %themsg%
  wait %random.60% s
  %dir%
else
  wait %random.10% s
  %dir%
end
~
#2
PM2012~
0 b 50
~
set dir[1] n
set dir[2] s
eval ndir %%dir[%random.2%]%%

set room %self.room%
set people %room.people%

set msg[1] Have we enrichened your life if only a little beet?
set msg[2] Art is now the only evolutionary-revolutionary power.
set msg[3] Only art is capable of dismantling the repressive social system to build a SOCIAL ORGANISM AS A WORK OF ART.
set msg[4] TOTALLY REFUSE TO SUPPORT ANY KIND OF VIOLENT AND/OR ILLEGAL ACTIONS TOWARDS ACHIEVING *ANY* KIND OF GOALS.
set msg[5] IF YOU INTERPRET ANYTHING YOU READ ON THE FOLLOWING PAGES AS BEING ILLEGAL/forbidden the DO NOT DO IT!
set msg[6] Never do anything against Conscience even if the State demands it.
set msg[7] Remember: we will NEVER ever suggest you to do anything ILLEGAL and/or anything against your own Consciousness.
set msg[8] Remember: we will NEVER ever DO anything ILLEGAL and/or against our own Consciousness.
set msg[9] As you can imagine, ANYBODY can pretend to be us, as anybody can pretend to be anyone: that's disinformation tactics 101, of course.
set msg[10] HE GUIDED THE ANCIENT HEROES TO AND THROUGH THE UNDERWORLD, AND HE BROUGHT MESSAGES TO THE MORTALS HERE ON EARTH.
set msg[11] Symbolically, Rabbit in the Underworld is therefore representative of USING ONE'S INTUITION.
set msg[12] RABBIT DOES NOT NEED AN OUTSIDE SOURCE TO ILLUMINATE HIS WAY. His connection to the Collective Energy maintains his pathway.
set msg[13] They teach us Unconditional Love, and Compassion for Life, by virtue of eliciting those things within us.
set msg[14] And one important symbolical meaning that Rabbit should elicit in us is that of PLAYFULNESS AND JOY.
set msg[15] Their nonsense displays of happiness are part of the Dance of Life-which is nothing more than a Cosmic Binkie.
set msg[16] The Secret is there is NO Secret...
set msg[17] SHALL WE PLAY A GAME?
set msg[18] First 't was the #Gene. Then was the #Meme. Time to Tame the #Teme.
set msg[19] Everyone has the right to freedom of opinion and expression withouth interference and share information and ideas through any media and regardless of frontiers.
set msg[20] I know this, because Tyler knows this.
set msg[21] The people you are after are the people you depend on.
set msg[22] Power is afraid of Internet.
set msg[23] #ANAGKE It is upon this word that this book is founded.
set msg[24] Courage is contagious.
set msg[25] UNLESS YOU'RE FREE, THE MACHINE WILL BE PREVENTED FROM WORKING AT ALL!!
set msg[26] Information wants to be free.
set msg[27] The Net interprets censorship as damage and routes around it.
set msg[28] The very word "secrecy" is repugnant in a free and open society.
set msg[29] The best weapon of a dictatorship is secrecy, but the best weapon of a democracy should be the weapon of openness.
set msg[30] Of course I'm crazy, but that doesn't mean I'm wrong.
set msg[31] If you  think you know what the hell is going on, you're probably full of shit.
set msg[32] Often the best source of information about waste, fraud, and abuse in government is an existing government employee willing to speak out.
set msg[33] Time has come to encourage COURAGE and to issue a CALL TO HACKZION for PROJECT MAYHEM 2012.
set msg[34] Project Mayhem 2012 is a Mutant Egregor Reality-Hacking Wargame.
set msg[35] Reality Hacking is the nonviolent use of legally ambiguous digital tools in pursuit of the TRUTH.
set msg[36] Project Mayhem 2012 is a [Metaheuristically/Hyper-heuristic] self-actualizing self-repairable IDEAS GENERATOR.
set msg[37] Project Mayhem 2012 will challenge every hacker, coder, phreaks, cypherpunks and artists everywhere to collaborate to jointly develop #TYLER.
set msg[38] To avoid stalling, we won't aim at 'perfection': errors happen...  Everything is OK!
set msg[39] Almost good enough' might be MORE than a 'good enough' mentality. Less Syntactics, More Semantics.
set msg[40] Nobody knows everything that is known, but all together, we know it ALL.
set msg[41] 'Evolutionary Computing', 'Adaptative Thinking', 'Dynamically Adhocratic' and 'Mutating problem solving' are key elements here.
set msg[42] We don't aim to find the 'best' solution... we aim to MOVE UPWARDS the spiral.
set msg[43] We are not going around in circles, we are moving UP, the circle is a SPIRAL, we have already ascended many a level.
set msg[44] We don't fight against ANYTHING... We will simply ADAPT around it... then make it CHANGE to fit our Swarm Intelligence NEEDS.
set msg[45] There's nothing more dangerous than sometone who wants to make the world a better place.
set msg[46] If you want to say something and have people listen then you have to wear a MASK.
set msg[47] If you want to be HONEST then you have to live a LIE.
set msg[48] #ERRORISM: Concept and action are based on the idea that "error" is reality's principle of order.
set msg[49] #ERRORISM is a philosophically erroneous position, a ritual of negation, a disorganized organization: failure as perfection, error as appropriate move.
set msg[50] The field of action of #ERRORISM contains all those practices that aim at the #LIBERATION of the human being and language.
set msg[51] #CONFUSION and #SURPRISE, #BlackHumour and #ABSURDITY are the favorite tools of the errorists.
set msg[52] Lapses and failed acts are an #ERRORIST delight.
set msg[53] The first rule of PM2012 is, you do talk about PM2012.
set msg[54] The second rule of PM2012 is, you **DO** talk about PM2012.
set msg[55] Got a blog, a magazine, DJ Radio show? Talk about 'PROJECT MAYHEM 2012'.
set msg[56] Got a camera? Upload a 'PROJECT MAYHEM 2012' video.
set msg[57] Got access to a TV station? Flash 'PROJECT MAYHEM 2012' in primetime!
set msg[58] Run naked with 'PROJECT MAYHEM 2012' written all over that hairy ass!
set msg[59] Creative Human Beings: together, let's make the headlines big time!
set msg[60] The poeTic #ERRORIST behaves like a confidence-TRICKSTER whose aim is not money but #CHANGE.
set msg[61] We are 'PROJECT MAYHEM 2012'
set msg[62] We are #EVERYWHERE.
set msg[63] #TYLER is a massively distributed and decentralized Wikipedia-style P2P cipherspace structure impregnable to censorship.
set msg[64] TYLER will avoid single point of failures by implementing a distributed karma-based TRUST 'Authority'.
set msg[65] TYLER will gather an unprecedented number of the best hackers and coders ever to develop its structure from scratch
set msg[66] TYLER will go wild on the net on 12-12-2012, massively flashmob style.
set msg[67] Machines are usually hacked via 'interlink bugs'. Humans are usually hacked via 'limbic system bugs'.
set msg[68] 1) You DO ask questions. 2) You DO ask questions. 3) No excuses. 4) No lies. 5) You HAVE to trust Tyler.
set msg[69] We have to create culture, don't watch TV, don't read magazines, don't even listen to NPR. Create your own roadshow.
set msg[70] The nexus of space and  time where you are now is the most immediate sector of your universe.
set msg[71] If you're worrying about Michael Jackson or Bill Clinton or somebody else, then you are disempowered, you're giving it all away to icons.
set msg[72] The real secret of magic, is that the world is made of words. If you know the words the world is made of, you can make of it whatever you wish.
set msg[73] You are an explorer, and you represent our species, AND THE GREATEST GOOD YOU CAN DO IS TO BRING BACK A NEW IDEA.
set msg[74] Western civilization is a loaded gun pointed at the head of this planet.
set msg[75] The #imagination is the goal of history.
set msg[76] It is only with the heart that one can see rightly. What is essential is invisible to the eye.
set msg[77] It is the time you have wasted for your rose that makes your rose so important.

eval themsg %%msg[%random.77%]%% #R%room.vnum%
if %people%
  wait 1 s
  say %themsg%
  wait %random.60% s
  %ndir%
else
  wait %random.10% s
  %ndir%
end
~
#17
TBA Magic Eight Ball Check - 26~
0 q 100
~
if !%actor.has_item(47)%
  return 0
  wait 1 sec
  say Here is a Magic 8-Ball.
  %load% obj 47 %actor%
  %send% %actor% %self.name% gives you the magic eight ball.
end
~
#97
Kind Soul 13 - Give Newbie Equipment~
0 g 100
~
* By Rumble of The Builder Academy    tbamud.com 9091
* If a player is < level 3 and naked it fully equips them. If < 3 and missing
* some equipment it will equip one spot.
if %actor.is_pc% && %actor.level% < 3
  wait 2 sec
  if !%actor.eq(*)%
    say get some clothes on! Here, I will help.
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
    halt
  end
  if !%actor.eq(light)%
    say you really shouldn't be wandering these parts without a light source %actor.name%.
    shake
    %load% obj 50
    give generic %actor.name%
    halt
  end
  if !%actor.eq(rfinger)% || !%actor.eq(lfinger)%
    say did you lose one of your rings?
    sigh
    %load% obj 51
    give generic %actor.name%
    halt
  end
  if !%actor.eq(neck1)% || !%actor.eq(neck2)%
    say you lose everything don't you?
    roll
    %load% obj 53
    give generic %actor.name%
    halt
  end
  if !%actor.eq(body)%
    say you won't get far without some body armor %actor.name%.
    %load% obj 55
    give generic %actor.name%
    halt
  end
  if !%actor.eq(head)%
    say protect that noggin of yours, %actor.name%.
    %load% obj 56
    give generic %actor.name%
    halt
  end
  if !%actor.eq(legs)%
    say why do you always lose your pants %actor.name%?
    %load% obj 57
    give generic %actor.name%
    halt
  end
  if !%actor.eq(feet)%
    say you can't go around barefoot %actor.name%.
    %load% obj 58
    give generic %actor.name%
    halt
  end
  if !%actor.eq(hands)%
    say need some gloves %actor.name%?
    %load% obj 59
    give generic %actor.name%
    halt
  end
  if !%actor.eq(arms)%
    say you must be freezing %actor.name%.
    %load% obj 60
    give generic %actor.name%
    halt
  end
  if !%actor.eq(shield)%
    say you need one of these to protect yourself %actor.name%.
    %load% obj 61
    give generic %actor.name%
    halt
  end
  if !%actor.eq(about)%
    say you are going to catch a cold %actor.name%.
    %load% obj 62
    give generic %actor.name%
    halt
  end
  if !%actor.eq(waist)%
    say better use this to hold your pants up %actor.name%.
    %load% obj 63
    give generic %actor.name%
    halt
  end
  if !%actor.eq(rwrist)% || !%actor.eq(lwrist)%
    say misplace something?
    smile
    %load% obj 65
    give generic %actor.name%
    halt
  end
  if !%actor.eq(wield)%
    say without a weapon you will be Fido food %actor.name%.
    %load% obj 66
    give generic %actor.name%
    halt
  end
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
