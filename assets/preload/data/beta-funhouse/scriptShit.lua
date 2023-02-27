local keepScroll = false
function onCreate()
	doTweenAlpha('warioFade', 'dad', 0, 0.1, linear);

	if getPropertyFromClass('ClientPrefs', 'middleScroll') == true then
        keepScroll = true;
    elseif getPropertyFromClass('ClientPrefs', 'middleScroll') == false then
        setPropertyFromClass('ClientPrefs', 'middleScroll', true);
    end

end

function onDestroy()
    if keepScroll == false then
        setPropertyFromClass('ClientPrefs', 'middleScroll', false);
    elseif keepScroll == true then
        keepScroll = false;
    end
end

function onCreatePost()
	doTweenX('scaleTweenX', 'dad.scale', 0, 0.1, 'elasticInOut');
	doTweenY('scaleTweenY', 'dad.scale', 0, 0.1, 'elasticInOut');

end
function onStepHit()
 if curStep == 128 then
	doTweenX('scaleTweenX', 'dad.scale', 1, 0.5, 'sineInOut');
	doTweenY('scaleTweenY', 'dad.scale', 1, 0.5, 'sineInOut');
	doTweenAlpha('warioFade', 'dad', 1, 0.5, linear);
end


end