package;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.util.FlxStringUtil;

class PauseSubState extends MusicBeatSubstate
{
	var grpMenuShit:FlxTypedGroup<Alphabet>;

	var menuItems:Array<String> = [];
	var menuItemsOG:Array<String> = ['Resume', 'Restart Song', 'Exit to menu'];
	var difficultyChoices = [];
	var curSelected:Int = 0;
	var songcomposer:String = '';
	
	var cumBox:FlxSprite;
	var shitterText:FlxText;

	var pauseMusic:FlxSound;
	var practiceText:FlxText;
	var skipTimeText:FlxText;
	var skipTimeTracker:Alphabet;
	var curTime:Float = Math.max(0, Conductor.songPosition);
	//var botplayText:FlxText;

	public static var songName:String = 'SM64FileSelect';

	public function new(x:Float, y:Float)
	{
		super();
		pLEASEPLAYTHEFUCKINGPAUSESOUNDEFFECTOHMYGOD();
		if(CoolUtil.difficulties.length < 2) menuItemsOG.remove('Change Difficulty'); //No need to change difficulty if there is only one!

		if(PlayState.chartingMode)
		{
			menuItemsOG.insert(2, 'Leave Charting Mode');
			
			var num:Int = 0;
			if(!PlayState.instance.startingSong)
			{
				num = 1;
				menuItemsOG.insert(3, 'Skip Time');
			}
			menuItemsOG.insert(3 + num, 'End Song');
			menuItemsOG.insert(4 + num, 'Toggle Practice Mode');
			menuItemsOG.insert(5 + num, 'Toggle Botplay');
		}
		menuItems = menuItemsOG;

		for (i in 0...CoolUtil.difficulties.length) {
			var diff:String = '' + CoolUtil.difficulties[i];
			difficultyChoices.push(diff);
		}
		difficultyChoices.push('BACK');

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.4;
		bg.scrollFactor.set();
		add(bg);

        var pauseGraphic:FlxSprite = new FlxSprite().loadGraphic(Paths.image("PAUSE"));
        pauseGraphic.screenCenter();
        pauseGraphic.y -= (pauseGraphic.height) * 2;
        add(pauseGraphic);

        cumBox = new FlxSprite().makeGraphic(630, 260, FlxColor.BLACK);
        cumBox.screenCenter();
		cumBox.alpha = 0.6;
        cumBox.y += (pauseGraphic.height) * 2;
        add(cumBox);

		shitterText = new FlxText(12, FlxG.height, 630, "Resume", 96);
        shitterText.setFormat(Paths.font("Mario64.ttf"), 36, FlxColor.WHITE, CENTER);
		shitterText.x = ((cumBox.width - shitterText.width) / 2) + cumBox.x;
		shitterText.y = ((cumBox.height - shitterText.height) / 2) + cumBox.y;
        add(shitterText);



		pauseMusic = new FlxSound();
		if(songName != null) {
			pauseMusic.loadEmbedded(Paths.music(songName), true, true);
		} else {
			pauseMusic.loadEmbedded(Paths.music(Paths.formatToSongPath(songName)), true, true);
		}
		pauseMusic.volume = 1;
		pauseMusic.play(false, 0.0);
		FlxG.sound.list.add(pauseMusic);


		FlxG.sound.play(Paths.sound('sm64_pause'), 0.4);
	


	    var levelInfo:FlxText = new FlxText(575, 360, 0, "", 70);
		levelInfo.text += PlayState.SONG.song;
		levelInfo.scrollFactor.set();
		levelInfo.setFormat(Paths.font("Mario64.ttf"), 36, FlxColor.WHITE, CENTER);
		levelInfo.updateHitbox();
		levelInfo.x = cumBox.x + 10;
		add(levelInfo);

		var levelDifficulty:FlxText = new FlxText(575, 415, 0, "", 70);
		 switch(PlayState.SONG.song)
		 {
		 	case 'Beta Your Copy' | 'Beta Watery Grave' | 'Beta Funhouse':
		 	songcomposer = 'by WassabiSoja';
		 	case 'Beta Better Off':
		 	songcomposer = 'by WassabiSoja, junetember';
			case 'Beta Scuttlebug':
			songcomposer = 'by junetember';
		 	case 'Better Off':
		 	songcomposer = 'by Zinkk99';
			case 'Your Copy':
		 	songcomposer = 'by Sturm';
		 	case 'Watery Grave':
			songcomposer = 'by RedTV53';
			case 'Funhouse':
			songcomposer = 'by Scrumbo, NeoBeat';
		 	case 'Scuttlebug':
			songcomposer = 'by RedTV53, Scrumbo_';
		 	case 'Shrouded':
		 	songcomposer = 'by NeoBeat';
		 }
		levelDifficulty.text += songcomposer;
		// levelDifficulty.y += (levelInfo.height) * 3;
		levelDifficulty.scrollFactor.set();
	    levelDifficulty.setFormat(Paths.font('Mario64.ttf'), 36, FlxColor.WHITE, CENTER);
		levelDifficulty.updateHitbox();
		levelDifficulty.x = cumBox.x + 10;
		add(levelDifficulty);

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	var holdTime:Float = 0;
	var cantUnpause:Float = 0.1;
	override function update(elapsed:Float)
	{
		cantUnpause -= elapsed;

		
	
		super.update(elapsed);
		updateSkipTextStuff();

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		var daSelected:String = menuItems[curSelected];
		if (accepted && (cantUnpause <= 0 || !ClientPrefs.controllerMode))
		{
			if (menuItems == difficultyChoices)
			{
				if(menuItems.length - 1 != curSelected && difficultyChoices.contains(daSelected)) {
					var name:String = PlayState.SONG.song;
					var poop = Highscore.formatSong(name, curSelected);
					PlayState.SONG = Song.loadFromJson(poop, name);
					PlayState.storyDifficulty = curSelected;
					MusicBeatState.resetState();
					FlxG.sound.music.volume = 0;
					PlayState.changedDifficulty = true;
					PlayState.chartingMode = false;
					return;
				}

				menuItems = menuItemsOG;
				regenMenu();
			}

			switch (daSelected)
			{
				case "Resume":
					close();
				case 'Change Difficulty':
					menuItems = difficultyChoices;
					deleteSkipTimeText();
					regenMenu();
				case 'Toggle Practice Mode':
					PlayState.instance.practiceMode = !PlayState.instance.practiceMode;
					PlayState.changedDifficulty = true;
					// practiceText.visible = PlayState.instance.practiceMode;
				case "Restart Song":
					restartSong();
				case "Leave Charting Mode":
					restartSong();
					PlayState.chartingMode = false;
				case 'Skip Time':
					if(curTime < Conductor.songPosition)
					{
						PlayState.startOnTime = curTime;
						restartSong(true);
					}
					else
					{
						if (curTime != Conductor.songPosition)
						{
							PlayState.instance.clearNotesBefore(curTime);
							PlayState.instance.setSongTime(curTime);
						}
						close();
					}
				case "End Song":
					close();
					PlayState.instance.finishSong(true);
				case 'Toggle Botplay':
					PlayState.instance.cpuControlled = !PlayState.instance.cpuControlled;
					PlayState.changedDifficulty = true;
					PlayState.instance.botplayTxt.visible = PlayState.instance.cpuControlled;
					PlayState.instance.botplayTxt.alpha = 1;
					PlayState.instance.botplaySine = 0;
				case "Exit to menu":
					PlayState.deathCounter = 0;
					PlayState.seenCutscene = false;

					WeekData.loadTheFirstEnabledMod();
					if(PlayState.isStoryMode) {
						MusicBeatState.switchState(new ClassifiedMainMenu());
					} else {
						MusicBeatState.switchState(new ClassifiedFreeplay());
					}
					PlayState.cancelMusicFadeTween();
					try{
						//for some reason this crashes idfk
						FlxG.sound.playMusic(Paths.music('classified_menu'));
					}catch(e:haxe.Exception){
						trace("bro: " + e);
					}
					PlayState.changedDifficulty = false;
					PlayState.chartingMode = false;
			}
		}
	}

	function deleteSkipTimeText()
	{
		if(skipTimeText != null)
		{
			skipTimeText.kill();
			remove(skipTimeText);
			skipTimeText.destroy();
		}
		skipTimeText = null;
		skipTimeTracker = null;
	}

	public static function restartSong(noTrans:Bool = false)
	{
		PlayState.instance.paused = true; // For lua
		FlxG.sound.music.volume = 0;
		PlayState.instance.vocals.volume = 0;

		if(noTrans)
		{
			FlxTransitionableState.skipNextTransOut = true;
			FlxG.resetState();
		}
		else
		{
			MusicBeatState.resetState();
		}
	}

	override function destroy()
	{
		pauseMusic.destroy();

		super.destroy();
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		FlxG.sound.play(Paths.sound('SM64_Select'), 0.4);
		// FlxG.sound.play(Paths.sound("mariopause"));
		
		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		shitterText.text = menuItems[curSelected];
		shitterText.x = ((cumBox.width - shitterText.width) / 2) + cumBox.x;
		shitterText.y = ((cumBox.height - shitterText.height) / 2) + cumBox.y;

		// var bullShit:Int = 0;

		// for (item in grpMenuShit.members)
		// {
		// 	item.targetY = bullShit - curSelected;
		// 	bullShit++;

		// 	item.alpha = 0.6;
		// 	// item.setGraphicSize(Std.int(item.width * 0.8));

		// 	if (item.targetY == 0)
		// 	{
		// 		item.alpha = 1;
		// 		// item.setGraphicSize(Std.int(item.width));

		// 		if(item == skipTimeTracker)
		// 		{
		// 			curTime = Math.max(0, Conductor.songPosition);
		// 			updateSkipTimeText();
		// 		}
		// 	}
		// }
	}

	function regenMenu():Void {
		for (i in 0...grpMenuShit.members.length) {
			var obj = grpMenuShit.members[0];
			obj.kill();
			grpMenuShit.remove(obj, true);
			obj.destroy();
		}

		for (i in 0...menuItems.length) {
			var item = new Alphabet(90, 320, menuItems[i], true);
			item.isMenuItem = true;
			item.targetY = i;
			grpMenuShit.add(item);

			if(menuItems[i] == 'Skip Time')
			{
				skipTimeText = new FlxText(0, 0, 0, '', 64);
				skipTimeText.setFormat(Paths.font("Mario64.ttf"), 64, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				skipTimeText.scrollFactor.set();
				skipTimeText.borderSize = 2;
				skipTimeTracker = item;
				add(skipTimeText);

				updateSkipTextStuff();
				updateSkipTimeText();
			}
		}
		curSelected = 0;
		changeSelection();
	}
	
	function updateSkipTextStuff()
	{
		if(skipTimeText == null || skipTimeTracker == null) return;

		skipTimeText.x = skipTimeTracker.x + skipTimeTracker.width + 60;
		skipTimeText.y = skipTimeTracker.y;
		skipTimeText.visible = (skipTimeTracker.alpha >= 1);
	}

	function updateSkipTimeText()
	{
		skipTimeText.text = FlxStringUtil.formatTime(Math.max(0, Math.floor(curTime / 1000)), false) + ' / ' + FlxStringUtil.formatTime(Math.max(0, Math.floor(FlxG.sound.music.length / 1000)), false);
	}
	function pLEASEPLAYTHEFUCKINGPAUSESOUNDEFFECTOHMYGOD(){
		FlxG.sound.play(Paths.sound("mariopause"));
	}
}
