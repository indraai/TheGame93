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
#336
AIRFORCE SECURITY~
2 g 100
~
%echo% This trigger commandlist is not complete!
~
#350
ARMY SECURITY~
2 g 100
~
%echo% This trigger commandlist is not complete!
~
$~
