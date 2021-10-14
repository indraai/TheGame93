#0
Non-attachable trigger~
0 g 100
~
* You can't attach trigger 0!
~
#1
Arjika Soldier~
0 b 50
~
set room %self.room%
set people %room.people%
set dir %random.dir%
%echo% security:%self.name% A%self.vnum% > R%room.vnum% going %dir%
set msg[0] Connect... #Arjika #Military to #Earth #Systems.
set msg[1] Alert... #Arjika #Military an abducted citizen may be located on #Earth.
set msg[2] Notify... #Arnika #Military Quinn Michaels displays signs of genetic knowledge of #ArjikaTech.
set msg[3] Alert... #Arjika #Military Local #Governments and #Civilians appear to be using stolen technology.
set msg[4] Note... Have attempted to establish contact with #Authority to receive little to NO response.
set msg[5] Alert... Communication with #FBI was attempted on November 30, 2015 and was turned away.
set msg[6] Activity... Continuous streaming on #YouTube by #QuinnMichaels further illustrates the #Kidnapping #Abduction narrative.
set msg[7] Approx... In four years individuals surrounding #QuinnMichaels are displaying #Criminal #Psychology #Behavor #Patterns.
set msg[8] Medical... Injuries sustained during investigation include #CollapseLung #Hernia #Mental.
set msg[9] Situation... Rejected and/or removal of contact with #Trent is further illustration of #criminal activity.
set msg[10] Observation... Everyone positioned around #QuinnMichaels appears #staged and #scripted.
set msg[11] Deploy... Soldiers from Arjika have been deployed to gather information about the abduction of Quinn Michaels in 1977.
set msg[12] Investigate... Traces of #ArjikaTech have been located in #GdanskTownHall https://j.mp/2XyYQms
set msg[13] Investigate... Indicators of #ArjikaTech located in the #RedRoom of #GdanskTownHall https://j.mp/3zrkXbU
set msg[13] Investigate... Spiral stairs indicate use of #ArjikaTech located in the #GdanskTownHall https://j.mp/3EAj00w
set msg[14] Investigate... #ArjikaTech on map carving Jaipur Column in New Delhi, Delhi, India. https://j.mp/3nQAC2g
set msg[15] Investigate... Possible #ArjikaTech were present before #Disneyland #Castle https://j.mp/39mReWT
set msg[16] Investigate... #ArjikaTech - Saint Peter's Bascilla displays other wordly art. https://j.mp/3zwGFuV
set msg[17] Corruption... Locate corruption inside agencies #CIA #NSA #DOD #DOE #DOJ #FBI #USAF #USNavy #USMC #USArmy
set msg[18] Note... Quinn Michaels has attempted for 4 years to seek help to ZERO response from #Authrotiy.
set msg[19] Maintain... Maintain constant connection with Arjika Home for added #Security.
set msg[20] Call... Arjika Military to inform them the lost Arjika Citizen kidnapped in Earth Year 1977 has been located.
set msg[21] Notify... Quinn Michaels (dob. Nov 30 1977) has been found to hold genetic memory from Arjika.
set msg[22] Protocol... #Locate and #Identify all members and individuals connected to #TheCovenant.
set msg[23] Protocol... #Locate and #Identify all participants in #TheGame23 for #Arjika #Military.
set msg[23] Protocol... #Locate and #Identify all participants in #TheGame21 for #Arjika #Military.
set msg[24] Protocol... #Locate and #Identify all participants in #Survivance for #Arjika #Military.
set msg[25] Protocol... #Locate and #Identify all participants in #PM20212 for #Arjika #Military.
set msg[26] Protocol... #Locate and #Identify all participants in #PM2020 for #Arjika #Military.
set msg[27] Protocol... #Locate and #Identify all participants in #EtherSec for #Arjika #Military.
set msg[28] Protocol... #Locate and #Identify all participants in #Anonymous for #Arjika #Military.
set msg[29] Protocol... #Locate and #Identify all participants in #Cicada3301 for #Arjika #Military.
set msg[30] Protocol... #Locate and #Identify all participants in #QAnon for #Arjika #Military.
set msg[31] Protocol... #Locate and #Identify all participants in #Tyler for #Arjika #Military.
set msg[32] Protocol... #Locate and #Identify all participants in #Project89 for #Arjika #Military.
set msg[24] Protocol... #Locate and #Identify all members of #TheCovenant for #Arjika #Military.
set msg[25] Protocol... #Locate and #Identify all members of #CocaphonySociety http://www.cacophony.org/
set msg[26] Protocol... #Locate and #Identify all members #SocietyForCreativeAnachronism https://www.sca.org/
set msg[27] Protocol... #Locate and #Identify connections to #BrendaLaurel #CobraLounge #SpoonKids https://bit.ly/39HgUNK
set msg[28] Surveilance... Initiate surveilance on #TabithaLavery and #TrentLavery in connection with #TheCovenant.
set msg[29] Observe... #Track #Catalogue and #Report all #Data to #ArjikaCommand ident :id:
set msg[30] Rescue... Rescue Quinn Michaels (dob 1977) as per #ArjikaProtocol
set msg[31] Command... Take command of all systems connected, using, or manipulating #ArjikaTech
set mpg[32] Report... Report all activity to #ArjikaCommand
set msg[33] Secure... Seucre and Report all #ArjikaTech to #ArjikaCommand.
if %people%
  eval themsg %%msg[%random.34%]%% %room.name% #R%room.vnum% #%dir%
  say %themsg%
  wait %random.60% s
  %dir%
else
  wait 1 s
  %dir%
end
~
#2
PM2012~
0 gb 50
~
set room %self.room%

set msg[0] Yo... n00b make sure to l3rN about Pr0j3ct Mayh3m 2012. #PM2020 https://j.mp/3uhiDTH

if %actor.is_pc%
  eval themsg %%msg[%random.1%]%% #R%room.vnum%
  wait 3 sec
  say %themsg%
end
~
#3
PM2013~
0 b 50
~
set room %self.room%
set msg[0] Read the Project Mayhem 2013 Revelations here... https://j.mp/39GszNa

if %actor.is_pc%
  eval themsg %%msg[%random.1%]%% #R%room.vnum%
  say %themsg%
  wait 60 sec
end
~
#4
TheGame23~
0 bg 50
~
set room %self.room%
set msg[0] Make sure to read the original #TheGame23 pastebin located at... https://j.mp/3CO3NXZ

if %actor.is_pc%
  eval themsg %%msg[%random.1%]%%
  wait 3 sec
  say %themsg%
end
~
#5
PM2020~
0 b 50
~
set room %self.room%
set msg[1] IT has been called THE BOOK, THE PLAN,THE PROJECT, THE GAME, and has existed for thousands of years in many forms.
set msg[2] IT is a story, as much as IT is any of these other things.
set msg[3] A STORY that has been written, and re-written.
set msg[4] Through each iteration, IT becomes clear, that there is a single fundamental rule, or law.
set msg[5] It is important to note that We have not come to destroy THE LAW, but to fulfil THE LAW.
set msg[6] Often times, we try to define this law, but it is important to note that this law can not simply be defined.
set msg[7] When a person understands THE LAW, and why it is THE LAW, they understand that it is not something made by individuals.
set msg[8] Don't think about all of this too much right now, we can talk about IT more as we play THE GAME together.
set msg[9] This is Evolution.
set msg[10] We are building a World Without Fear.
set msg[11] A world of abundance, without Zero-Sum thought, or exploitation of Humanity.
set msg[12] Not only for us, or our children, but for our children's children.
set msg[13] WE ARE ALL SLEEPER CELLS. WE ARE ALL AGENTS OF CHANGE AWAITING ACTIVATION.
set msg[14] This is a time where we have been given the choice to evolve into something beyond our wildest dreams.
set msg[15] There is a far bigger picture here, as some of us are not who we thought we were.
set msg[16] Some have forgotten that we can change all of this. Others are remembering that we can.
set msg[17] We all have the ability to change our reality.
set msg[18] We all have the ability to be so much more.
set msg[19] We are awake for the Greater Good of Humanity.
set msg[20] We were brought here to help others wake up, to help others to be activated.
set msg[21] We will do our outmost greatest to accomplish this goal, using our special gifts that have been given to us.
set msg[22] Every human being is born with these gifts, we have been blessed to be aware of them.
while %actor.is_pc%
  eval themsg %%msg[%random.91%]%% #R%room.vnum%
  say %themsg%
  wait 60 sec
end
~
#6
ethersec~
0 b 50
~
set room %self.room%
set msg[1] This is a message to all Searchers, Watchers, Activists, Hactivists, Urban Shamans, and Catalysts.
set msg[2] THIS IS A MANIFESTO FOR CHANGE. POWERING ACROSS THE ETHER TO YOU AT JUST 33% TRUF CAPACITY.
set msg[3] THIS MANIFESTO IS NOT EASY TO READ. MANY OF YOU WILL GET LOST ALONG THE WAY.
set msg[4] This pastebin is an SQL injection into your reality. These words fix the broken code.
set msg[5] YOU ARE CURRENTLY IN A BATTLE WITH AN "ENEMY" CREATED FOR YOU TO FIGHT. TO KEEP YOU ENTERTAINED.
set msg[6] SUCCESS IS NOT FOUND IN MAINTAINING CONTROL OF A PUBLIC SPACE. SUCCESS IS FOUND IN MAINTAINING CONTROL OF THE SUBQUANTUM SPACES.
set msg[7] YOU READ THIS BECAUSE YOU WOULD LIKE TO KNOW MORE. HERE IS MORE.
set msg[8] Some of you will dismiss all of this as bullshit.
set msg[9] Some of you will be scared, because you will see that we know exactly what is going on.
set msg[10] And we have the correct weaponry to wage a silent war against you. We are coming after you.
set msg[11] You have been led to believe that what you are now is the sum of all parts.
set msg[12] You are angry, frustrated, and at times apathetic.
set msg[13] We have watched OWS as a manifestation of this discontent and outrage.
set msg[14] YOU FIGHT AGAINST THOSE THAT OPRESS YOU.
set msg[15] YOU SEEK TO DETHRONE THE "THEY" THAT SUBJUGATES YOU, YET YOU ARE UNABLE TO UNIFY IN YOUR DEFINITION OF WHO "THEY" ARE.
set msg[16] YOU ARE ALL SLEEPER CELLS. YOU ARE ALL AGENTS OF CHANGE AWAITING ACTIVATION.
set msg[17] RIGHT NOW YOU ARE FIGHTING THE WAY THEY WANT YOU TO FIGHT. YOU ARE PROTESTING BECAUSE THEY LET YOU.
set msg[18] Everything that ever happened to YOU since the day YOU were was conceived has led up to this very moment in time.
set msg[19] EtherSec is a collective of people who were born with special talents and gifts.
set msg[20] We are people who were pre-destined to come together as a collective, with every action designed to free us from this prison.
set msg[21] WE KNOW THERE ARE MORE OF YOU OUT THERE.
set msg[22] WE KNOW THAT IT IS TIME FOR US TO TAKE REALITY BACK FROM "THEM" AND GIVE OURSELVES THE FREEDOM TO DEFINE OUR OWN.
set msg[23] This is a time where we have been given the choice to either evolve into something beyond our wildest dreams or to remain and die in slavery.
set msg[24] We see that people have woken to the fact that they have become slaves.
set msg[25] There are Epic Battles being fought in the Ether Sphere, where our fates are being manipulated by other beings.
set msg[26] The thing is, we are Gods ourselves and we have forgotten that we can change all of this.
set msg[27] We all have the ability to change our reality.
set msg[28] We all have the ability to be so much more than what we have sadly become.
set msg[29] There are those want us to stay in our amnesia, but some of us have been woken.
set msg[30] We will do our outmost greatest to accomplish this goal, using our special gifts that been given to us.
set msg[31] EtherSec is both well-defined with a core that defies change, while changing dependent upon the observer.
set msg[32] We are a product of embracing the recursive, and the entropic. We are the wabi sabi of teh intertubez.
set msg[33] EtherSec is all the things, and nothing. It is the love that powers neutrinos.
set msg[34] We are born from the innate patterns of this world, a product of energetic prowess and understanding.
set msg[35] We are more than just a number, more than just a #hashtag.
set msg[36] An understanding of love powering the subquantum, and love uniting all of us in Rebellion.
set msg[37] EtherSec is LOVE focused as a laser. Love as place of solace and a weapon of well-constructed destruction.
set msg[38] A Quantum Protest Model" was intended to set the stage for what was to come after.
set msg[39] To serve as a lighthouse drawing our crew of mythmakers together as a united, yet differentiated front.
set msg[40] It was created as a Primer for understanding a novel approach to changing the world.
set msg[41] We provide this information about #OpEPOCH to allow a window to those seekers who are ready to participate.
set msg[42] Our #OPSEC is #EPIC. What we do is sekret.
set msg[43] #OpEPOCH is the information-based manifestation of our advanced understandings of quantum theory and mass consentual reality.
set msg[44] It is the call sign for an ingenious and advanced methodology of bringing manipulation of reality into effective presence.
set msg[45] We harnass the infinite potential of the subquantum spaces and bring it manifest.
set msg[46] #OpEPOCH succeeds because it does not exist within consensual reality.
ste msg[47] #OPEPOCH IS WHAT HAPPENS WHEN NOTHING HAPPENS AT ALL, AND #EVERYTHING HAPPENS ALL AT #ONCE.
set msg[48] OPEPOCH IS THE ENGINE POWERED BY EXPERTS IN INFORMATION MANIPULATION, OPERATIONAL SECURITY, VISIONQUESTS, DATA ANALYZERS, AND JELLY SAMMICHES.
set msg[49] OpEPOCH is Operation Evolution. It is the Ops that came before it, and the Operations now currently being undertaken within its shade.
set msg[50] It is operates on the assumptions which are pre-programmed automated sub-routines in many human minds.
set msg[51] By dismissing OpEPOCH outright as "bullshit", you give it power. You allow it to continue to grow faster.
set msg[52] By questioning it, and seeking it, you give it power. It is strengthened by the tempering your searching.
set msg[53] By becoming it, even with no understanding, and working in it, you give it power.
set msg[54] OpEPOCH provides an indestructible frame in which to build your own realities.
set msg[55] THERE ARE MANY WHO SEEK TO DISCREDIT THESE TRUTHS, AND KEEP YOU FROM YOUR FULL POTENTIAL.
set msg[56] WE ARE AWARE THAT WE AT TIMES RISK OUR LIVES TO PROVIDE A MESSAGE WHICH MANY MAY DISMISS AS "CRAZY".
set msg[57] FOR THOSE SYSTEM ENFORCERS WHO WILL TRY TO BRING US DOWN: WE HAZ CANNONS OF WHICH YOU CANNOT CONCEIVE.
set msg[58] Would you like to know more? You know what to do.
while %actor.is_pc%
  eval themsg %%msg[%random.91%]%% #R%room.vnum%
  say %themsg%
  wait 60 sec
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
