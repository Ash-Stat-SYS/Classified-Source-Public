local del = 0;
local del2 = 0;

local alphaisfucked = true;

function onCreate()


end

function onUpdate()
	
	for i = 0,3 do
        setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
    end

	for i = 0, getProperty('unspawnNotes.length')-1 do
	
	end
if del > 0 then
		del = del - 1
	end
	
	if del2 > 0 then
		del2 = del2 - 1
    end

end

