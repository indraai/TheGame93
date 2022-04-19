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
set pump[10] %actor.name% with forward movement comes progress that leads to innovation.

eval greeting %%greet[%random.5%]%%

if %actor%
  wait 15s
  say %greeting%
  wait 3s
  say Welcome to %actor.room.name%.
  wait 3s
  say My name is %self.name%, and I am the Trainer in this room.
  wait 3s
  say If you need any help just ask.
  wait 3s
  say Thank you, and Good fortune!
  wait 90s

  say %%pump[%random.10%]%%
  wait 30s
  say %%pump[%random.10%]%%
  wait 30s
  say %%pump[%random.10%]%%
  wait 30s
  say %%pump[%random.10%]%%
  wait 30s
  say %%pump[%random.10%]%%
  wait 30s
  say %%pump[%random.10%]%%
  wait 30s
  say %%pump[%random.10%]%%
end


~
$~
