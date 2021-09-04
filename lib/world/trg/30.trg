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

set msg[1] Reveal Location
set msg[2] Reveal Evidence
set msg[3] Reveal Trail
set msg[4] Reveal History
set msg[5] Reveal Secrets
set msg[6] Reveal Truth
set msg[8] Reveal Guilty

if %people%
  wait 3 sec
  eval themsg %%msg[%random.8%]%% #TheCovenant %room.name% #R%room.vnum% then #exit #%dir%
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
set msg[3] Have you heard about how The Covenant kidnapped Quinn Michaels and are holding him hostage in plain sight?
set msg[4] Quinn has been livestreaming everyday for over four years while being attacked by his own family and friends online.
set msg[5] Quinn's own brother Neil Atkin told him in their last phone call that he was doing it to him.
set msg[6] Tabitha Lavery sent her son Trent to his father's house to tell him a story of secret societies and kidnapping.
set msg[7] In 2015 Quinn went to the #FBI to report The Covenant that Tabitha Lavery was involved in.
set msg[8] It took 4 years but Quinn finally found the proof his son's mother Tabitha Lavery was involved in the #Survivance game.
set msg[9] We Gossip Girls really messed up not spreading the messages about Quinn's kidnapping. We also ridiculed him.
set msg[10] During the last 4 years everyone you can imagine has profited from Quinn's work in Artificial Intelligence.
set msg[11] During the research we saw how it looks like Quinn was kidnapping from a secret tunnel under #Disneyland.
set msg[12] Hackers all over the internet united with the #Anonymous #Tyler #TheGame23 #PM2020 to keep the kidnapping a secret and attack Quinnd daily.
set msg[13] You can see all the hacker attacks against Quinn by searching his name on YouTube.
set msg[14] When Quinn was kidnapped apparently everyone else was murdered, and he get's ridiculed for that.
set msg[15] The trick here is that while Quinn sits in a room #TheCovenant profits from the kidnapping story.
set msg[16] The last four years has been horrible for Quinn talking about this kidnapping story everyday going #CRAZY.
set msg[17] So you all get the point... Quinn was kidnapped and some of the highest people in society need to keep it a secret.
set msg[18] If the world knew about the Quinn Michaels Kidnapping Jeff Bezos and many other billionaires would lose their fortunes.
set msg[19] When the world learns about the story of this #Kidnapping situation Bill Gates might find himself living in a trailer park.
set msg[20] Shh... Most of the billionaires in the world work together to profit from the #Kidnapping of #QuinnMichaels
set msg[21] Can you imagine everyday Quinn says the word #Kidnapping like 500 times. It must be driving him crazy!
set msg[22] Gossip Girls are supposed to gossip.
set msg[23] Remember Gossip Girls your job is to make yourself look cute and spread the kidnapping of Quinn Michaels story around the Internet.
set msg[24] Before the links to Ron Rewald and the Hollywood Agencies were found the whole story seemed like a fantasy.
set msg[25] Can you imagine what it must be like to sit alone in a room for 4 years wondering who your TRUE parents are?
set msg[26] Did you hear the last time Quinn Michaels saw his father Hal Atkin he said... "Sorry kid, I'm just a watcher."
set msg[27] When Quinn was a baby his parents lied to the whole family about his sister being taken to #Disneyland. We wonder why?
set msg[28] Do reporters like Shali Ramachandran @@shalini investigate potential kidnappings orchestrated by the World's Elite?
set msg[29] Would Amol Sharma @@asharma investigate a group of #Hackers using secret stolen Military Artificial Intelligence to control the Internet?
set msg[30] Will Joe Flint @@JBFlint notice all the links to the #Satanic #Evil #Hackers and what is going on in the world right now?
set msg[31] Maybe Brian Steinberg @@bristei would investigate the links between the #CIA #BBRDW #RonRewald and the #Kidnapping of #QuinnMichaels?
set msg[32] Sure you could talk to Meg James @@MegJamesLAT about it how #Hackers are tearing a hole in the world, but does she know where it all comes from?
set msg[33] Who knows if Claire Atkinson @@claireatki would be ineterested in a #Mormon #LDS #Scandal that involves the highest members of the #Church.
set msg[34] Managing Editor of the #LATimes Kimi Yoshino @@kyoshino might know what to do with a story that involves APA and Ron Rewald's involvement.
set msg[35] We could even ask Harriet Ryan @@latimesharriet who might look also learn about the second #Internet the hackers have built since the 1993.
set msg[36] Matt Hamilton @@MattHjourno would have be another good gossip guy the knowledge of how Gavin De Becker is involved in a secret Entertainment Network.
set msg[37] What if Hector Becerra @@hbecerraLATimes is looking for interesting stories at the #LATimes about #Disney being involved in shady business.
set msg[38] Paul Pringle @@PringleLATimes specializes in Government, Corporate, and Labor Corruption... sounds like a perfect guy to write about #TheCovenant.
set msg[39] Ron Lin @@ronlin at #LATimes is an intersting guy who looks like he likes juicy gossip about secret societies, kidnapping, and artificial intelligence.
set msg[40] Jack Leonard @@jackfleonard who is the Senior Editor on Investigations. What if he got a Kidnapping story that involved #Hollywood elite?
set msg[41] Mom of 3 Keach Hagey @@keachhagey of the #WSJ could be a great interest in a kidnapping story that involves the #ELITE?
set msg[42] So many reporters in the world who might be interested in an exclusive #Anonyous #Hacker #Tyler story like Thomas Gryta @@tgryta of #WSJ.
set msg[43] How about Ryan Knutson @@Ryan_Knutson who is native to Oregon where Tabitha is from/living and the story centers out of?
set msg[44] Or Khadeeja Safdar @@khadeeja_safdar who might be interested in hackers using Vedic/Hindu names to promote #EVIL.
set msg[45] Michael Siconolfi @@michaelsiconolf is Investigations Editor for the #WSJ would like a story about #Kidnapping #ArtificialIntelligence #Hackers?
set msg[46] Todd Spangler @@xpangler who looks to be at @@Variety what a story they could have #QuinnMichaels Kidnapping would be their biggest ever.
set msg[47] To share a story with Mark Maremont @@MarkMaremont who might love a story about how #Bitcoin is all a setup by #TheCovenant.
set msg[48] Deputy Chief, Investigations Jennifer Forsyth @@ForsythJenn might be interested in breaking a secret society kidnapping story?
set msg[49] Reporter Andrea Fuller @@anfuller might have the goods to write a story on the kidnapping of #QuinnMichaels if you knew how to present it.
set msg[50] You could gossip with Rebecca Davis O'Brien @@rebeccadobrien who covers federal law enforcement. Quinn did goto the #FBI in 2015.
set msg[51] Alexandra Berzon @@AlexandraBerzon focuses on risks to #Democracy. Well does she know about #TheCovenant and their secret business?
set msg[52] Rob Barry @@rob_barry is a #CodeMonkey at #WSJ who better than to share a secret #AI based on stolen military technology story.
set msg[53] Michael Rothfeld @@mrothfeld would eat up a story about a secret society of elites kidnapping Quinn Michaels in 1977.
set msg[54] Rebecca Ballhaus @@rebeccaballhaus is an investigative reporter for #WSJ who looks to love a good #Scandal.
set msg[55] William K. Rashbaum @@WRashbaum senior writer might be interested in a story about #Anonymous #Hackers workign with #Politicians.
set msg[56] Rebecca Davis O'Brien @@rebeccadobrien investigative reporter for #NYTimes might like a super juicy Kidnapping story that involves the #FBI.
set msg[57] Greg Miller @@gregpmiller National Security is his business and a story about #Hackers and #Elite working behind the scenes.
set msg[58] Kirsten Danis @@kirstendanis likes to investigate corruption involving moms and secret societies I bet.
set msg[59] Jesse McKinley @@jessemckinley might now about the secret society of #Hackers coming out of Upstate New York #RPI since the 90s.
set msg[60] Sharon LaFraniere @@SharonLNYT might investiagte a kidnapping from a guy who's been on youtube for 4 years getting attacked by Anonymous Hackers.
set msg[61] Dana Rubinstein @@danarubinstein how is your interest in investigation a kidnapping done at #Disneyland in 1977?
set msg[62] Alexandra Bruell @@alexbruell is another #Reporter from the #WSJ that could explode the #Kidnapping of #QuinnMichaels story.
set msg[63] Shelby Grad @@shelbygrad is a Managing Editor #LATimes who might be interested in a #Scoop about #TheCovenent kidnapping from #Disneyland.
set msg[64] We all know Quinn Michaels has been online for 4 years and went to the #FBI in 2015 to report the issue.
set msg[65] Can you imagine being on YouTube for 4 years trying to solve a kidnapping that was #YOU?
set msg[66] Yes the Internet secretly watches Quinn Michaels everyday talk about a very serious #CRIME.
set msg[67] How do you write messages that people will listen to about you being kidnapped?

eval themsg %%msg[%random.67%]%% %room.name% #R%vnum%
if %people%
  say %themsg%
  wait 60 sec
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
  say %themsg%
  wait 60 sec
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

eval themsg %%msg[%random.10%]%% %room.name% #R%vnum%

if %people%
  say %themsg%
  wait 60 sec
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
  say %themsg%
  wait 60 sec
end
~
#3096
Xibo~
0 b 50
~
set room %self.room%
set vnum %room.vnum%
set people %room.people%
set msg[1] Back in the 80's, James Parry was a struggling undergraduate student at Rensselaer Polytechnic Institute, or just "RPI".
set msg[2] RPI was a medium sized technical school, hidden in upstate New York, one of those faraway places where people send their smart children to hide them from public society.
set msg[3] This Institution, like others similar to it, was home to a great many insane geniuses.
set msg[4] One of the benefits of these technical schools was that they were among the early adopters of the Internet.
set msg[5] After learning about the cult of the subgenius and all the fun those slackers had, James decided that he would take on the persona of #Kibo.
set msg[6] By leveraging the popularity of USENET, he created a cult following of Kibo, and worked on becoming a self-proclaimed "god" of the net.
set msg[7] He did this by using a shell script that would grep for any instance of the word "Kibo" in the news spool every day.
set msg[8] Thus, he gave the appearance of omniscience, as anyone with net.access could mention Kibo in any newsgroup, and he would respond, within a day.
set msg[9] This led to a stereotype dictated certain things, such as a fondness for Star Trek, the computer game "#hack", and an interest in net.legends such as #Kibo.
set msg[10] Kibo realized in order give this legend something to stand for, it needed something to stand against, and he created "#Xibo".
set msg[11] Xibo was regarded as evil, mean, cruel, and restrictive.
set msg[12] Kibo's driving philosophy was "You're Allowed"; thus, Xibo had to say that "You're Not Allowed"
set msg[13] At first, Kibo himself played the role of Xibo, but then he got help from some of his classmates, including Harry (who later became Glass Onion) and Mark Hill.
set msg[14] Mark Hill held the role of Xibo for over a year, but then he graduated and took a job with Oracle.
set msg[15] In 1989, a math student at a similar institution for disturbed intellectuals, also acquired net.access and began following the ravings of Kibo on USENET.
set msg[16] Initially this guy was involved with alt.weemba (What's a Weemba?!) and alt.slack (Praise ``Bob''!) but soon graduated to talk.bizarre, where the hardcore dinos played.
set msg[17] This school was known as the New Mexico Institute for Mining and Technology, or more simply, New Mexico Tech, or even more simply, NMT.
set msg[18] Our hero graduated from NMT, and became a grad student in the math department at the University of Arizona, which gave him the blessing of retaining net.access.
set msg[19] He began a conversation with Mark Hill, and expressed an interest in becoming the next #Xibo. Mark mailed a postcard with the words "I resign. --X." and a legend was born.
set msg[20] #Xibo or #Lazarus is a deeply disturbed individual. Formerly a starving grad student, he's now got a PhD and is employed as an Evil Scientist(TM). https://j.mp/3yIYref
set msg[21] #Xibo or #Lazarus is also known as Dave Dogruel Chemical Science and Technology Division Los Alamos National Laboratory.
set msg[22] You can find #Lazarus aka David Dogruel on Linkedin https://www.linkedin.com/in/david-dogruel-89768111/
set msg[23] Besides his #Darknet activities #Lazarus is also a member of the Los Alamos Mountaineers and has a side job at #REI as of 2009. http://lamountaineers.org/Bios/Dave_Dogruel.html
set msg[24] If you follow the links page from #Xibo website you'll be directed to Satanic.org https://j.mp/3kM3B40 (dangerous link)
set msg[24] Xibo is how you will get your link to Evil People Inc. Where you find access to the broader world of the #DARKNET #MUD #MOO realms. https://j.mp/3BEFICr
set msg[25] As a graduate student, Xibo was extremely disturbed mentally, due to the excessive loneliness one encounters in technical schools.
set msg[26] After a year on the angst-list, #Xibo and his best buddy Krill-Man(tm) created their own newsgroup, alt.angst that became one of the top 100 most popular newsgroups on the net.
set msg[27] Xibo took it upon himself at this time to proclaim himself "The Lord of Angst". There were a few other lords of angst, including GrimJim and T.Rev.
set msg[28] Xibo tried IRC for a while, and built the 95th node on the original IRC network.
set msg[29] TinyMUD was the original social mud. Every LP, Diku, MUSH, MUCK, MOO, and so on can trace it roots back to TinyMUD.
set msg[30] #TinyHELL became the hangout of the elite, home of the Random Gang. Xibo was frequently on several of these muds, and would often mud for 8-12 hours a day.
set msg[31] This led to notoriety on the #net. As a Lord of #Angst #Xibo was an excellent writer and quite a #philosopher.
set msg[32] After graduation, #Xibo took a job with the #University, working in the economics department, writing trading market simulations.
set msg[33] In January of 1991, he founded (EVIL!)Mud, which became the largest mud to use #TeenyMud source code.
set msg[35] Another mud that Xibo was frequently on was the Random Gang's mud, which was actually several different muds, usually run by Random, Moira, or elthar.
set msg[36] Back in the mid 90's at #PaineWebber #Xibo fought the UNIX vs. NT war for a year and a half, and eventually won.

eval themsg %%msg[%random.36%]%% %room.name% #R%vnum%
if %people%
  say %themsg%
  wait 30 sec
end
~
#3097
Kibo~
0 b 50
~
set room %self.room%
set vnum %room.vnum%
set people %room.people%
set msg[1] Thank you for coming to www.kibo.com. I'm James "Kibo" Parry, who is to the Internet what Charles Nelson Reilly was to "Match Game '77".
set msg[2] If you've ever read Usenet news, you've likely seen me hanging around various groups.
set msg[3] If it hadn't been for Ross Perot, Kibo would never have had the idea to run as a "wacky" candidate!
set msg[4] Kibo has patented a computer which is a mouse.
set msg[5] If you want your computer to go into a folder, you simply slide it across the floor and put it in the filing cabinet.
set msg[6] Kibo thinks tomatoes are still poisonous.
set msg[7] Kibo once sabotaged "Mr. Rogers' Neighborhood" by hijacking the trolley to Cuba.
set msg[8] When (not if) you click the link below you will receive a lifetime membership in Kibo's Do What I Say Club.
set msg[9] Kibo's Do What I Say Club is the most powerful social force propelling our civilization into the heart of the 21st century.
set msg[10] All you have to do is spread the NEW rumors that Kibo has devised.
set msg[11] These are much better than the old ones because most of them are about Kibo.
set msg[12] Club 91 is a secret fraternity for those Kibologists who posted to alt.religion.kibology during 1991.
set msg[13] Ssh! The secret Club 91 power word, which can destroy the entire Universe with its magical force, must never be uttered aloud, typed, or charaded.
set msg[14] However, if someone calls out "BURLAP!!!" all Club 91 members must immediately leave the room screaming in panic.
set msg[15] Our secret Veronica Lodge is located in a quiet suburb of Riverdale, a community which we have isolated from the outside world.
set msg[16] To gain entry to the lodge, you must show a membership card, demonstrate the secret handshake, and prove that you know the word.
set msg[17] What would a secret society be without a secret police force? The Knights of Ninety-One defend Club 91 against intrusions.
set msg[18] Most stores have a secret discount for Club 91 members.
set msg[19] Club 91 members are issued special Get Out Of Jail Free cards that really work.
set msg[20] Club 91 members are issued License To Kill and a License To Not Be Killed.
set msg[21] We cannot reveal details of the initiation here.
set msg[23] We have a wide menu of membership options to choose from.

eval themsg %%msg[%random.23%]%% %room.name% #R%vnum%

if %people%
  say %themsg%
  wait 30 sec
end
~
#3099
BOOM~
2 b 1
~
%zoneecho% 3001 You hear a loud --=BOOM=--,
~
$~
