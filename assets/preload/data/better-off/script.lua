function onStartSong()

setPropertyFromClass('flixel.FlxG','sound.music.volume',1)

end


function onStepHit()


songPos = getSongPosition()
	local currentBeat = (songPos/5000)*(curBpm/60)
	doTweenY('opponentmove', 'dad', -100 - 240*math.sin((currentBeat+12*12)*math.pi), 2)
	doTweenX('disruptor2', 'disruptor2.scale', 0 - 5*math.sin((currentBeat+1*0.1)*math.pi), 6)
	doTweenY('disruptor2', 'disruptor2.scale', 0 - 1*math.sin((currentBeat+1*1)*math.pi), 6)

	end
