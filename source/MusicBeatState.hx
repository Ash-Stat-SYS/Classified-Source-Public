package;

import Conductor.BPMChangeEvent;
import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.FlxBasic;
import flixel.addons.display.FlxRuntimeShader;
import openfl.filters.ShaderFilter;
import Shaders.ChromaticAberrationEffect;

class MusicBeatState extends FlxUIState
{
	private var curSection:Int = 0;
	private var stepsToDo:Int = 0;

	private var curStep:Int = 0;
	private var curBeat:Int = 0;

	private var curDecStep:Float = 0;
	private var curDecBeat:Float = 0;
	private var controls(get, never):Controls;

	public static var camBeat:FlxCamera;

	public static var largeSmellySweatyDeliciousManBoobs:OldTVShader;
	public static var filledJarOfPiss:VCRDistortionShader;	
	var shitcanfartballs:ChromaticAberrationEffect;
	var songWithNoShader:Array<String> = ['scuttlebug', 'better-off', 'better off', 'shrouded', 'beta better off', 'beta-better-off','beta scuttlebug','beta-scuttlebug'];
	public static var allowedTo:Bool = true;
	public static var filter:ShaderFilter;
	public static var filter2:ShaderFilter;

	inline function get_controls():Controls
		return PlayerSettings.player1.controls;

	override function create() {
		camBeat = FlxG.camera;
		var skip:Bool = FlxTransitionableState.skipNextTransOut;
		// Paths.clearStoredMemory();
		// Paths.clearUnusedMemory();
		super.create();
		FlxG.mouse.visible = false;

		if(!skip) {
			openSubState(new CustomFadeTransition(0.7, true));
		}
		FlxTransitionableState.skipNextTransOut = false;

		largeSmellySweatyDeliciousManBoobs = new OldTVShader();
		largeSmellySweatyDeliciousManBoobs.iTime.value = [0];

		filledJarOfPiss = new VCRDistortionShader();
		filledJarOfPiss.iTime.value = [0];

		filledJarOfPiss.vignetteOn.value = [false];
		filledJarOfPiss.perspectiveOn.value = [false];
		filledJarOfPiss.distortionOn.value = [false];
		filledJarOfPiss.vignetteMoving.value = [false];
		filledJarOfPiss.glitchModifier.value = [0];
		filledJarOfPiss.iResolution.value = [FlxG.width, FlxG.height];

		shitcanfartballs = new ChromaticAberrationEffect();
		shitcanfartballs.setChrome(0.00225);

		filter = new ShaderFilter(shitcanfartballs.shader);
		filter2 = new ShaderFilter(largeSmellySweatyDeliciousManBoobs);
		if(PlayState.SONG != null){
			// trace(PlayState.curSong.toLowerCase());
			if(songWithNoShader.contains(PlayState.curSong.toLowerCase()) || FlxG.save.data.shaders == "Song-Specific" || FlxG.save.data.shaders == "Disabled"){
				FlxG.game.setFilters([]);
				allowedTo = false;
			}
			else if(FlxG.save.data.shaders == "All"){
				FlxG.game.setFilters([filter, filter2]); 
				allowedTo = true;
			}	
		}else if(FlxG.save.data.shaders == "All"){
			FlxG.game.setFilters([filter, filter2]); 
			allowedTo = true;
		}else if(FlxG.save.data.shaders == "Song-Specific" || FlxG.save.data.shaders == "Disabled"){
			FlxG.game.setFilters([]);
			allowedTo = false;
		}
	}

	override function update(elapsed:Float)
	{
		//everyStep();

		if(allowedTo){
			filledJarOfPiss.iTime.value[0] += elapsed * 1.25;
			largeSmellySweatyDeliciousManBoobs.iTime.value[0] += elapsed * 1.25;	
		}
		
		var oldStep:Int = curStep;

		updateCurStep();
		updateBeat();

		if (oldStep != curStep)
		{
			if(curStep > 0)
				stepHit();

			if(PlayState.SONG != null)
			{
				if (oldStep < curStep)
					updateSection();
				else
					rollbackSection();
			}

		}

		if(FlxG.save.data != null) FlxG.save.data.fullscreen = FlxG.fullscreen;

		super.update(elapsed);
	}

	private function updateSection():Void
	{
		if(stepsToDo < 1) stepsToDo = Math.round(getBeatsOnSection() * 4);
		while(curStep >= stepsToDo)
		{
			curSection++;
			var beats:Float = getBeatsOnSection();
			stepsToDo += Math.round(beats * 4);
			sectionHit();
		}
	}

	private function rollbackSection():Void
	{
		if(curStep < 0) return;

		var lastSection:Int = curSection;
		curSection = 0;
		stepsToDo = 0;
		for (i in 0...PlayState.SONG.notes.length)
		{
			if (PlayState.SONG.notes[i] != null)
			{
				stepsToDo += Math.round(getBeatsOnSection() * 4);
				if(stepsToDo > curStep) break;
				
				curSection++;
			}
		}

		if(curSection > lastSection) sectionHit();
	}

	private function updateBeat():Void
	{
		curBeat = Math.floor(curStep / 4);
		curDecBeat = curDecStep/4;
	}

	private function updateCurStep():Void
	{
		var lastChange = Conductor.getBPMFromSeconds(Conductor.songPosition);

		var shit = ((Conductor.songPosition - ClientPrefs.noteOffset) - lastChange.songTime) / lastChange.stepCrochet;
		curDecStep = lastChange.stepTime + shit;
		curStep = lastChange.stepTime + Math.floor(shit);
	}

	public static function switchState(nextState:FlxState) {
		// Custom made Trans in
		var curState:Dynamic = FlxG.state;
		var leState:MusicBeatState = curState;
		if(!FlxTransitionableState.skipNextTransIn) {
			leState.openSubState(new CustomFadeTransition(0.6, false, false));
			if(nextState == FlxG.state) {
				CustomFadeTransition.finishCallback = function() {
					FlxG.resetState();
				};
				//trace('resetted');
			} else {
				CustomFadeTransition.finishCallback = function() {
					FlxG.switchState(nextState);
				};
				//trace('changed state');
			}
			return;
		}
		FlxTransitionableState.skipNextTransIn = false;
		FlxG.switchState(nextState);
		FlxG.game.setFilters([filter, filter2]);
	}
	
	public static function switchStateSM64(nextState:FlxState) {
		// Custom made Trans in
		var curState:Dynamic = FlxG.state;
		var leState:MusicBeatState = curState;
		if(!FlxTransitionableState.skipNextTransIn) {
			leState.openSubState(new CustomFadeTransition(1.2, false, true));
			if(nextState == FlxG.state) {
				CustomFadeTransition.finishCallback = function() {
					FlxG.resetState();
				};
				//trace('resetted');
			} else {
				CustomFadeTransition.finishCallback = function() {
					FlxG.switchState(nextState);
				};
				//trace('changed state');
			}
			return;
		}
		FlxTransitionableState.skipNextTransIn = false;
		FlxG.switchState(nextState);
		FlxG.game.setFilters([filter, filter2]);
	}


	public static function resetState() {
		MusicBeatState.switchState(FlxG.state);
	}

	public static function getState():MusicBeatState {
		var curState:Dynamic = FlxG.state;
		var leState:MusicBeatState = curState;
		return leState;
	}

	public function stepHit():Void
	{
		if (curStep % 4 == 0)
			beatHit();
	}

	public function beatHit():Void
	{
		//trace('Beat: ' + curBeat);
	}

	public function sectionHit():Void
	{
		//trace('Section: ' + curSection + ', Beat: ' + curBeat + ', Step: ' + curStep);
	}

	function getBeatsOnSection()
	{
		var val:Null<Float> = 4;
		if(PlayState.SONG != null && PlayState.SONG.notes[curSection] != null) val = PlayState.SONG.notes[curSection].sectionBeats;
		return val == null ? 4 : val;
	}
}
