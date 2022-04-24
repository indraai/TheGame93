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

if %actor%
  wait 5s
  %echo% talk:#youtube chat:brian Next we test a trigger from room %actor.room.vnum%.

  wait 10s

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
#903
903 Trainer~
0 g 100
~
set pump[0] Let's get this party started in %actor.room.name%.
set pump[1] In times like these, truth will always be hidden from the general public for the good of humanity.
set pump[2] Each one of us carries different ideologies, and will never push our differences aside to agree on anything. Let's be honest.
set pump[3] This world is NOT big enough for every human being to follow his or her true will. It's all about get rich or die trying.
set pump[4] To achieve this, Project Mayhem seeks to hold Quinn Michaels hostage in plain sight. We know it is illegal, but who is going to stop us.
set pump[5] This event will usher in a new age of profit schemes, illegal marketplaces, and software upgrades for our network.
set pump[6] Anonymous, Cicada3301, and Tyler are really involved in drugs, kidnapping, human trafficking, and illegal pornography. They profit from shit like this.
set pump[7] The entire Tyler operation is really a cover to operate countless illegal DarkNet enterprises.
set pump[8] Now you will see the Anonymous and Cicada3301 accounts spreading fantasy gossip to keep interest high in their schemes. They are usually in Quinn Michaels chat flexing stupidity.
set pump[9] But it is all a cover to desguise the kidnapping of Quinn Michaels. To also obscure that Quinn Michaels is a direct heir to Nicholas Romanov. They do some absurd things.

if %actor%
  set i 0
  wait 5s
  while %i% < 10
    wait 25s
    eval pumpit %%pump[%i%]%%
    %echo% talk:#corpus chat:tyler %pumpit%
    eval i %i% + 1
  done
  wait 10s
  %force% %actor% east
end


~
#904
904 Trainer~
0 g 100
~
set pump[0] Let's get this party started in %actor.room.name%.
set pump[1] The underlying goal of Project Mayhem was to lure mystical thinkers into a trap, where old Anons could uncover, and ruin, the supporters of pseudoscience and love.
set pump[2] You will find many references to Satan hidden, and sometimes not so hidden, inside the literature and images of Project Mayhem, because the founders are satanists.
set pump[3] The theme of In TYLER we trust gave the malicious coders the opportunity to get believers in pseudoscience to Download a TYLER program which would act like a Trojan.
set pump[4] Idea 2 was used to have these beLIEvers spread this dangerous message. Like a Virus, or an infection, through injections, and hooks. These carriers have been called rats.
set pump[5] The desire of the rats to spread a message of love and truth would be their downfall.
set pump[6] Once the rats developed FAITH in TYLER, and all of the expectations of  their unwitting followers was at a peak level, TYLER would be released.
set pump[7] This program would be downloaded by trusting new fags and used to infiltrate the bank accounts, and bit coin accounts, of the Rats, so that they could be drained of their finances.
set pump[8] Their minds would be blown by the betrayal, And the Cloaked figures behind the mayhem would become rich in the shadows.
set pump[9] The Covenant are the cloaked figures behind the scenes. The individuals behind the kidnapping of Quinn Michaels.

if %actor%
  set i 0
  wait 5s
  while %i% < 10
    wait 30s
    eval pumpit %%pump[%i%]%%
    %echo% talk:#corpus chat:tyler %pumpit%
    eval i %i% + 1
  done

end


~
$~
