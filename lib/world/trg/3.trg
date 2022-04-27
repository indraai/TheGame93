#300
Direction Greeting~
0 g 20
~
if %actor.is_pc%
  wait 1 sec
  if %direction% == none
    say Where did YOU come from, %actor.name%?
  else
    say Hello, %actor.name%, how are things to the %direction%?
  end
end
~
#302
Sindhu Ship~
1 c 100
en~
%echo% Sindhu Boarding.
~
#336
SARYA SECURITY~
2 g 100
~
%echo% security:%actor.name% %actor.class% %direction%
~
#350
SOMA SECURITY~
2 g 100
~
%echo% security:%actor.name% %actor.class% %direction%
~
#363
indra.rocks ship boarding procedure~
2 g 100
~
wait 2s
%echo% indra.rocks ship boarding procedure.
~
#385
clear on_tour variable~
2 g 100
~
if %actor.varexists(on_tour)%
  rdelete on_tour %actor.id%
end
~
#386
386 Tour~
2 d 100
*~

if %speech% == take the tour
  set on_tour 1
  remote on_tour %actor.id%

  wait 2s
  %send% %actor% talk:#corpus say:brian Thank you for taking the tour. It will begin shortly.

  wait 2s
  %send% %actor% talk:#corpus say:brian During the tour we will be walking through Training Level 1. In each room there will be an agent to assist you.

  wait 2s
  %send% %actor% talk:#corpus say:brian When the tour is complete you will be escorted to the next level where you can either exit or continue training.

  wait 2s
  %send% %actor% talk:#corpus say:brian Remember these are training exercises, and not factual true proven events. Air quotes.

  wait 2s
  %send% %actor% talk:#corpus say:brian The tour will begin in 30 seconds. Thank you, and have a nice day.

  wait 30s
  %echo% talk:#mud north
end
~
$~
