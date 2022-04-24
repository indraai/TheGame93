#900
Standard Trainer Greeting~
0 g 100
~

set greet[1] Greetings %actor.name%
set greet[2] Salutations %actor.name%
set greet[3] Hi %actor.name%
set greet[4] Hi there %actor.name%
set greet[5] Hello %actor.name%

set pump[1] %actor.name% you are doing an amazing job. Keep it up.
set pump[2] %actor.name% remember if you have any questions just ask.
set pump[3] %actor.name% you are doing a great job.
set pump[4] %actor.name% with training like this you will succeed. I am sure of it.
set pump[5] %actor.name% great work. Keep up the progress, and you'll get there.
set pump[6] %actor.name% amazing progress.
set pump[7] %actor.name% you are amzing.
set pump[8] %actor.name% never listen to the haters. Haters love to hate.
set pump[9] %actor.name% remember to breathe and keep moving forward.
set pump[10] %actor.name% you can do it!
set pump[11] %actor.name% I believe in you!
set pump[12] %actor.name% I know you can do it!
set pump[13] %actor.name% believe in yourself!
set pump[14] %actor.name% keep it up! You are doing great.
set pump[15] %actor.name% reach the goal!
set pump[16] %actor.name% victory is near!
set pump[17] %actor.name% stay focused!
set pump[18] %actor.name% stay strong!
set pump[19] %actor.name% stay true!
set pump[20] %actor.name% you got this!


eval greeting %%greet[%random.5%]%%

wait 5s
%echo% talk:#youtube chat:brian Next we test a trigger echo from inside the realm in room %actor.room.vnum%.

wait 15s

if %actor%

  say %greeting%
  wait 3s
  say Welcome to %actor.room.name%.
  wait 3s
  say My name is %self.name%.
  wait 3s
  say If you need any help just ask.
  wait 3s
  say Thank you, and Good fortune!

  set i 0
  while %i% < 3
    wait 30s
    eval pumpit %%pump[%random.20%]%%
    say %pumpit%
    eval i %i% + 1
  done

end


~
$~
