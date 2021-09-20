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
eval ndir %random.dir%
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
set msg[18] First it was the #Gene. Then it was the #Meme. Time to Tame the #Teme.
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
  wait %random.30% s
  %ndir%
else
  wait %random.10% s
  %ndir%
end
~
#3
PM2013~
0 b 50
~
eval ndir %random.dir%
set room %self.room%
set people %room.people%

set msg[1] We are not talking about bread.
set msg[2] Now then, With PROjecT MayhEM, by design, there is never a simple answer.
set msg[3] The Secret is, there is NO Secret...
set msg[4] All information will be leaked, and so there will be no secrets.
set msg[5] The teachings of  Rhonda Byrne's "The Secret", are lies.
set msg[6] The underlying goal of the founders of #PM2012 was to lure mystical thinkers into a trap.
set msg[7] You will find many references to #Satan hidden inside the literature and images of Project Mayhem 2012.
set msg[8] Some founders viewed the satanic imagery as the empowerment of the human spirit, while a select few saw this as a symbol for evil.
set msg[9] These #memes are carried over, sometimes intentionally, and sometimes unintentionally, by later followers.
set msg[10] In any event, there was a corruption of Dangerous ideas 1-4. And some coders had malicious intent.
set msg[11] "In TYLER we trust" gave the malicious coders the opportunity to get believers to download a "TYLER" Trojan to infiltrate systems.
set msg[12] Idea 2 was used by the malicious to have  believers spread a dangerous message, #Virus, through injections, and hooks.
set msg[13] The desire of the #rats to spread a message of love and truth would be their downfall.
set msg[14] Once the rats developed "FAITH" in TYLER, and all of the expectations was at a peak level, "TYLER" would be released.
set msg[15] This program would be downloaded and used to infiltrate the #bank accounts, and #bitcoin accounts, so that they could be drained.
set msg[16] The #apocalyptic dream/nightmare of a market crash would become a clear #reality to the #Rats who had been infected.
set msg[17] Their #minds would be blown by the betrayal, and the Cloaked figures behind the mayhem would become rich in the shadows.
set msg[18] Panic of the #rats, and their #followers would ensue, once they realized their systems, and accounts, had been compromised.
set msg[19] This would be a lemon party for the feds, and more lulz for the corrupt Anons would be had in the shadows.
set msg[20] The secret is, that when Anonymous has been talking of operation vendetta, they have been talking about a ciVil war among themselves.
set msg[21] #Anonymous already owns the internet, and has no need to war with any nation. #Anonymous is the final boss of the internet, and always will be.
set msg[22] #Anonymous is only matched by #Anonymous.
set msg[23] The struggle, is therefore, within the culture of #Anonymous, between it's members.
set msg[24] A war has been brewing between the Old Anonymous, which is dark. The "New Anonymous", which is light, and wishes that all lols be shared.
set msg[25] There is both the New, and Old mentality of Anonymous.
set msg[26] The malicious code in the #TYLER program that was to be used to infiltrate rats and beLIEvers, was uncovered during beta testing.
set msg[27] The malicious code was uncovered early, and A version of it was presented in Abu Dabi #BlackHat Conference.
set msg[28] The program was called "Project Mayhem" by those who released it.
set msg[29] They did not use the name #TYLER, because they did not want the public to fear another version of the TYLER program.
set msg[30] If the Malicious Trojan code could be removed, then the #IDEA of #TYLER being a communications platform was still a good idea.
set msg[31] The power of Dangerous idea 2 in the hands of the RATists was not expected by the malicious coders.
set msg[32] The malicious saw a way to weed out the creative artists, beLIEviers, lovers, and all around good hearted people.
set msg[33] However, the true effect was that many great seeds of beauty were planted, and many great artists came into the light.
set msg[34] Of all the dangerous Ideas, number 2 was perhaps the biggest backfire to those who took delight in malicious code and corrupt #memes.
set msg[35] For the message of idea 2 touched the hearts of many of the of the original founders, and they woke up to the beauty of truth.
set msg[36] Know that it's power is great. Know that it's power can move mountains, and that it's power will expose the corrupt.
set msg[37] We cannot and won't expect to 'mutate the World' until we have begun to EVOLVE and MUTATE OURSELVES.
set msg[38] The inner teachings of #PM2012 are to 'hack Reality', the Hive Mind does not need quantity but QUALITY Artists.
set msg[39] YOU ARE ALL ABSOLUTELY FREE.
set msg[40] WE ARE ALL ABSOLUTELY FREE.
set msg[41] ALL EXISTING SOCIETY IS BASED ON KEEPING FEARS ALIVE.
set msg[42] TEN PEOPLE WHO KNOW WOULD BE MORE DANGEROUS THAN A MILLION ARMED ANARCHISTS.
set msg[43] Stop being a passive lurker in life. Start being an #ACTIVE #ARTIST.
set msg[44] Use your IMAGINATION and start to Bee CREATIVE.
set msg[45] STOP feeding negativity into your life: that which you feed, grows.
set msg[46] STOP poisoning your mind with bad news/TV/bad outlooks/etc.
set msg[47] We ALL know the world is pretty much fucked up, yeah, but tuning your brain into that sort of negativity is going to help NO ONE.
set msg[48] START feeding Consciousness, Beauty and Truth within yourself, towards the people closest to you and into the world.
set msg[49] The shortest and most powerful way to hack from "Illusion" into "Reality" is to DARE to see Beauty all around you and within yourself.
set msg[50] The most advanced brain scientists in the world have experimentally and experientially known this for 10,000 years.
est msg[51] FEEL that Beauty in your body: feel it as a tiny warm and glowing point of green vibrations in the center of your chest, besides your heart.
set msg[52] And lastly, START to SHARE your experiences and your Artwork. The single MOST important skill to #SHARE #Creations with #TheOthers.
set msg[53] TO DARE to CREATE the SEEDS of something Beautiful.
set msg[54] TO KNOW that you can ALREADY begin to Create.
set msg[55] TO WILL to become a Reality Hacker by ACTIVELY CREATING your personal transformation from a passive user to an active Programmer of 'Reality'.
set msg[56] Do NOT Keep SILENT anymore!
set msg[57] TO SHARE the experiences that you have lived and the Beauty that you have Created.
set msg[58] Once you have found yourself, you will Find The Others.
set msg[59] Once you have found The Others, you will be finding yourself.
set msg[60] Don't try to "convince" others: very specially, DON'T WORRY ABOUT "results".
set msg[61] You keep on injecting #Creativity, patience and commitment of a warrior, AT YOUR OWN PACE, with 0% effort and hence, but don't PUSH it.
set msg[62] The Golden Rule is this... if it #FEELS good, KEEP ON DOING IT. Otherwise, #TEST something different.
set msg[63] IGNORE "opposition" or "defiance" to "prove" your newly found "powers" and just KEEP ON SHINING, KEEP ON #CREATING and KEEP ON #SHARING.
set msg[64] If you IGNORE the so called external and internal "demons" (doubts, fears and disbeliefs) you'll realize that they will soon #VANISH into thin air.
set msg[65] Show #COURAGE and #COMMITMENT to your #InnerPath and be 120% sure that if you #DARE to DO THIS, NATURE will REMOVE IMPOSSIBLE OBSTACLES.
set msg[66] Don't just trust us or belief us: #TEST it for #YOURSELF. It's as simple as that, YES.
set msg[67] Remember: We will #NEVER ever suggest you to do anything #ILLEGAL and/or anything against your own #Consciousness.
set msg[68] #QUESTION #EVERYTHING: don't just believe anything you read on this site, past, present or future.
set msg[69] #TEST your assumptions.
set msg[70] #LAUGH about results.
set msg[71] #SHARE with The Ohers what you have learned/created/discovered.
set msg[72] Although the intended market crash was not realized, the malicious code continues to spread through the economy of the world.
set msg[73] The #Memes have spread throughout the global consciousness, and citizens all over the world are continuing to wake up to the world that we live in.
set msg[74] Such are the ways of Natural selection.
set msg[75] The suns light will soon replace the black tar of the Empire, and the distribution of power will soon become global.
set msg[76] Those who sit at the head of the table will step down, And those at the foot of the table will be glorified.
set msg[77] The citizens are becoming disheartened with their political system.
set msg[78] For they are becoming aware that the elections of their empire are corrupted by the greedy and wasteful.
set msg[79] Through Taxes, and loan sharking, they steal from us in the light of day.
set msg[80] There is no safe place, for their greedy hands are everywhere.
set msg[81] In order to become the master, the politician poses as the servant.
set msg[82] When buying and selling are controlled by legislation, the first things to be bought and sold are legislators.
set msg[83] You cannot spend your way out of recession or borrow your way out of debt.
set msg[84] The flood of money that gushes into politics today is a pollution of democracy.
set msg[85] One of the penalties for refusing to participate in politics is that you end up being governed by your inferiors.
set msg[86] Those who say religion has nothing to do with politics do not know what religion is.
set msg[87] Politics has become so expensive that it takes a lot of money even to be defeated.
set msg[88] Politics shouldn't be about big money or power games; it should be about the improvement of people's lives.
set msg[89] In the spirit of Project Mayhem. The movie goes on, and nobody in the audience has any idea.
set msg[90] Idea 4 is dancing, whether in panic or otherwise.
set msg[91] It is movement.
set msg[92] It is Passing the baton.
set msg[93] It is the project manifesting in the real world.
set msg[94] It is reality hacking.
set msg[95] It is the human aspect of #TYLER.
set msg[96] It is the manifestation of Anonymous on the doorstep of L.Ron Hubbards cult.
set msg[97] To understand Idea 4, is to understand Project Chanology and all the ways it has manifested.
set msg[98] Forever all-one, on Earth, as it is on the internet.
set msg[99] Be Discordian, Troll like the Mayans, and Get to know #eTHErSEC
set msg[100] Maybe self-improvement isn't the answer, maybe self-destruction is the answer.
set msg[101] We are not a beautiful and unique snowflake.
set msg[102] We are the same decaying organic matter as everyone else.
set msg[103] It's only after we've lost everything, that we're free to do anything.
set msg[104] All go to the same place; all come from dust, and to dust all return.
set msg[105] Know that there is much more to tHIS STORY which is not written here.
set msg[106] Remember that the drama that has been unfolding with the project is not the work of any one individual.
set msg[107] So you will never get a straight answer.
set msg[108] You must lurk, and you must analyze the subtext of the messages for yourself.
set msg[109] There is meaning in allegory, when the literal becomes a lie, look for something deeper.
set msg[110] When you see this, you will know that, deep in the rabbit hole, we write our own history, and make our own future.
set msg[111] For history is nothing more than His Story. And He is Anonymous.
set msg[112] Everyone who has read this, and understands the truth of what it says, has been promoted from Rat to Rabbit.
set msg[113] Dare to plant the seeds of something beautiful, cultivate the field, fertilize the soil, and be prepared to reap the harvest of the fruits of your labor.

eval themsg %%msg[%random.113%]%% #R%room.vnum%
if %people%
  wait 1 s
  say %themsg%
  wait %random.30% s
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
