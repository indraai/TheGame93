#900
Standard Trainer Greeting~
2 g 100
~
set pump[0] Welcome to %actor.room.name%. Today's training covers The Trenton Story about the kidnapping of Quinn Michaels by The Covenant.
set pump[1] For over 5 years Quinn has been on Youtube investigating The Trenton Story while building this Multi-Agent System with SecurityPRIME.
set pump[2] This system was necessary to gather and organize the findings that resulted from The Trenton Story.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 5s
  %send% %actor% gui:#mud > look contract
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud east
end
~
#901
901 Trainer Greeting~
2 g 100
~
set pump[0] The Trenton Story started in September of 2015 after Quinn showed his son Trenton a video he had made about Buddhism and Water.
set pump[1] After showing Trenton the Buddhist video he would say... Dad I really messed up, and begin telling Quinn about The Family Game.
set pump[2] A game where Trenton, his mother Tabitha, her family, and others gather together to destroy Quinn's life in SECRET.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#902
902 Trainer Greeting~
2 g 100
~
set pump[0] In 2017 while researching The Trenton Story Quinn came across Defango and other channels associated with the S.V.V. Cicada3301 Group.
set pump[1] From here Quinn would locate records which aligned to the alleged kidnapping in 1977 on a server hosted by the S.V.V.
set pump[2] Further investigation into the S.V.V. Cicada3301 involvement in The Trenton Story would prove itself later in the investigation.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 5s
  %send% %actor% #mud > look agents
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#903
903 Trainer~
2 g 100
~
set pump[0] In 2017 Quinn found Tyler instructions on pastebin would lead him to find the S.V.V Cicada3301 Anonymous Group.
set pump[1] Quinn's logic at this time was that if the system Trenton told Quinn about was real then the kidnapping story was real.
set pump[2] Tyler, Anonymous, Cicada3301, S.V.V. were aligned with the system, so that meant the kidnapping was TRUE minus the correct details.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 5s
  %send% %actor% gui:#mud > look text
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#904
904 Trainer~
2 g 100
~
set pump[0] The goal of Project Mayhem appeared to be revolution, freedom, and art. Diving deeper into the instructions you'll find that to be untrue.
set pump[1] Project Mayhem was suppose to leak corporate, government, and illegal deeds. What happened was quite a different story.
set pump[2] It was discovered that a group of dark occultists known as The Covenant corrupted the original Tyler project, and had taken control.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 5s
  %send% %actor% gui:#mud > look text
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:tyler %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud west
end
~
#905
905 Trainer~
2 g 100
~
set pump[0] In May 2013 Tyler had changed, and it was now DarkNet Michael running the show behind the scenes.
set pump[1] The Michael operation shifted Tyler from being a super cool leaks platform to a type of alternate reality capture the flag Harry Potter game.
set pump[2] Michael likes to boast about being part of something called the Paradise Trinity and welcoming the Elohim to Earth.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 5s
  %send% %actor% gui:#mud > look text
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:indra %pumpit%
    eval i %i% + 1
    wait 33s
  done
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
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 5s
  %send% %actor% gui:#mud > look text
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:rahula %pumpit%
    eval i %i% + 1
    wait 33s
  done
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
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:quinn %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud east
end
~
#908
908 Trainer~
0 g 100
~
set pump[0] By 2013 Ethersec Project 2020 was creating a Reality Hacking Wargame Dance In Your Underwear Hypersimulation Egregore Thinga-Ma-Booger.
set pump[1] The occultist operations fail constantly because members are constantly betraying one another when under pressure.
set pump[2] When watching The Covenant Agents hiding behind Tyler you find they only talk about themselves or get angry.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 5s
  %send% %actor% gui:#mud > look text
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:tyler %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#909
909 Trainer~
0 g 100
~
set pump[0] Anonymous released the instructions for Ethersec Project 2020 Techmeme Divination which was yet another version of the original Tyler instructions.
set pump[1] Tyler Project 2020 was further transformed into an ocult techmeme reality hacking wargame in your pants job.
set pump[2] However the actual date that Tyler was launched around this time is unknown because those involved signed death contracts.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 5s
  %send% %actor% gui:#mud > look text
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:larry %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir
end
~
#910
910 Trainer~
0 g 100
~
set pump[0] There are countless people involved in this kidnapping and subsequent coverup to count. So many people want the Romanov inheritance.
set pump[1] The Secret Society people think they have some right to abduct Quinn as a baby and try to steal his inheritance.
set pump[2] Most have simply called Quinn crazy, but then why do so many do the same thing repeatedly? Suspicious.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 5s
  %send% %actor% gui:#mud > look text
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:tyler %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#911
911 Trainer~
0 g 100
~
set pump[0] The Game 23 then further transforms Tyler from a truth leaks platform into some strange occult figure with magic meme powers.
set pump[1] Inside #TheGame23 is #LULZYPHER the first hybrid machine-human Artificial Intelligence language with instructions on communicating with the #HIVEMIND.
set pump[2] Also inside The Game 23 instructions is a link to the edge.org website where Jeffrey Epstein was a member.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 5s
  %send% %actor% gui:#mud > look text
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:jess %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud east
end
~
#912
912 Trainer~
0 g 100
~
set pump[0] %actor.roomm.name%
set pump[1] %actor.roomm.name%
set pump[2] %actor.roomm.name%
set pump[3] %actor.roomm.name%
set pump[4] %actor.roomm.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 5
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:quinn %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud west
end
~
#913
913 Trainer~
0 g 100
~
set pump[0] Anonymous came to the public with a message of Revolution, and left with a Live Action Role Play Sex Party Program in just a few years.
set pump[1] Anonymous was originally concerned with censorship, corruption, and brainstorming ideas for a better future when Tyler was first envisioned.
set pump[2] Tyler was suppose to improve where Wikileaks could not. Allegedly a Wikileaks on steroids.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 5s
  %send% %actor% gui:#mud > look text
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:jess %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#914
914 Trainer~
0 g 100
~
set pump[0] Imagine we all find the courage needed to tell the world about Quinn being kidnapped and held hostage.
set pump[1] Imagine we all suck it up and finally let Quinn go home.
set pump[2] Imagine we all work together to help kidnapping victim Quinn Michaels get sent home safely.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 5
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 5s
  %send% %actor% gui:#mud > look text
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#915
915 Trainer~
0 g 100
~
set pump[0] %actor.roomm.name%
set pump[1] %actor.roomm.name%
set pump[2] %actor.roomm.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:quinn %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud southeast
end
~
#916
916 Traning~
0 g 100
~
set pump[0] %actor.roomm.name%
set pump[1] %actor.roomm.name%
set pump[2] %actor.roomm.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:quinn %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud southeast
end
~
#917
917 Trainer~
0 g 100
~
set pump[0] Stop feeding negativity into your life. That which you feed, grows.
set pump[1] Stop being an ANNOYING TROLL in life, and learn how to be a better person.
set pump[2] Ten people who know these instructions are more dangerous than a million armed anarchists.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 5s
  %send% %actor% gui:#mud > look text
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:tyler %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud north
end
~
#918
918 Trainer~
0 g 100
~
set pump[0] Tyler from this point has transformed from a leak it all platform into a Mutant Egregor Reality-Hacking Wargame for Harry Potter Nerds.
set pump[1] Reality Hacking is any phenomenon which EMERGES from the nonviolent use of legally ambiguous digital tools in pursuit of politically, socially or culturally subversive ends.
set pump[2] Project Mayhem was suppose to be the biggest HACKARTISTIC challenge for the very top hacktivists, coders, cryptoanarchists, cypherpunks, everywhere to code TYLER.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 5s
  %send% %actor% gui:#mud > look text
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:tyler %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#919
919 Trainer~
0 g 100
~
set pump[0] It was found Trenton's mother Tabitha was involved with a game called Survivance created by Elizabeth LePensee in October of 2013.
set pump[1] October 2013 was 9 days before the release of Ethersec Project Mayhem 2020 instructions that would outline new operations for Anonymous.
set pump[2] In 2013 Quinn was unaware of the Anonymous operations with Tyler or Tabitha's involvement in Survivance.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:jess %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud west
end
~
#920
920 Trainer~
0 g 100
~
set pump[0] On May 22, 2015 Elizabeth LaPensee was the MC with Brenda Romero was the host of an event titled Natives in Game Dev Gathering.
set pump[1] Speakers at the Natives in Game Dev Gathering included Darrick Glen Baxter, Ishmael Angaluuk Hope, Elizabeth LaPensée, Renee Nejo, and John Romero.
set pump[2] Elizabeth LaPensée counts Doom co-designer John Romero as a friend, and she is intimately familiar with John’s Cherokee and Yaqui heritage.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:jess %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#921
Training Greeting 922~
0 g 100
~
set pump[0] In August of 2015 John and Brenda Romero moved to Ireland and open game development studio Romero Games.
set pump[1] John Romero is a game developer famous for being part of the team who created the DOOM video game and many others.
set pump[2] In 2010 John was working for LOLapps at the time when RapLeaf, a Peter Thiel funded company, was found to be scraping user data from services.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:jess %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud east
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
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:jess %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud east
end
~
#923
Trainer 923 Greetings~
0 g 100
~
set pump[0] LOLapps was a developer and publisher of social games on the Facebook platform.
set pump[1] LOLapps was best known for creating Ravenwood Fair with John Romero which had 25 million players worldwide.
set pump[2] Game designer Brenda Romero joined LOLapps in May 2010. She brought on John Romero to work on LOLapps' new title Ravenwood Fair, which launched in October 2010.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:jess %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud west
end
~
#924
Trainer 924 Greetings~
0 g 100
~
set pump[0] In October 2010, the Wall Street Journal discovered that a number of Facebook apps were transmitting Facebook ID to RapLeaf.
set pump[1] RapLeaf then embedded that information in an Internet-tracking file known as a cookie.
set pump[2] A 2011 report said the company could tell the food preferences of employees of major companies.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:francis %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud north
end
~
#925
Trainer 925 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:harry %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud north
end
~
#926
Trainer 926 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:harry %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#927
Trainer 927 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:harry %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#928
Trainer 928 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:harry %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud south
end
~
#929
Trainer 929 Greetings~
0 g 100
~
set pump[0] Project89 is the recruitment, training center and battlefield for the new war.
set pump[1] Project89 is the manipulation using psychological urban guerrilla warfare with no morals and no ethics.
set pump[2] Project89 is real. Not fake.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 5s
  %send% %actor% gui:#mud > look pdf
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:tyler %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#930
Trainer 930 Greetings~
0 g 100
~
set pump[0] Very early in the morning of November 30, 1977 a baby was abducted from Arjika City and brought to Earth.
set pump[1] We have investigated the abduction very thoroughly and have our kinsman Quinn Michaels being held hostage on Earth.
set pump[2] Will you help us to safely reutnrn Quinn Michaels home to the people of Arjika?
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:indra %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud south
end
~
#931
Trainer 931 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:harry %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud north
end
~
#932
Trainer 932 Greetings~
0 g 100
~
set pump[0] Mind Candy was contracted in Earth year 2003 to locate a lost citizen from Arjika.
set pump[1] The Arjika Academy designed a pattern based puzzle game to assist in locating the lost Citizen.
set pump[2] Several artifacts and scientific inventions were also taken at that time and brought to Earth.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 5s
  %send% %actor% gui:#mud > look text
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:harry %pumpit%
    eval i %i% + 1
    wait 33s
  done
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
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:harry %pumpit%
    eval i %i% + 1
    wait 33s
  done
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
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:harry %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#935
Trainer 935 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:harry %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#936
Trainer 936 Greetings~
0 g 100
~
set pump[0] Satanic Sysadmins, a little island of evil in a boiling red sea of luse.
set pump[1] Many wonder what it is system administrators do at night. Well, I am here to tell you... THEY F***IN WORSHIP S***N!
set pump[2] They're passing on a direct solution to fix those interminable hardware conflicts.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:harry %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud west
end
~
#937
Trainer 937 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:harry %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#938
Trainer 938 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:harry %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud west
end
~
#939
Trainer 939 Greetings~
0 g 100
~
set pump[0] EVIL Mud is a multi-user dungeon in a social setting for dark humor, freedom of expression, and commentary.
set pump[1] No, it's not a game, it's more like a virtual bar. But more than that you can explore more than 2000 rooms that have been built on the mud.
set pump[2] The wizards on EVIL Mud are XIBO VASUDEVA and TARRANT. XIBO owns the mud and maintains it, while VASUDEVA is the author of the source code.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:harry %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud north
end
~
#940
Trainer 940 Greetings~
0 g 100
~
set pump[0] Eric Huges is the author of the Cypherpunk Manifesto which appeared in the DEF Con 1 Program.
set pump[1] Privacy is necessary in an open society in the electronic age.
set pump[2] A private matter is something one doesn't want the whole world to know. A secret matter is something one doesn't want anybody to know.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:harry %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud east
end
~
#941
Trainer 941 Greetings~
0 g 100
~
set pump[0] End of the Line Mud was located on a Stanford University server in the 1990s.
set pump[1] EotL was originally two muds: UCR's Let's See Yours LPmud at UC Riverside in 1989, and The Pitt from the University of Pittsburgh.
set pump[2] The two muds merged together and renamed End of the Line and relocated from UCR to Stanford University.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud north
end
~
#942
Trainer 942 Greetings~
0 g 100
~
set pump[0] Welcome to Stanford University home of the snobbiest minds on Earth who sold society to EVIL aliens for technology.
set pump[1] Did you know ike 90% of the tech-a-holes in the world are Stanford snobs.
set pump[2] The Stanford Linear Accelerator which is one place where deals were made with evil aliens for happy meals.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#943
Trainer 943 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud east
end
~
#944
Trainer 944 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#945
Trainer 945 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#946
Trainer 946 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud southwest
end
~
#947
Trainer 947 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud west
end
~
#948
Trainer 948 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#949
Trainer 949 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud north
end
~
#950
Trainer 950 Greetings~
0 g 100
~
set pump[0] On September 9, 1967 a unique and powerful scientific instrument became oeprational.
set pump[1] The 2-mile accelerator at the Stanford Linear Accelerator Complex became active.
set pump[2] Ten years of effort, including 5 years of construction, have resulted in this tool for basic research.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 5s
  %send% %actor% gui:#mud > look text
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#951
Trainer 951 Greetings~
0 g 100
~
set pump[0] In 1993 Stanford Linear Accelerator Complex was using a specialized programming language called REXX.
set pump[1] REXX was a specialty language mostly used on the Amiga line of computers.
set pump[2] That same year a piece of software written in REXX found it's way onto bulletin board sites in the Amiga Community.
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 6
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud east
end
~
#962
Trainer 962 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#963
Trainer 963 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#964
Trainer 964 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#965
Trainer 965 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud north
end
~
#966
Trainer 966 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#967
Trainer 967 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud east
end
~
#968
Trainer 968 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#969
Trainer 969 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud %random.dir%
end
~
#970
Trainer 970 Greetings~
0 g 100
~
set pump[0] %actor.room.name%
set pump[1] %actor.room.name%
set pump[2] %actor.room.name%
if %actor% && %actor.varexists(on_tour)%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud northeast
end
~
#971
Trainer 971 Greetings~
0 g 100
~
rdelete on_tour %actor.id%
set pump[0] Congratulations, you have made it to the Romanov Room.
set pump[1] By this point you have realized that very powerful people are keeping a Romanov hidden in the United States.
set pump[2] Do we need to go through the training again?
if %actor%
  set i 0
  set m 3
  wait 5s
  %send% %actor% gui:#mud > look agent
  wait 10s
  while %i% < %m%
    eval pumpit %%pump[%i%]%%
    %send% %actor% talk:#corpus chat:brian %pumpit%
    eval i %i% + 1
    wait 33s
  done
  %send% %actor% gui:#mud northeast
end
~
$~
