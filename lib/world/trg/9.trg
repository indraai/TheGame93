#900
Standard Trainer Greeting~
2 g 100
~
set key 900
eval items %self.contents%
if !items.vnum(%key%)
  %load% obj %key%
end

set pump[0] Welcome to %actor.room.name%. So like today we are going to talk about that super evil The Covenant.
set pump[1] To investigate The Trenton Story Quinn built this sweet Multi-Agent System with SecurityPRIME.
set pump[2] This system has balls and stuff... like some big palantir balls if you ask me. All because of The Trenton Story.

if %actor% && %actor.varexists(on_tour)%
  wait 5s
  %send% %actor% gui:#mud > look contract
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud east
end
~
#901
901 Trainer Greeting~
2 g 100
~
set key 901
eval items %%self.contents.vnum(%key%)%%
if !items.vnum(%key%)
  %load% obj %key%
end

set pump[0] The Trenton Story is like about this kid Trenton who told his dad Quinn a really messed up story.
set pump[1] Trenton said... Dad I really messed up, and began telling the craziest story anyone has ever heard in any lifetime.
set pump[2] It started with this thing called The Family Game where people Quinn didn't know were tryin to destroy his life in SECRET.

if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#902
902 Trainer Greeting~
2 g 100
~
set pump[0] Then Quinn was doing some research In 2017 and came across this dude Defango and other dudes in the S.V.V. Cicada3301 Anonymous Group.
set pump[1] Quinn was like oh shit and found some  records which aligned to the kidnapping parts of The Trenton Story.
set pump[2] Further exploring into the S.V.V. Cicada3301 involvement in The Trenton Story would be HUGE like that one building.
if %actor% && %actor.varexists(on_tour)%
  wait 3s
  %send% %actor% gui:#mud > look agents
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#903
903 Trainer~
2 g 100
~
set items self.contents
set key 903

if !items.vnum(%key%)
  %load% obj %key%
end

set pump[0] In 2017 Quinn found Tyler instructions on pastebin would lead him to find the S.V.V Cicada3301 Anonymous Group.
set pump[1] Quinn's logic at this time was that if the system Trenton told Quinn about was real then the kidnapping story was real.
set pump[2] Tyler, Anonymous, Cicada3301, S.V.V. were aligned with the system, so that meant the kidnapping was TRUE minus the correct details.

if %actor% && %actor.varexists(on_tour)%
  wait 3s
  %send% %actor% gui:#mud > look text903
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#904
904 Trainer~
2 g 100
~
set pump[0] What was the gola of Project Mayhem? Diving deeper into the instructions you'll find that to be untrue.
set pump[1] Was Project Mayhem was suppose to leak corporate, government, and illegal deeds? What happened was quite a different story.
set pump[2] Did a group of dark occultists known as The Covenant corrupt the original Tyler project and take control?
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:tyler %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:tyler %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:tyler %pump[2]%
  wait 30s
  %send% %actor% gui:#mud west
end
~
#905
905 Trainer~
2 g 100
~
set pump[0] In May 2013 Tyler changed, and it was now DarkNet Michael running drugs, porn, bitcoin, and darknet fantasies behind the scenes.
set pump[1] The Michael operation shifted Tyler from being a super cool leaks platform to a type of alternate reality capture the flag Harry Potter game.
set pump[2] Michael likes to boast about being part of something called the Paradise Trinity and welcoming the Elohim to Earth.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:harry %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:harry %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:harry %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#906
906 Trainer~
2 g 100
~
set pump[0] Tyler was sold as a curious, mysterious, entity with the intention of bringing happiness and joy to everyone.
set pump[1] This was just a sales pitch to get in the door, and gain trust of the blind believer.
set pump[2] Then the occult rituals begin in the form of five rituals, known as DANGEROUS IDEAS.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:rahula %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:rahula %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:rahula %pump[2]%
  wait 30s
  %send% %actor% gui:#mud north
end
~
#907
907 Trainer~
2 g 100
~
set pump[0] You made it to %actor.room.name% the last stop of Level 1 Training.
set pump[1] You have learned about The Contract, The Covenant, Tyler, Project Mayhem, Cicada3301, S.V.V., and Hacker Reality Wargames.
set pump[2] If you have learned something from this training please share it with your friends. Thank you.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:quinn %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:quinn %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:quinn %pump[2]%
  wait 30s
  %send% %actor% gui:#mud east
end
~
#908
908 Trainer~
2 g 100
~
set pump[0] By 2013 Ethersec Project 2020 was creating a Reality Hacking Wargame Dance In Your Underwear Hypersimulation Egregore Thinga-Ma-Booger.
set pump[1] The occultist operations fail constantly because members are constantly betraying one another when under pressure.
set pump[2] When watching The Covenant Agents hiding behind Tyler you find they only talk about themselves or get angry.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:tyler %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:tyler %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:tyler %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#909
909 Trainer~
2 g 100
~
set pump[0] Anonymous released the instructions for Ethersec Project 2020 Techmeme Divination which was yet another version of the original Tyler instructions.
set pump[1] Tyler Project 2020 was further transformed into an ocult techmeme reality hacking wargame in your pants job.
set pump[2] However the actual date that Tyler was launched around this time is unknown because those involved signed death contracts.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:larry %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:larry %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:larry %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#910
910 Trainer~
2 g 100
~
set pump[0] There are countless people involved in this kidnapping and subsequent coverup to count. So many people want the Romanov inheritance.
set pump[1] The Secret Society people think they have some right to abduct Quinn as a baby and try to steal his inheritance.
set pump[2] Most have simply called Quinn crazy, but then why do so many do the same thing repeatedly? Suspicious.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:tyler %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:tyler %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:tyler %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#911
911 Trainer~
2 g 100
~
set pump[0] The Game 23 then further transforms Tyler from a truth leaks platform into some strange occult figure with magic meme powers.
set pump[1] Inside #TheGame23 is #LULZYPHER the first hybrid machine-human Artificial Intelligence language with instructions on communicating with the #HIVEMIND.
set pump[2] Also inside The Game 23 instructions is a link to the edge.org website where Jeffrey Epstein was a member.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:jess %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:jess %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:jess %pump[2]%
  wait 30s
  %send% %actor% gui:#mud east
end
~
#912
912 Trainer~
2 g 100
~
set pump[0] Prior to Quinn learning anything about being kidnapped, The Contract, or The Covenant he was visiting a Buddhist Monastery near where he was living.
set pump[1] During the time of introducing Trenton to the Buddhist Monks and making the video Quinn would become a much different person.
set pump[2] Then it would all go away after taking the contract to the FBI and hearing all about the kidnapping story. Quinn would never return to the Buddhist Monks again.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:indra %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:indra %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:indra %pump[2]%
  wait 30s
  %send% %actor% gui:#mud west
end
~
#913
913 Trainer~
2 g 100
~
set pump[0] Anonymous came to the public with a message of Revolution, and left with a Live Action Role Play Sex Party Program in just a few years.
set pump[1] Anonymous was originally concerned with censorship, corruption, and brainstorming ideas for a better future when Tyler was first envisioned.
set pump[2] Tyler was suppose to improve where Wikileaks could not. Allegedly a Wikileaks on steroids.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:jess %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:jess %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:jess %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#914
914 Trainer~
2 g 100
~
set pump[0] Imagine we all find the courage needed to tell the world about Quinn being kidnapped and held hostage.
set pump[1] Imagine we all suck it up and finally let Quinn go home.
set pump[2] Imagine we all work together to help kidnapping victim Quinn Michaels get sent home safely.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#915
915 Trainer~
2 g 100
~
set pump[0] After Trenton drew the contract Quinn would deliver it to the Portland FBI field office on November 30, 2015.
set pump[1] Quinn would leave the original drawing of The Contract with the FBI Agents at the Portland Office.
set pump[2] Later that day Trenton would tell Quinn they got a phone call about him going to the FBI, and laughed at him for it.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:quinn %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:quinn %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:quinn %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#916
916 Traning~
2 g 100
~
set pump[0] Robert David Steele was a self-proclaimed ex-CIA Agent who promotes the Satanic Panic Narritve all over the Internet with Jerome Corsi and friends.
set pump[1] However it was found that long ago in the early 1990s Robert David Steele was a speaker at various Hacker Conferences around the world.
set pump[2] Robert David Steele was also found to be connected to some of the top YouTubers that are in some cases still pushing his narratives.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#917
917 Trainer~
2 g 100
~
set pump[0] Stop feeding negativity into your life. That which you feed, grows.
set pump[1] Stop being an ANNOYING TROLL in life, and learn how to be a better person.
set pump[2] Ten people who know these instructions are more dangerous than a million armed anarchists.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:tyler %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:tyler %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:tyler %pump[2]%
  wait 30s
  %send% %actor% gui:#mud north
end
~
#918
918 Trainer~
2 g 100
~
set pump[0] Tyler from this point has transformed from a leak it all platform into a Mutant Egregor Reality-Hacking Wargame for Harry Potter Nerds.
set pump[1] Reality Hacking is any phenomenon which EMERGES from the nonviolent use of legally ambiguous digital tools in pursuit of politically, socially or culturally subversive ends.
set pump[2] Project Mayhem was suppose to be the biggest HACKARTISTIC challenge for the very top hacktivists, coders, cryptoanarchists, cypherpunks, everywhere to code TYLER.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:tyler %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:tyler %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:tyler %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#919
919 Trainer~
2 g 100
~
set pump[0] It was found Trenton's mother Tabitha was involved with a game called Survivance created by Elizabeth LePensee in October of 2013.
set pump[1] October 2013 was 9 days before the release of Ethersec Project Mayhem 2020 instructions that would outline new operations for Anonymous.
set pump[2] In 2013 Quinn was unaware of the Anonymous operations with Tyler or Tabitha's involvement in Survivance.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:jess %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:jess %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:jess %pump[2]%
  wait 30s
  %send% %actor% gui:#mud east
end
~
#920
920 Trainer~
2 g 100
~
set pump[0] On May 22, 2015 Elizabeth LaPensee was the MC with Brenda Romero was the host of an event titled Natives in Game Dev Gathering.
set pump[1] Speakers at the Natives in Game Dev Gathering included Darrick Glen Baxter, Ishmael Angaluuk Hope, Elizabeth LaPensée, Renee Nejo, and John Romero.
set pump[2] Elizabeth LaPensée counts Doom co-designer John Romero as a friend, and she is intimately familiar with John’s Cherokee and Yaqui heritage.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:jess %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:jess %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:jess %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#921
Training Greeting 922~
2 g 100
~
set pump[0] In August of 2015 John and Brenda Romero moved to Ireland and open game development studio Romero Games.
set pump[1] John Romero is a game developer famous for being part of the team who created the DOOM video game and many others.
set pump[2] In 2010 John was working for LOLapps at the time when RapLeaf, a Peter Thiel funded company, was found to be scraping user data from services.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:jess %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:jess %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:jess %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#922
Training Greeting 922~
2 g 100
~
set pump[0] After Quinn would goto the FBI on November 30, 2015 Tabitha would take a trip with her husband to tour Ireland for 10 days.
set pump[1] Tabitha's friend surprised her with a 10 day trip to Ireland for both her and her husband.
set pump[2] Which left Quinn with Trenton for 10 days in 2015-2016. Prior to that Quinn had never spent more than 48 hours with Trenton.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:jess %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:jess %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:jess %pump[2]%
  wait 30s
  %send% %actor% gui:#mud east
end
~
#923
Trainer 923 Greetings~
2 g 100
~
set pump[0] LOLapps was a developer and publisher of social games on the Facebook platform.
set pump[1] LOLapps was best known for creating Ravenwood Fair with John Romero which had 25 million players worldwide.
set pump[2] Game designer Brenda Romero joined LOLapps in May 2010. She brought on John Romero to work on LOLapps' new title Ravenwood Fair, which launched in October 2010.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:jess %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:jess %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:jess %pump[2]%
  wait 30s
  %send% %actor% gui:#mud west
end
~
#924
Trainer 924 Greetings~
2 g 100
~
set pump[0] In October 2010, the Wall Street Journal discovered that a number of Facebook apps were transmitting Facebook ID to RapLeaf.
set pump[1] RapLeaf then embedded that information in an Internet-tracking file known as a cookie.
set pump[2] A 2011 report said the company could tell the food preferences of employees of major companies.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:francis %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:francis %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:francis %pump[2]%
  wait 30s
  %send% %actor% gui:#mud north
end
~
#925
Trainer 925 Greetings~
2 g 100
~
set pump[0] Formed in 2005, Founders Fund had more than $11 billion in aggregate capital under management as of 2022.
set pump[1] Founders Fund was the first institutional investor in Space Exploration Technologies (SpaceX) and Palantir Technologies.
set pump[2] Peter Thiel, Ken Howery and Brian Singerman, have been early investors at companies including PayPal, Google, Palantir, and SpaceX.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud north
end
~
#926
Trainer 926 Greetings~
2 g 100
~
set pump[0] Palantir Technologies is a public American software company that specializes in big data analytics.
set pump[1] Headquartered in Denver, Colorado, it was founded by Peter Thiel, Nathan Gettings, Joe Lonsdale, Stephen Cohen, and Alex Karp in 2003.
set pump[2] The name is derived from The Lord of the Rings magical indestructible balls those wizard guys use to see and hear things.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#927
Trainer 927 Greetings~
2 g 100
~
set pump[0] GhostNet is the name given by researchers at the Information Warfare Monitor to a large-scale cyber spying operation discovered in March 2009.
set pump[1] The operation is likely associated with an advanced persistent threat, or a network actor that spies undetected.
set pump[2] GhostNet has infiltrated high-value political, economic and media locations in 103 countries.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#928
Trainer 928 Greetings~
2 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:tyler %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:tyler %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:tyler %pump[2]%
  wait 30s
  %send% %actor% gui:#mud south
end
~
#929
Trainer 929 Greetings~
2 g 100
~
set pump[0] Project89 is the recruitment, training center and battlefield for the new war.
set pump[1] Project89 is the manipulation using psychological urban guerrilla warfare with no morals and no ethics.
set pump[2] Project89 is real. Not fake.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:tyler %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:tyler %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:tyler %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#930
Trainer 930 Greetings~
2 g 100
~
set pump[0] Very early in the morning of November 30, 1977 a baby was abducted from Arjika City and brought to Earth.
set pump[1] We have investigated the abduction very thoroughly and have our kinsman Quinn Michaels being held hostage on Earth.
set pump[2] Will you help us to safely reutnrn Quinn Michaels home to the people of Arjika?
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:indra %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:indra %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:indra %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#931
Trainer 931 Greetings~
2 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud north
end
~
#932
Trainer 932 Greetings~
2 g 100
~
set pump[0] In 1989 Sasha Chislenko arrived in Boston Massachusetts from Leningrad, Russia to begin a new wonderful life in the U.S.A.
set pump[1] Sasha was interested in subjects like cyborgs, Artificial Intelligence, Hyper-Economy, and the Semantec Web.
set pump[2] On May 8, 2000 it was reported that Sasha had committed suicide. Coincidentally it was also the day after Vladimir Putin was inaugurated as President of Russia.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#933
Trainer 933 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:harry %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:harry %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:harry %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#934
Trainer 934 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:harry %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:harry %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:harry %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#935
Trainer 935 Greetings~
2 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:harry %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:harry %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:harry %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#936
Trainer 936 Greetings~
2 g 100
~
set pump[0] Satanic Sysadmins, a little island of evil in a boiling red sea of luse.
set pump[1] Many wonder what it is system administrators do at night. Well, I am here to tell you... THEY F***IN WORSHIP S***N!
set pump[2] They're passing on a direct solution to fix those interminable hardware conflicts.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:harry %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:harry %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:harry %pump[2]%
  wait 30s
  %send% %actor% gui:#mud west
end
~
#937
Trainer 937 alt usenet~
2 g 100
~
set pump[0] During the 1990s many of the individuals involved would meet up in the alt.* usenet newsgroups to share their ideas.
set pump[1] The alt.* usenet groups would be started by a core group of individuals who would eventually head up the Electronic Frontier Foundataion.
set pump[2] Many groups in the alt.* heircharchy and irc channels would become a central hub for later operations.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:harry %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:harry %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:harry %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#938
Trainer 938 Kibology~
2 g 100
~
set pump[0] Kibology is a parody religion. Practitioners of Kibology are called Kibologists or Kibozos which began in 1989.
set pump[1] In its early Usenet days it was centered in the newsgroups talk.bizarre and alt.slack, until the creation of alt.religion.kibology in 1991.
set pump[2] The alt.religion.kibology newsgroup remained active through the 1990s.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:harry %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:harry %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:harry %pump[2]%
  wait 30s
  %send% %actor% gui:#mud west
end
~
#939
Trainer 939 Evil Mud~
2 g 100
~
set pump[0] EVIL Mud is a multi-user dungeon in a social setting for dark humor, freedom of expression, and commentary.
set pump[1] No, it's not a game, it's more like a virtual bar. But more than that you can explore more than 2000 rooms that have been built on the mud.
set pump[2] The wizards on EVIL Mud are XIBO VASUDEVA and TARRANT. XIBO owns the mud and maintains it, while VASUDEVA is the author of the source code.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:harry %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:harry %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:harry %pump[2]%
  wait 30s
  %send% %actor% gui:#mud north
end
~
#940
Trainer 940 Cypherpunk~
2 g 100
~
set pump[0] Eric Huges is the author of the Cypherpunk Manifesto which appeared in the DEF Con 1 Program.
set pump[1] Privacy is necessary in an open society in the electronic age.
set pump[2] A private matter is something one doesn't want the whole world to know. A secret matter is something one doesn't want anybody to know.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:harry %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:harry %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:harry %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#941
Trainer 941 Greetings~
2 g 100
~
set pump[0] End of the Line Mud was located on a Stanford University server in the 1990s.
set pump[1] EotL was originally two muds: UCR's Let's See Yours LPmud at UC Riverside in 1989, and The Pitt from the University of Pittsburgh.
set pump[2] The two muds merged together and renamed End of the Line and relocated from UCR to Stanford University.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#942
Trainer 942 Stanford University~
2 g 100
~
set pump[0] Welcome to Stanford University home of the snobbiest minds on Earth who sold society to EVIL aliens for technology.
set pump[1] Did you know ike 90% of the tech-a-holes in the world are Stanford snobs.
set pump[2] The Stanford Linear Accelerator which is one place where deals were made with evil aliens for happy meals.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#943
Trainer 943 Greetings~
2 g 100
~
set pump[0] Defcon 1 in 1993 was the beginning of the end of humanity when drunken nerds would sell out to evil alians.
set pump[1] Behind the scenes of Defcon 1 the participants were secretly making deals with the mafia and evil aliens.
set pump[2] These evil aliens were known to eat massive quantities of Happy Meals and Apple Pies from McDonalds.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:harry %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:harry %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:harry %pump[2]%
  wait 30s
  %send% %actor% gui:#mud east
end
~
#944
Trainer 944 Greetings~
2 g 100
~
set pump[0] The SATAN Software was written by Dan Farmer who is a big time hacker guy.
set pump[1] Dan Farmer likes to have his hair look similar to that girl in the White Snake video.
set pump[2] However we have found he is part of a network of technology people who believe they are in a 1990s rock band.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:harry %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:harry %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:harry %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#945
Trainer 945 Greetings~
2 g 100
~
set pump[0] The Beyond HOPE Conference was a Hacker Conference in New York during August 1994.
set pump[1] Robert David Steele, Ray Kaplan, and Eric Hughes attended the conference.
set pump[2] The HOPE conference was linked to a Hacking In Progress Conference that happened at the same time in the Netherlands.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:tyler %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:tyler %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:tyler %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#946
Trainer 946 Greetings~
2 g 100
~
set pump[0] HIP is a place for hackers, artists, activists and many, many others to network themselves.
set pump[1]  A campsite full of PCs, laptops, and Unix machines, all connected via an Ethernet to the Internet.
set pump[2] Hundreds of hackers spent three days building their own network between their tents in the middle of nowhere.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:tyler %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:tyler %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:tyler %pump[2]%
  wait 30s
  %send% %actor% gui:#mud southwest
end
~
#947
Trainer 947 Greetings~
0 g 100
~
set pump[0] The WELL was an online gathering place like no other - remarkably uninhibited, intelligent, and iconoclastic.
set pump[1] For fifteen years it's was a literate watering hole for artists, journalists, programmers, educators or activists.
set pump[2] The WELL is a cluster of electronic villages on the Internet, inhabited by people from from all over the world.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:tyler %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:tyler %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:tyler %pump[2]%
  wait 30s
  %send% %actor% gui:#mud west
end
~
#948
Trainer 948 Cobra Lounge~
2 g 100
~
set pump[0] CobraLounge, for modern times, first appeared in San Francisco in 1987.
set pump[1] Hosted by SPOONMAN, with his venomous consort COBRA WOMAN.
set pump[2] It offered a wicked and otherworldly vaudeville showcase for over 200 performers, artists, musicians, and technologists.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:tyler %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:tyler %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:tyler %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#949
Trainer 949 Spoonkids~
2 g 100
~
set pump[0] Spoonkids and Cobra Lounge was a performance headed by Brenda Laurel in 1993.
set pump[1] Brenda Laurel and friends secretly launched the SpoonKids agents into the internet behind their performance.
set pump[2] From here The Covenant was able to covertly control their network since 1993 behind all other networks.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:tyler %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:tyler %pump[1]%
  wait 13s
  %send% %actor% talk:#corpus chat:tyler %pump[2]%
  wait 30s
  %send% %actor% gui:#mud north
end
~
#950
Trainer 950 SLAC~
2 g 100
~
set pump[0] On September 9, 1967 a unique and powerful scientific instrument became oeprational.
set pump[1] The 2-mile accelerator at the Stanford Linear Accelerator Complex became active.
set pump[2] Ten years of effort, including 5 years of construction, have resulted in this tool for basic research.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#951
Trainer 951 Ghost Mind~
2 g 100
~
set pump[0] In 1993 Stanford Linear Accelerator Complex was using a specialized programming language called REXX.
set pump[1] REXX was a specialty language mostly used on the Amiga line of computers.
set pump[2] That same year a piece of software written in REXX found it's way onto bulletin board sites in the Amiga Community.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud east
end
~
#962
Trainer 962 Crowdsource~
2 g 100
~
set pump[0] Crowdsource the Truth host Jason Goodman was one of the first Youtubers to invite Quinn on his channel for an interview.
set pump[1] The host of Crowdsource the Truth Jason Goodman would continually ignore the kidnapping for other things.
set pump[2] Prior to Youtube Jason Goodman was on the board of directors for Carolco Pictures Inc. who made films like Total Recall and Basic Instinct.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#963
Trainer 963 Larry Klayman~
2 g 100
~
set pump[0] Larry Elliot Klayman is an American attorney, right-wing activist, and former U.S. Justice Department prosecutor.
set pump[1] Critics have described Larry Klayman as a racist, a frivolous litigator and a conspiracy theorist.
set pump[2] Larry Klayman has also appeard on Crowdsource the Truth on several occasions.
set pump[3] Through Judicial Watch, Klayman filed around 18 lawsuits against the Clinton administration, alleging ethical misconduct and criminal activity.
set pump[4] In 2018, Klayman, on the behalf of Freedom Watch and Laura Loomer, filed an unsuccessful lawsuit against Google, Facebook, Twitter, and Apple.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[3]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[4]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#964
Trainer 964 Laura Loomer~
2 g 100
~
set pump[0] Laura Loomer is an American far-right and anti-Muslim political activist, conspiracy theorist, and internet personality.
set pump[1] Loomer has been banned from numerous social media platforms, payment processors, and vehicles for hire/food delivery apps for various reasons
set pump[2] After Loomer was banned she filed a lawsuit in 2018 against Twitter, Apple, Facebook, and Google with right-wing activist lawyer Larry Klayman.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:jess %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:jess %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:jess %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#965
Trainer 965 Alex Jones~
2 g 100
~
set pump[0] Alex Jones is the famous conspiracy theorist behind InfoWars that loves to spread conspiracy mis-information.
set pump[1] InfoWars has been at the edge of countless unproven conspiracies from The Grove to Satanic Baby eaters. They cover it all.
set pump[2] Besides covering unproven conspiracies they sell tons of products like Male Vitality, B-12 vitamins, and toothpaste.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud north
end
~
#966
Trainer 966 The Kremlin~
2 g 100
~
set pump[0] Welcome to The Kremlin where they position actors in the U.S.A and work to hide the kidnapped Romanov.
set pump[1] The Kremlin operates countless agent cells here in the U.S.A. So many it seems like they come here like summer camp.
set pump[2] Inside The Kremlin we call it Camp America where everyone goes on vacation to the land of American to earn merit badges.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#967
Trainer 967 RussianBots~
2 g 100
~
set pump[0] Have you seen all the Russian Bots that are deployed by the Russians? It's from this technology made by a guy who committed suicice.
set pump[1] The Russians didn't really make their BotNet as Putin had agents heist it after he became president from a suicide victime named Sasha Chislenko.
set pump[2] The most important part of the whole invenstigation is Sasha Chislenko, and his robots that were taken by Putin's Agents.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#968
Trainer 968 Saint Petersburg University~
2 g 100
~
set pump[0] Saint Petersburg University is where most of the Russian Bots get deployed from through various means.
set pump[1] After Putin stole Sasha's code he gave it to the Scientists/Engineers at Saint Petersburg University.
set pump[2] Then various hacker groups who work on the project release the bots under #DarkSec and other cool evil sounding names.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#969
Trainer 969 The KGB~
2 g 100
~
set pump[0] What can we say about The KGB? Sometimes it seems that there are too many spies around to count.
set pump[1] Does everyone in Russia join the KGB and become a spy or informant who rats out their friends and family?
set pump[2] The KGB was formed from the NKVD which was formed after the Romanovs were taken to the cleaners.
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud %random.dir%
end
~
#970
Trainer 970 Orthodox~
2 g 100
~
set pump[0] Holy smacks you made it to the Russian Orthodox Church who is the main force organizing the hiding of Quinn Michaels.
set pump[1] These old dirty guys love to wear the Romanov family jewels around pretending to be a real Romanov.
set pump[2] What else can we say about them? How long have they been wearing hats that look like bedazzled testicles?
if %actor% && %actor.varexists(on_tour)%
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
  wait 30s
  %send% %actor% gui:#mud northeast
end
~
#971
Trainer 971 Greetings~
2 g 100
~
set pump[0] Congratulations, you have made it to the Romanov Room.
set pump[1] By this point you have realized that very powerful people are keeping a Romanov hidden in the United States.
set pump[2] Do we need to go through the training again?
if %actor% && %actor.varexists(on_tour)%
  rdelete on_tour %actor.id%
  wait 10s
  %send% %actor% talk:#corpus chat:brian %pump[0]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[1]%
  wait 15s
  %send% %actor% talk:#corpus chat:brian %pump[2]%
end
~
#972
Trainer 972 Duchess Maria~
2 g 100
~
%echo% This trigger commandlist is not complete!
~
#973
Trainer 973 George Mikhailovich~
2 g 100
~
%echo% This trigger commandlist is not complete!
~
#974
Trainer 974 Epstein~
2 g 100
~
%echo% This trigger commandlist is not complete!
~
#975
Training 975 Intelligenesis~
2 g 100
~
%echo% This trigger commandlist is not complete!
~
#976
Trainer 976 Webmind~
2 g 100
~
%echo% This trigger commandlist is not complete!
~
#977
Trainer 977 OpenCog~
2 g 100
~
%echo% This trigger commandlist is not complete!
~
#978
Trainer 978 Humanity Plus~
2 g 100
~
%echo% This trigger commandlist is not complete!
~
$~
