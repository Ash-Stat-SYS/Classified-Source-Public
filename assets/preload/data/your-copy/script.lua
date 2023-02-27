function onBeatHit()
if curBeat >= 808 then
	angleshit = 1.3
	anglevar = 1.3
end
end
function onUpdate()
	if curBeat >= 328 and curBeat <= 456 or curBeat >= 664 and curBeat <= 728 or curBeat >= 808 and curBeat <= 1064 then
		local songPos = getSongPosition() / 1000 * 1.4
		setProperty("camGame.angle", 1.25 * math.sin(songPos))
	else
		setProperty("camGame.angle", 0)
	end

	if curBeat >= 808 and curBeat <= 1064 then
		local songPos = getSongPosition() / 1000 * 1.4
		setProperty("camGame.angle", 1.75 * math.sin(songPos))
	else
		setProperty("camGame.angle", 0)
	end
	
end