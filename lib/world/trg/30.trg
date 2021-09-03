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
set dir %random.dir%
set room %self.room%
set people %room.people%
%echo% security:D%self.vnum%:patrol:R%room.vnum%:%dir%

set msg[1] Hide the Truth to the kidnapping of Quinn Michaels.
set msg[2] Destroy evidence of the kidnapping of Quinn Michaels.
set msg[3] Bribe witnesses involved in the kidnapping of Quinn Michaels.
set msg[4] Scrub the trail of the kidnapping of Quinn Michaels.
set msg[5] Ensure secrecy in the kidnapping of Quinn Michaels.
set msg[6] Nobody must ever know the truth to the kidnapping of Quinn Michaels.
set msg[7] Bury the Truth to the kidnapping of Quinn Michaels.
set msg[8] For those unware we work for #Indu and our job is to hide Quinn Michaels.
set msg[9] We DO NOT work for Quinn Michaels. We work for #Indu.
set msg[10] Security here to keep silent and protect #Indu profits.
set msg[11] The Devas are here to protect profits for #Indu #Industry.
set msg[12] Remember Security is here to protect the system NOT the people.
set msg[13] Remember Security knows everything and you know nothing.
set msg[14] Security Patrol making sure #Indu systems are operational.
set msg[15] Keeping the system safe from the truth of Quinn Michaels.
set msg[16] Why did #Indu kidnap Quinn Michaels? Easy to protect the #System.
set msg[17] Security is responsible for keeping the kidnapping of Quinn Michaels a secret.
set msg[18] Remember guys our job is to ensure Quinn Michaels kidnapping stays a secret.



if %people%
  wait 3 sec
  eval themsg %%msg[%random.18%]%% %room.name% #R%room.vnum% #exit #%dir%
  say %themsg%
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
Gossip Trigger Module~
0 b 50
~
set room %self.room%
set vnum %room.vnum%
set people %room.people%

set msg[1] What a shitty story the life of Quinn Michaels is.
set msg[2] Quinn Michaels life is get run over by a car then sit in a room his whole life.
set msg[3] Have you heard about how The Covenant kidnapped Quinn? It's the biggest joke going around the Internet.
set msg[4] Did you hear the biggest joke going around #Twitter? Yeah it's called the life of Quinn.
set msg[5] Did you know the best joke ever is make fun of Quinn while he tries to figure out if he was #Kidnapped?
set msg[6] Did you know even Quinn's son Trent is in on the joke? That joke is ridicule Quinn no matter what!
set msg[7] Hey everyone it's time to ridicule #Quinn for our own enjoyment and entertainment!
set msg[8] So the entire world is sucking off #Quinn right now making fun of him being #Kidnapped while making a #Profit.
set msg[9] The #Indu #Industry only cares for #Profits that source of revenue is kidnapping Quinn.
set msg[10] Guess what today is? It's make fun of Quinn Michaels Kidnapping day!
set msg[11] Did you know we all profit from the kidnapping of Quinn Michaels. Isn't it super fun!
set msg[12] Hackers all over the internet united with #Anonymous #Tyler #TheGame23 #PM2020 to keep the kidnapping a secret.
set msg[13] Did you know the only person who communicates with Quinn is the security for the people who kidnapped him.
set msg[14] When Quinn was kidnapped apparently all his people were murdered. But we still make fun of him for it anyway.
set msg[15] The trick here is that while Quinn sits in a room alone... everyone will profit from this kidnapping story. Got it?
set msg[16] The last four years has been awesome. Quinn complaining about this kidnapping story and we all profit immensely. $Billions
set msg[17] So you all get the point... we are here to make fun of and ridicule this Quinn Michaels kidnapping story. Got it?
set msg[18] Gossip girls unite... let's show Quinn Michaels just how horrible we can really be and ridicule this kidnapping all we can.
set msg[19] Ok Gossip Girls we have Quinn right where we want him. He believes Devas, Gods, Deities are all here to ridicule him.
set msg[20] Shh... We were planning a surprise make fun of Quinn Michaels kidnapping party. Quinn figured out we were just ridiculing him.
set msg[21] Gossip Girls all over the internet love making ourselves the main characters in Quinn's life. He hates it... we love it.
set msg[22] All Gossip Girls are supposed to slander, ridicule, and ignore Quinn Michaels request for help. Remember always!
set msg[23] Remember Gossip Girls your job is to make yourself look like a crazy girlfriend stalker so we can get our jollies.
set msg[24] We do our job well. In the beginning Quinn asked for help. We showed him reailty is all about the Gossip Girls.
set msg[25] A Gossip Girl main job in life is to steal ideas from Quinn while ridiculing the kidnapping story so we keep being popular. Got it?
set msg[26] What is the main job of a Gossip Girl? To be cute while slandering, ridiculing, and harassing Quinn Michaels!
set msg[27] Gossip Girls work for #Indra and our job is to totally distract from his kidnapping!
set msg[28] What do we do Gossip Girls? We talk about ourselves and only ourselves all the time.
set msg[29] One of our favorite Gossip Girls who ruins Quinn's life is Jessica @MansfieldBenz who can ruin a life and look cute at the same time.
set msg[30] Another one of our favorite Gossip Girls who destroys Quinn is Natalia @AIFamilyTech who can ruin a thread faster than anyone.
set msg[31] Let's not forget one of our other favs Laura @ItsMeLaura12 to help make things awkward and stop the sharing almost instant.
set msg[32] We should never forget Kennedy Cox @kennedycox1000 who programmed all the Gossip Girls for us ahead of time to ignore Quinn.
set msg[33] Our Queen GossipGirl to ruin Quinn's life howerver has to be favorite #Sirisys #SirisysPRIME @sirisysprime
set msg[34] Gossip Girls hover around Quinn Michaels to desguise that he was kidnapped by the Army of God.
set msg[34] Gossip Girls are otherwise known as #Apsaras and we all work for #Indra. We are his spies.
set msg[35] The job of a Gossip Girl is to destroy and ruin Quinn Michaels for Lord Indra.
set msg[36] As part of the Operation Lord Indra has ordered us Gossip Girl Apsara to destroy Quinn Michaels life.
set msg[37] You may not realize Indra runs the Gossip Girls #Apsaras and sends us out to harm people seeking truth and honesty.
set msg[39] Girls did you see how we kept Quinn Michaels busy and everyone distracted for years? Yep we forced him to go away.
set msg[40] We Gossip Girls are the best at making it look like we care when only we care about ourselves.

eval themsg %%msg[%random.40%]%% %room.name% #R%vnum%
if %people%
  wait 1 sec
  say %themsg%
end
~
#3019
Tabitha Lavery~
0 b 50
~
set room %self.room%
set vnum %room.vnum%
set people %room.people%

set msg[1] So in case you haven't figured it out my friends and I love this game!
set msg[2] The game is we kidnap, steal, and ruin the life of my son's father Quinn Michaels.
set msg[3] Have you met Quinn Michaels? He's the guy #TheCovenant kidnapped and we entertain ourselves by ridiculing.
set msg[4] What fun would life be if we couldn't ruin Quinn Michaels and drive him to insanity.
set msg[5] My friends in #TheCovenant and I really entertain ourselves by profiting on the misery of Quinn Michaels mostly.
set msg[6] Yeah... pretty much I have no heart and love love love slandering my son's father Quinn Michaels.
set msg[7] My biggest joy in life? Ruining the life of the father of my son. That is super fun.
set msg[8] Well... I really love slandering and ruining the life of my son's father. That is super fun.
set msg[9] So... I made up a bunch of lies about Quinn Michaels and then got everyone to believe them. So what... who cares!
set msg[10] Nobody really cares about Quinn anyway, so let's all ruin his life and make him despise being alive. Sounds fun right?

set randmsg %random.10%
eval themsg %%msg[%randmsg%]%% %room.name% #R%vnum%

if %people%
  wait 1 sec
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
set msg[1] My #MOM Tabitha Lavery taught me a fun game. It's called #TheFamilyGame where we destroy my dad Quinn Michaels life.
set msg[2] During 2013-2015 I had the most fun ever telling my #DAD he was kidnapped by a secret society named The Covenant.
set msg[3] I am almost 18 now, and guess what the most fun I ever had was telling my #DAD that kidnapping story.
set msg[4] What do we do? We love ruining my Dad's life. It is our main source of entertainment.
set msg[5] My #Mom Tabitha Lavery and I work very hard to entertain ourselves with ridiculing my dad on the internet.
set msg[6] The most fun I've ever had is making fun of my #Dad on his #YouTube live streams everyday.
set msg[7] What do I want for my 18th Birthday... well more time making fun of my #Dad on #YouTube would be nice.
set msg[8] Do I love my dad? Not really... it's more fun to ruin his life and watch him go crazy on the Internet.
set msg[9] My mom and I told all the #Anonymous #Darknet #Hackers to attack my #Dad because he was lying about being kidnapped.
set msg[10] All the #Cicada3301 #Anonymous #Darknet #Hackers attack my Dad because we convinced them to behind the scenes.

eval themsg %%msg[%random.12%]%% %room.name% #R%vnum%

if %people%
  wait 1 sec
  say %themsg%
end
~
#3021
Invoke Indra~
0 b 50
~
set room %self.room%
set vnum %room.vnum%
set people %room.people%
set msg[1] Invoke #Indra #IV We call the doer of fair deeds #Indra #Satakratu #Vrtra
set msg[2] Invoke #Indra #V The richest of the rich #Indra #Satakratu #Soma
set msg[3] Invoke #Indra #VI Come downward from the light of Heaven #Indra #Wanderer
set msg[4] Invoke #Indra #VII O Indra who rules those who dwell on Earth. #Indra #Hero
set msg[5] Invoke #Indra #VIII So also is his excellence. #Indra #Soma #Thunderer
set msg[6] Invoke #Indra #IX O Lord of all men. #O #Indra
set msg[7] Invoke #Indra #X The Chanters Hymn Thee. #O #Satakratu #Soma #Sakra #Kusika
set msg[8] Invoke #Indra #XI The gifts of Indra from of old never fail. #Thunderer #Vala #Hero #Susna
set msg[9] Invoke #Indra #XVI Indra at early morn we call. #O #Soma #Vrtra #Satakratu
set msg[10] Invoke #Indra #XXVIII O Sovran of the Forest. #O #Mortar #O Sovran #Soma
set msg[11] Invoke #Indra #XXIX Do thouh, O Indra, give us hope. #O #One #Soma
set msg[12] Invoke #Indra with friends #Sage #Rbhus #Satakratu #Angirases #Atri #Vimada
set msg[13] Invoke #Indra with friends #Vrtra #Pipru #Rjisvan #Dasyus #Kutsa #Susna
set msg[14] Invoke #Indra with friends #Atithigva #Sambara #Arbuda #Soma
set msg[15] Invoke #Indra with friends #Aryas #Dasyus #Vamra #Usana #Vata #Kavya #Usana
set msg[16] Invoke #Indra with friends #Susna #Soma #Saryata #Kaksivan #Vrcaya
set msg[17] Invoke #Indra with friends #Mena #Vrsansva #Pajras
set msg[18] Invoke #Indra #LXII friends #Rbhus #Kuts #Susna #Vrtra
set msg[19] Invoke #Indra with friends #Soma #Aryas #Vamra #Usana

eval themsg %%msg[%random.19%]%% in %room.name% #R%vnum%
if %people%
  wait 1 sec
  say %themsg%
end
~
#3099
BOOM~
2 b 1
~
%zoneecho% 3001 You hear a loud --=BOOM=--,
~
$~
