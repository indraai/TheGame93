#1000
Gunnar Larsen~
0 g 100
~
  wait 5s
  say Well?
  wait 2s
  say Any Radar return?
~
#1001
James Sneed~
0 g 100
~
  wait 6s
  emote looks up, a broad smile on his face.
  say This is it, friends—the Bottomless Crevasse.
  wait 4s
  emote shakes head
  say None.
  *set time after 10s here
~
#1002
Hash Tracker~
1 acg 100
n~
wait 2s
You are in %actor.room.vnum% currently.
~
#1003
Underground Kingdom Guide~
0 b 100
~
set fol %self.follower%
set inroom %self.room.vnum%
set startroom 1000
if %fol%
  if %inroom% == %startroom%
    wait 5 sec
    north
  else
    wait 60 sec
    %random.dir%
  end
else
  if %inroom% != %startroom%
    %mgoto% 1000
  end
end
~
#1005
RM1005~
2 g 100
~
set thetoken %actor.inventory(1013)%
set thisroom %actor.room.vnum%
if %thetoken%
  %door% %thisroom% north purge
else
  %door% %thisroom% north 1013
end
~
#1012
RM1012~
2 g 100
~
set thetoken %actor.inventory(1020)%
set thisroom %actor.room.vnum%
if %thetoken%
  %door% %thisroom% south purge
else
  %door% %thisroom% south 1013
end
~
#1075
Professor Bruckner~
0 g 100
~
wait 2s
emote fills his pipe with tobacco.
wait 2s
say As I explained it's a Black Hole in the center of the Earth.
wait 2s
emote lights his pipe
wait 2s
say Who will volunteer to come with me?
~
$~
