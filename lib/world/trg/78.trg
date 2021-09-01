#7804
78one~
0 k 100
~
say Ahh, mommy mommy help.
~
#7805
78two~
0 f 100
~
say Goodbye, mommy.
~
#7806
King Barry Speaks~
0 b 50
~
set room %self.room%
set vnum %room.vnum%
set people %room.people%

set msg[1] #KingBarry of #Disneyland is here for #FUN
set msg[2] Barry is King of Disneyland. Yippee!
set msg[3] Barry Man King of Disneyland Forever.
set msg[4] Bow to #KingBarry of Disneyland for #FUN
set msg[5] Barry King of Disneyland orders you to have TRUE FUN!

set randommsg %random.5%
eval themsg %%msg[%randommsg%]%%
if %people%
  say %themsg%
end
~
$~
