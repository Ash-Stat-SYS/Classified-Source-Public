function onBeatHit()
	if not musthit == mustHitSection then
		setProperty('gf.idleSuffix','')
		characterPlayAnim('gf','leftTurn')
		
		if mustHitSection then
            setProperty('gf.idleSuffix','-alt')
            characterPlayAnim('gf','rightTurn')
			setProperty('gf.danced',true)
		end
		setProperty('gf.danced',false)
	end
	musthit = mustHitSection
end