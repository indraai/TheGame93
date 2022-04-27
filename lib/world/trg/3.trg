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
%echo% This trigger commandlist is not complete!
~
#386
386 Tour~
2 d 100
*~
if (%actor%)
  if %actor.varexists(on_tour)%
    rdelete on_tour %actor.id%
  end
  if %speech% == take the tour
    set on_tour 1
    remote on_tour %actor.id%
    wait 1s
    %send% %actor% Thank you for taking the tour. It will start shortly.
    wait 1s
    %send% %actor% The tour is a simple walk through of Level 1 training. When training is complete will be escorted to Level 2.
    wait 5s
    %echo% talk:#mud north
  end
end
~
$~
