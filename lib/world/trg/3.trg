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
enter~
if %arg% == SindhuVI
  %send% %actor% You enter the SindhuVI.
  wait 1s
  %teleport% %actor% 1000
  wait 1s
  %force% %actor% look
else
  %send% %actor% Enter what?
end
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
$~
