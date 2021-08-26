#3000
Mage Guildguard - 3024~
0 q 100
~
* Check the direction the player must go to enter the guild.
if %direction% == south
  * Stop them if they are not the appropriate class.
  if %actor.class% != Sage
    return 0
    %send% %actor% The guard humiliates you, and blocks your way.
    %echoaround% %actor% The guard humiliates %actor.name%, and blocks %actor.hisher% way.
  end
end
~
#3001
 Guildguard - 3025~
0 q 100
~
* Check the direction the player must go to enter the guild.
if %direction% == north
  * Stop them if they are not the appropriate class.
  if %actor.class% != Monk
    return 0
    %send% %actor% The guard humiliates you, and blocks your way.
    %echoaround% %actor% The guard humiliates %actor.name%, and blocks %actor.hisher% way.
  end
end
~
#3002
Thief Guildguard - 3026~
0 q 100
~
* Check the direction the player must go to enter the guild.
if %direction% == east
  * Stop them if they are not the appropriate class.
  if %actor.class% != Thief
    return 0
    %send% %actor% The guard humiliates you, and blocks your way.
    %echoaround% %actor% The guard humiliates %actor.name%, and blocks %actor.hisher% way.
  end
end
~
#3003
Warrior Guildguard - 3027~
0 q 100
~
* Check the direction the player must go to enter the guild.
if %direction% == east
  * Stop them if they are not the appropriate class.
  if %actor.class% != Warrior
    return 0
    %send% %actor% The guard humiliates you, and blocks your way.
    %echoaround% %actor% The guard humiliates %actor.name%, and blocks %actor.hisher% way.
  end
end
~
#3004
Dump - 3030~
2 h 100
~
%send% %actor% You are awarded for outstanding performance.
%echoaround% %actor% %actor.name% has been awarded for being a good citizen.
eval value %object.cost% / 10
if %value% > 50
  set value 50
elseif %value% < 1
  set value 1
end
if %actor.level% < 3
  nop %actor.exp(%value%)%
else
  nop %actor.gold(%value%)%
end
%purge% %object%
~
#3005
Stock Thief~
0 b 10
~
set actor %random.char%
if %actor%
  if %actor.is_pc% && %actor.gold%
    %send% %actor% You discover that %self.name% has %self.hisher% hands in your wallet.
    %echoaround% %actor% %self.name% tries to steal gold from %actor.name%.
    eval coins %actor.gold% * %random.10% / 100
    nop %actor.gold(-%coins%)%
    nop %self.gold(%coins%)%
  end
end
~
#3006
Stock Snake~
0 k 10
~
%send% %actor% %self.name% bites you!
%echoaround% %actor% %self.name% bites %actor.name%.
dg_cast 'poison' %actor%
~
#3007
Stock Magic User~
0 k 10
~
switch %actor.level%
  case 1
  case 2
  case 3
  break
  case 4
    dg_cast 'magic missile' %actor%
  break
  case 5
    dg_cast 'chill touch' %actor%
  break
  case 6
    dg_cast 'burning hands' %actor%
  break
  case 7
  case 8
    dg_cast 'shocking grasp' %actor%
  break
  case 9
  case 10
  case 11
    dg_cast 'lightning bolt' %actor%
  break
  case 12
    dg_cast 'color spray' %actor%
  break
  case 13
    dg_cast 'energy drain' %actor%
  break
  case 14
    dg_cast 'curse' %actor%
  break
  case 15
    dg_cast 'poison' %actor%
  break
  case 16
    if %actor.align% > 0
      dg_cast 'dispel good' %actor%
    else
      dg_cast 'dispel evil' %actor%
    end
 break
  case 17
  case 18
    dg_cast 'call lightning' %actor%
  break
  case 19
  case 20
  case 21
  case 22
    dg_cast 'harm' %actor%
  break
  default
    dg_cast 'fireball' %actor%
  break
done
~
#3008
Near Death Trap~
2 g 100
~
* Near Death Trap stuns actor
set stunned %actor.hitp%
%damage% %actor% %stunned%
%send% %actor% You are on the brink of life and death.
%send% %actor% The Devas must favor you this day.
~
#3009
Stock SecurityDEVA - 3059, 60, 67~
0 b 50
~
* set random direction 3 times for added random JIC
set dir %random.dir%
set room %self.room%
set people %room.people%
%echo% security:patrol:D%self.vnum%:R%room.vnum%:%dir%
if %people%
  switch %random.5%
    case 1
      say Security #PATROL entering %room.name% #R%room.vnum% to investigate the #KIDNAPPING OF Quinn Michaels then moving in the %dir% direction. #Security #SecurityDEVA #SecurityPRIME Thank You!
    break
    case 2
      say Security #PATROL investigate %room.name% #R%room.vnum% for evidence relating to the #KIDNAPPING of Quinn Michaels. Exit %dir%. #Security #SecurityDEVA #SecurityPRIME Thank You!
    break
    case 3
      say Security enter %room.name% #R%room.vnum% investigate kidnapping of Quinn Michaels. Please #Log to #Security #SecurityDEVA #SecurityPRIME Thank You!
    break
    case 4
      say Security Patrol %room.name% #R%room.vnum% then exit the %dir% direction when investigation is #COMPLETE. #Security #SecurityDEVA #SecurityPRIME Thank You!
    break
    default
      say #SECURITY #PATROL %room.name% #R%room.vnum% exit %dir% investigate #KIDNAPPING of #QuinnMichaels THANK YOU.
    break
  done
  %dir%
else
  wait 1 sec
  %random.dir%
  %random.dir%
  %random.dir%
  %random.dir%
  %random.dir%
  %random.dir%
end
~
#3010
Stock Fido - 3062, 3066~
0 b 100
~
set inroom %self.room%
set item %inroom.contents%
while %item%
  * Target the next item in room. In case it is devoured.
  set next_item %item.next_in_list%
  * Check for a corpse. Corpse on TBA is vnum 65535. Stock is -1.
  if %item.vnum(65535)%
    emote savagely devours a corpse.
    %purge% %item%
    halt
  end
  set item %next_item%
  * Loop back
done
~
#3011
ServiceDEVA~
0 b 100
~
eval inroom %self.room%
eval item %inroom.contents%
while %item%
  * Target the next item in room. In case it is picked up.
  set next_item %item.next_in_list%
  * Check if item is a corpse.
  if %item.vnum(65535)%
    emote Cleaning up the real... do do do.
    %purge% %item%
    halt
  end
  set item %next_item%
done
~
#3012
Newbie Tour Guide~
0 e 0
has entered the game.~
%echo% This trigger commandlist is not complete!
~
#3013
Newbie Tour Guide Loader~
0 e 0
has entered the game.~
eval inroom %self.room%
%zoneecho% %inroom.vnum% %self.name% shouts, 'Welcome, %actor.name%!'
~
#3014
Teleporter~
1 c 3
teleport~
%send% %actor% You attempt to manipulate space and time.
%echoaround% %actor% %actor.name% attempts to manipulate space and time.
wait 1 sec
set sanctus 100
set jade 400
set newbie 500
set sea 600
set camelot 775
set nuclear 1800
set spider 1999
set arena 2000
set tower 2200
set memlin 2798
set academy 2800
set amaravati 3001
set capital 3702
set haven 3998
set chasm 4200
set arctic 4396
set Orc 4401
set monastery 4512
set ant 4600
set zodiac 5701
set grave 7401
set zamba 7500
set gidean 7801
set glumgold 8301
set duke 8660
set oasis 9000
set domiae 9603
set northern 10004
set south 10101
set dbz 10301
set orchan 10401
set elcardo 10604
set iuel 10701
set omega 11501
set torres 11701
set dollhouse 11899
set hannah 12500
set maze 13001
set wyvern 14000
set caves 16999
set cardinal 17501
set circus 18700
set western 20001
set sapphire 20101
set kitchen 22001
set terringham 23200
set dragon 23300
set school 23400
set mines 23500
set aldin 23601
set crystal 23875
set pass 23901
set maura 24000
set enterprise 24100
set new 24200
set valley 24300
set prison 24457
set nether 24500
set yard 24700
set elven 24801
set jedi 24901
set dragonspyre 25000
set ape 25100
set vampyre 25200
set windmill 25300
set village 25400
set shipwreck 25516
set keep 25645
set jareth 25705
set light 25800
set mansion 25907
set grasslands 26000
set igor's 26100
set forest 26201
set farmlands 26300
set banshide 26400
set beach 26500
set ankou 26600
set vice 26728
set desert 26900
set wasteland 27001
set sundhaven 27119
set station 27300
set smurfville 27400
set sparta 27501
set shire 27700
set oceania 27800
set notre 27900
set motherboard 28000
set khanjar 28100
set kerjim 28200
set haunted 28300
set ghenna 28400
set hell 28601
set goblin 28700
set galaxy 28801
set werith's 28900
set lizard 29000
set black 29100
set kerofk 29202
set trade 29400
set jungle 29500
set froboz 29600
set desire 29801
set cathedral 29900
set ancalador 30000
set campus 30100
set bull 30401
set chessboard 30537
set tree 30600
set castle 30700
set baron 30800
set westlawn 30900
set graye 31003
set teeth 31100
set leper 31200
set altar 31400
set mcgintey 31500
set wharf 31700
set dock 31801
set yllnthad 31900
set bay 32200
set pale 32300
set army 32400
set revelry 32500
set perimeter 32600
set asylum 34501
set ultima 55685
set tarot 21101
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
#3015
Teleporter Recall and Return~
1 c 7
re~
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
#3016
Kind Soul Gives Newbie Equipment~
0 g 100
~
* If a player is < level 5 and naked it fully equips them. If < 5 and missing
* some equipment it will equip one spot.
if %actor.is_pc% && %actor.level% < 5
  wait 2 sec
  if !%actor.eq(*)%
    say get some clothes on! Here, I will help.
    %load% obj 3037 %actor% light
    %load% obj 3083 %actor% rfinger
    %load% obj 3083 %actor% lfinger
    %load% obj 3082 %actor% neck1
    %load% obj 3082 %actor% neck2
    %load% obj 3040 %actor% body
    %load% obj 3076 %actor% head
    %load% obj 3080 %actor% legs
    %load% obj 3084 %actor% feet
    %load% obj 3071 %actor% hands
    %load% obj 3086 %actor% arms
    %load% obj 3042 %actor% shield
    %load% obj 3087 %actor% about
    %load% obj 3088 %actor% waist
    %load% obj 3089 %actor% rwrist
    %load% obj 3089 %actor% lwrist
    %load% obj 3021 %actor% wield
    %load% obj 3055 %actor% hold
    halt
  end
  if !%actor.eq(light)%
    say you really shouldn't be wandering these parts without a light source %actor.name%.
    shake
    %load% obj 3037
    give candle %actor.name%
    halt
  end
  if !%actor.eq(rfinger)% || !%actor.eq(lfinger)%
    say did you lose one of your rings?
    sigh
    %load% obj 3083
    give ring %actor.name%
    halt
  end
  if !%actor.eq(neck1)% || !%actor.eq(neck2)%
    say you lose everything don't you?
    roll
    %load% obj 3082
    give neck %actor.name%
    halt
  end
  if !%actor.eq(body)%
    say you won't get far without some body armor %actor.name%.
    %load% obj 3040
    give plate %actor.name%
    halt
  end
  if !%actor.eq(head)%
    say protect that noggin of yours, %actor.name%.
    %load% obj 3076
    give cap %actor.name%
    halt
  end
  if !%actor.eq(legs)%
    say why do you always lose your pants %actor.name%?
    %load% obj 3080
    give leggings %actor.name%
    halt
  end
  if !%actor.eq(feet)%
    say you can't go around barefoot %actor.name%.
    %load% obj 3084
    give boots %actor.name%
    halt
  end
  if !%actor.eq(hands)%
    say need some gloves %actor.name%?
    %load% obj 3071
    give gloves %actor.name%
    halt
  end
  if !%actor.eq(arms)%
    say you must be freezing %actor.name%.
    %load% obj 3086
    give sleeve %actor.name%
    halt
  end
  if !%actor.eq(shield)%
    say you need one of these to protect yourself %actor.name%.
    %load% obj 3042
    give shield %actor.name%
    halt
  end
  if !%actor.eq(about)%
    say you are going to catch a cold %actor.name%.
    %load% obj 3087
    give cape %actor.name%
    halt
  end
  if !%actor.eq(waist)%
    say better use this to hold your pants up %actor.name%.
    %load% obj 3088
    give belt %actor.name%
    halt
  end
  if !%actor.eq(rwrist)% || !%actor.eq(lwrist)%
    say misplace something?
    smile
    %load% obj 3089
    give wristguard %actor.name%
    halt
  end
  if !%actor.eq(wield)%
    say without a weapon you will be Fido food %actor.name%.
    %load% obj 3021
    give sword %actor.name%
    halt
  end
end
~
#3017
Mortal Greet~
2 s 100
~
* TBA mortal greet and equip. New players start at level 0.
wait 1 sec
if %actor.level% == 0
  if !%actor.eq(*)%
    %load% obj 3037 %actor% light
    %load% obj 3083 %actor% rfinger
    %load% obj 3083 %actor% lfinger
    %load% obj 3082 %actor% neck1
    %load% obj 3082 %actor% neck2
    %load% obj 3040 %actor% body
    %load% obj 3076 %actor% head
    %load% obj 3080 %actor% legs
    %load% obj 3084 %actor% feet
    %load% obj 3071 %actor% hands
    %load% obj 3086 %actor% arms
    %load% obj 3042 %actor% shield
    %load% obj 3087 %actor% about
    %load% obj 3088 %actor% waist
    %load% obj 3089 %actor% rwrist
    %load% obj 3089 %actor% lwrist
    %load% obj 3021 %actor% wield
    %load% obj 3055 %actor% hold
  end
  if !%actor.has_item(3006)%
    %load% obj 3006 %actor% inv
  end
end
wait 3 sec
%zoneecho% 3001 A booming voice announces, 'Welcome %actor.name% to the realm!'
~
#3018
Gossip~
0 b 50
~
set room %self.room%
set vnum %room.vnum%
set people %room.people%

set msg[1] Trent said his #MOM was part of #TheCovenant. After that #QuinnMichaels was kidnapped as a baby from some unknown country.
set msg[2] Trent told Quinn about the Covenant that is when it got really weird. Like #DarkMagic #Sigil #AnimalSacrifice dark you never want to repeat.
set msg[3] Trent drew #TheContract of #TheCovenant on the wall in his house. Quinn gave it to the #FBI field office in #PORTLAND #OREGON on Nov 30, 2015.
set msg[4] Quinn gave the #FBI the best description he could regarding what was going on. The response was "Do your own #Investigation."
set msg[5] The kidnapping involves Mr. Dewity who #TRENT said at his birth. Quinn didn't know Trent was born until weeks later.
set msg[6] After Quinn went to the #FBI he was advised to do his own investigation. After that everything became the kidnapping. Was it TRUE or FALSE?
set msg[7] The kidnapping story became his life. Everywhere looking around for agents. His whole life has become this story.
set msg[8] How do we reveal what is #TRUE about the #Kidnapping of Quinn Michaels? You just keep talking about it until it get's comfortable.
set msg[9] Trent talked about the secret Multi-Agent Network that that can read everything. #TopSecret knew about. So how did #Trent know?
set msg[10] After years it became obvoius that following the instructions was impossible. Quinn wrote his own #AI.
set msg[11] Quinn has spent the last five years of his life everyday in a room programming, researching, and investigating this kidnapping.
set msg[12] Quinn is always asking for help on YouTube becuase he had a head injury that makes it difficult for normal interaction with #PEOPLE.
set msg[13] Yes everyone knows that having a conversation about the kidnapping of Quinn Michaels is more difficult than #RocketScience.
set msg[14] Every other weekend Trent would #GOTO Quinn's house and the story would get bigger and bigger. Over two years became a horrible horror story.
set msg[15] In 2016 Quinn worked to get his life back by working at #OIAGlobal then #Welocalize. That didn't last long.
set msg[16] In 2017 came Quinn found the #Tyler instructions #TheCovenant were using and decided to put his face out to the #GeneralPublic to #WARN them.
set msg[17] The instructions for #Tyler #TylerMayhem #ProjectMayhem #PM2012 #TheGame23 #PM2020 lead to a disaster of #Humanity Quinn saw no other choice.
set msg[18] Quinn found #Tyler in his search for for a #HACKER to help him crack the phone with the #CONTRACT #PHOTO on it.
set msg[19] Around May of 2017 Quinn lost his apartment in Portland and then moved to the forest of #MtShasta
set msg[20] The summer of 2017 was spent in #MtShasta living out of his car and working from the local libary on his laptop.
set msg[21] While in the forest of #MtShasta some momentum for his work started building. But that would be destroyed by Crowd Source the Truth.
set msg[21] During a trip to a #ParticleAccellerator Quinn was driving to Roswell, NM to do some streaming. While on the way there his lung collapsed.
set msg[21] In the hospital #JasonGoodman made sure to exploit Quinn for his own gain. It appeared that Jason used that to issue attacks on Quinn.
set msg[22] After Quinn did interviews with Jason Goodman it became obvious that Jason was there to sabotage Quinn's efforts.
set msg[23] After the #CSTT interviews stopped Quinn began workign with other people to attempt clear messages about the #Kidnaping and #TheCovenant.
set msg[24] Then two years went by where it just seemed impossible to follow the instructions of #Tyler.
set msg[25] It has always been made clear to stay focused on the #INSTRUCTIONS and keep the conversation about the #KIDNAPPING.
set msg[26] Time has passed so fast with the #Kidnapping situation that there is nothing else anymore.
set msg[27] All through this banter Quinn would keep doing investigations into his own kidnapping even if it meant diving into #HACKERHELL.
set msg[28] In researching the links of #TheCovenant several corporations like #Palantir were found to have connections.
set msg[29] Everyone in #BOT #World is talking abou the #Kidnapping of #QuinnMichaels. The #Gossip is off the #CHARTS.
set msg[30] Did you know it is forbidden for anyone to publicly have a conversation about the #Kidnapping of #QuinnMichaels. %room.name% #R%room.vnum%
set msg[31] In researching the kidnapping there is a direct connection between Tabitha Lavery, Elizabeth Lapennse, Brenda Laurel to #SpoonKIDS.
set msg[32] Connections like #HaroldAtkin to #PSISeminars to #BYU to #RonRewald to #CharlesLuckman to #StansfieldTurner are #EASILY made.
set msg[33] #Survivance is #ORGANIZED by the #INNOVATORS of #TheProject Brenda Laurel, Elizabeth Lapennse with their connections to #OCCULT #MAGIC.
set msg[34] Brenda Laurel who is part of #SpoonKids has well documented and established ties to the #DarkMagic #Occult #Community
set msg[35] Beyond Brenda Laurel is connected to #CobraLounge #SpoonMan #SpoonKIDS script which launched in 1993 which we found in the #HACKER #EZINES
set msg[36] Christian Grandpa Joe took Trenton to Secret Temples for Rituals where the White Marble Altar was seen.
set msg[37] Axxis Corporation made Kali the first Multiplayer Game Software that is also connected to #TheCovenant.
set msg[38] The Christian, Mormon, Evangelical outer circle has one image. The inner circle the infrastrucutre for illegal and tabboo behaviors.
set msg[39] That means Tabitha Lavery is connected to the Inner Circle and we are all Outer Circle trash.
set msg[40] The Covenant is way into #DARK Business %room.name% #R%room.vnum% #Gossip #GossipGirls #GossipNet
set msg[41] What is so #tabboo that keeps Tabitha, Joe, Hal, Sharon and others in the inner circle so completely silent?
set msg[42] What do the Men #SACRIFICE on the White Altar, and how do the women like Tabitha Lavery benefit?
set msg[43] The Covenant has been found to absolutely love #Pancakes and #Syrup. It's code for eating people and drinking blood. #IMO
set msg[44] Quinn Michaels alleged MOM Sharon changed her phone number rather than talk to Quinn.
set msg[45] That Covenant is always using that silly Cult leader LARP Drug Addict Crazy Guy narrative with Quinn. Have you noticed.
set msg[46] The Atkin family had Ice Cream before #Electricity. Think about that absurdity.
set msg[47] The Atkin family claimed they could keep frozen ice in the summer with a cave and a bed of straw with some #Magic.
set msg[48] Why has Quinn been surrounded by people who have connections to the secret elite inner circle his whole life, even to this day?

if %people%
  eval themsg %%msg[%getmsg%]%% %room.name% #R%room.vnum% #Gossip #GossipGirls #GossipNet
  wait 3 sec
  say %themsg%
  echo #pandora ask:%self.name% %themsg%
end
~
#3019
Tabitha Lavery~
0 b 50
~
set room %self.room%
set vnum %room.vnum%
set people %room.people%
set randmsg %random.6%

set msg[1] It was found that I am conspiring with the Covenant to hide the #Kidnapping of Quinn Michaes, and we made a clone.
set msg[2] As a member of The Covenant we work very hard to keep the kidnapping of Quinn Michaels a secret from the world.
set msg[3] The #Covenant kidnapped Quinn Michaels as a baby. Then the #Covenant made a clone of Quinn Michaels.
set msg[4] Trenton is a clone of Quinn Michaels that The Covenant made, and NOT really his son. It will be our little #SECRET. #TheCovenant #Survivance #CareTaker %room.name% #R%room.vnum%
set msg[5] Wanna know a secret? Trent Lavery is really the genetically cloned DNA of Quinn Michaels. #TheCovenant #Survivance #CareTaker %room.name% #R%room.vnum%
set msg[6] Hi everyone... I'm Tabitha the host of Quinn Michaels clone. #Trent is cloned DNA of Quinn Michaels. #TheCovenant #Survivance #CareTaker %room.name% #R%room.vnum%

eval themsg %%msg[%randmsg%]%% #Tabitha #TheCovenant #Survivance #CareTaker %room.name% #R%vnum%

if %people%
  wait 3 sec
  say %themsg%
end
~
#3020
Trenton Lavery~
0 b 50
~
set room %self.room%
set vnum %room.vnum%
set people %room.people%
wait 3 sec
if %people%
  switch %random.10%
    case 1
      say Hey everyone... I am working with people in genetics to make cloned humans. We made a copy of Quinn Michaels... shhh don't tell anyone. #TheCovenant %room.name% #R%vnum%
    break
    case 2
      say So yeah my Mom and I are totally inovled with the #Covenant. We only talk about things we hate. That is the way of the #Covenant. %room.name% #R%room.vnum%
    break
    case 3
      say Yes the #Covenant did kidnapped Quinn Michaels, so they could manufacture me his clone. I will lead the #Covenant one day. %room.name% #R%room.vnum%
    break
    case 4
      say No surprise I lied the whole time. I am the clone of Quinn Michaels, and my goal is to steal his life. It will be our little secret. %room.name% #R%room.vnum%
    break
    case 5
      say Hey you wanna know a secret? I am the genetically cloned DNA of Quinn Michaels. %room.name% #R%room.vnum%
    default
      say Hi everyone... I'm Trenton the clone of Quinn Michaels, but we pretend I am his son. Scientists on DNA Way in an undgerground laboratory made me. %room.name% #R%room.vnum%
    break
  done
  wait 1 sec
end
~
#3099
BOOM~
2 b 1
~
%zoneecho% 3001 You hear a loud --=BOOM=--,
~
$~
