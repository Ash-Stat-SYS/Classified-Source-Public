local modchart = true


function onStartSong()

setPropertyFromClass('flixel.FlxG','sound.music.volume',1)

end


function onUpdate(elapsed)

	if modchart == true then
		for i = 0,3 do
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
		end

	if curStep == 0 then
        started = true
    
end

songPos = getSongPosition()
	local currentBeat = (songPos/5000)*(curBpm/60)
	doTweenY('opponentmove', 'dad', -100 - 240*math.sin((currentBeat+12*12)*math.pi), 2)
	doTweenX('disruptor2', 'disruptor2.scale', 0 - 5*math.sin((currentBeat+1*0.1)*math.pi), 6)
	doTweenY('disruptor2', 'disruptor2.scale', 0 - 1*math.sin((currentBeat+1*1)*math.pi), 6)

	end
end