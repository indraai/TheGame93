#200
Chunky Philosopher - 206~
0 b 5
~
eval max %random.10%
set  txt[1] I signed up for an exercise class and was told to wear loose-fitting clothing. Hell, if I HAD any loose-fitting clothing, I wouldn't  have signed up for the damn class in the first place!
set  txt[2] When I was young and trim we used to go "skinny dipping,"  now... I just "chunky dunkin."
set  txt[3] Remember... the early bird still has to eat worms.
set  txt[4] The worst thing about accidents in the kitchen is having to eat them anyway.
set  txt[5] Never argue with an idiot; people watching the two of you squabbling may not be able to tell who's who.
set  txt[6] Wouldn't it be nice if whenever we messed up our life we could simply press 'Delete' and then 'copy/paste' to do the really great parts again?
set  txt[7] Real stress is when you wake up screaming and then you realize  you haven't fallen asleep yet.
set  txt[8] my wife says I never listen to her. At least I think that's what she said.
set  txt[9] Just remember...if the world didn't suck, we'd all fall off.
set  txt[10] Lift your right foot off the ground and make clockwise circles. Now, while doing this, draw the number "6" in the air with your right hand and try to keep your foot moving clockwise.
set  txt[11] On any non-digital watch point the hour hand at the sun. The point between that and 12 will be due south. You can also judge sunlight remaining by counting the hand-widths the sun is above the horizon (4 fingers width).
set  speech %%txt[%max%]%%
eval speech %speech%
say %speech%
~
#201
Fountain Teleport - 251~
1 c 7
en~
* By Rumble of The Builder Academy    tbamud.com 9091
if %cmd.mudcommand% == enter && %arg% /= fountain
  %send% %actor% You step into the fountain getting yourself wet. Something grabs you and pulls you under.
  %echoaround% %actor% %actor.name% steps into the middle of the fountain getting %actor.himher%self wet.
  %echoaround% %actor% %actor.name% falls into the fountain and disappears.
  %teleport% %actor% 97
  nop %actor.pos(sleeping)%
  %at% 97 %echoaround% %actor% %actor.name% appears in the middle of the room laying on the floor unconscious.
else
  %send% %actor% %cmd% what?!
end
~
#202
Object Spells~
1 c 1
c~
* By Rumble of The Builder Academy    tbamud.com 9091
* Allow a magic user to cast fireshield, but only twice.
if %cmd.mudcommand% == cast && fireshield /= %arg%
  if %actor.class% == Magic User
    %echoaround% %actor% %self.shortdesc% that %actor.name% is wearing glows brightly for a moment.
    %send% %actor% Your %self.shortdesc% glows brightly for a moment.
    dg_cast 'armor' %actor%
  end
  eval ward_major %ward_major%+1
  if %ward_major% == 2
    detach all %self.id%
  end
  global ward_major
end
~
#205
Locator~
1 c 7
locate~
set find %arg%
if !%find.is_pc%
  eval room %find.room%
  %send% %actor% You find %find.name% in %room.name%.
else
  %send% %actor% Nothing found.
end
~
#210
Store Opens~
2 at 5
~
%echo% The store sign changes from "closed" to "open."
%load% obj 69
if %findobj.291(70)%
  %purge% signclosed
end
~
#211
Store Closes~
2 at 21
~
%echo% The store sign changes from "open" to "closed."
%load% obj 70
if %findobj.291(69)%
  %purge% signopened
end
~
#215
Christmas Greet~
0 h 100
~
if %actor.is_pc%
  wait 1 sec
  if !%actor.has_item(222)%
    say Merry Christmas!
    %load% obj 222 %actor% inv
    %echoaround% %actor% Santa gives %actor.name% a wrapped present.
    %send% %actor% Santa gives you a wrapped present.
  end
end
~
#218
Holiday Decorations by Interior Design - M218~
0 d 100
decorate~
* By Rumble of The Builder Academy    tbamud.com 9091
* A trigger to make decorating for holidays easier. Just say "decorate <holiday>"
if %actor.level% > 31
  switch %speech.cdr%
    case christmas
      say decorating for Christmas, how fun
      %teleport% %self% 1204
      %load% obj 1299
      %load% obj 1318
      %load% obj 1319
      %load% obj 1336
      %load% obj 1337
      %load% obj 1338
      %load% obj 1339
      %load% obj 1340
      %load% obj 1341
      %load% obj 1397
      %load% mob 1308
      drop all
      %teleport% %self% 2
      %load% obj 1299
      %load% obj 1318
      %load% obj 1319
      %load% obj 1336
      %load% obj 1337
      %load% obj 1338
      %load% obj 1339
      %load% obj 1340
      %load% obj 1341
      %load% obj 1397
      %load% mob 1308
      drop all
      %teleport% %self% %actor.name%
      wait 1 sec
      say I'm all done
    break
    case new years
      say hmm, bringing in the new year.
      %teleport% %self% 1204
      %load% obj 1298
      %load% obj 1963
      drop all
      %teleport% %self% 2
      %load% obj 1298
      %load% obj 1963
      drop all
      %teleport% %self% %actor.name%
      wait 1 sec
      say I'm all done
    break
    case valentines
      say how sweet it is.
      %teleport% %self% 1204
      %load% obj 1304
      %load% obj 1342
      drop all
      %teleport% %self% 2
      %load% obj 1304
      %load% obj 1342
      drop all
      %teleport% %self% %actor.name%
      wait 1 sec
      say I'm all done
    break
    case Easter
      say I'll have to think about it
    break
    case fourth
      say ah, US independence day.
      %teleport% %self% 1204
      %load% obj 1298
      %load% obj 1963
      drop all
      %teleport% %self% 2
      %load% obj 1298
      %load% obj 1963
      drop all
      %teleport% %self% %actor.name%
      wait 1 sec
      say I'm all done
    break
    case Halloween
      say Hallow's Eve it is.
      %teleport% %self% 1204
      %load% mob 1313
      %load% obj 11712
      %load% obj 11713
      drop all
      %teleport% %self% 2
      %load% mob 1313
      %load% obj 11712
      %load% obj 11713
      drop all
      %teleport% %self% %actor.name%
      wait 1 sec
      say I'm all done
    break
    case thanksgiving
      say Turkey Day, ode to triptophan.
      %teleport% %self% 1204
      %load% mob 1322
      %load% obj 1331
      drop all
      %teleport% %self% 2
      %load% mob 1322
      %load% obj 1331
      drop all
      %teleport% %self% %actor.name%
      wait 1 sec
      say I'm all done
    break
    default
      * nothing is going to happen
    break
  done
else
  say I only work for the Devas.
end
~
#219
Modify AC on wear~
1 j 100
~
osetval 0 9
wait 1 sec
%send% %actor% As you wear %self.shortdesc% you feel more protected.
~
#220
Birthday Present Unwrap~
1 c 3
unwrap~
eval present %random.27%
eval present2 %present% * 1000
eval present3 %present2% + %random.4%
%send% %actor% You begin unwrapping the present.
%echoaround% %actor% %actor.name% begins unwrapping %actor.hisher% present.
wait 1 s
%load% obj %present3% %actor% inv
eval inv %actor.inventory%
%echo% As the wrapping falls apart, it reveals... %inv.shortdesc%.
%purge% %self%
~
#221
Open Sesame~
2 c 100
s~
if %cmd.mudcommand% == say && avaa ovi /= %arg%
  %echo% open door.
else
  %echo% don't open door.
end
~
#222
Mob Death - weapon name~
0 f 100
~
* By Rumble of The Builder Academy    tbamud.com 9091
if %actor.eq(wield)%
  set item   %actor.eq(wield)%
  say I can not believe I fell at the hands of one such as you.
  say I curse you %actor.name% and I curse %item.shortdesc% that you use.
else
  say I can not believe I fell at the hands of one such as you.
  say I curse you %actor.name%.
end
~
#227
new trigger~
0 g 100
~
%echo% This trigger commandlist is not complete!
~
$~
