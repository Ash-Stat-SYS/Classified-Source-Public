package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

using StringTools;

class ClassifiedBetaFreeplay extends MusicBeatState
{
    var songList:Array<String> = [
        'Beta Watery Grave',
        'Beta Funhouse',
        'Beta Your Copy',
        'Beta Scuttlebug',
        'Beta Better Off'
    ];
    var portraitGroup:FlxTypedGroup<FlxSprite>;
    var songText:FlxText;
    var betaText:FlxText;
   

    var curSelected:Int = 0;

    override function create() {
        portraitGroup = new FlxTypedGroup<FlxSprite>();
        for(i in 0...songList.length){
            var portrait:FlxSprite = new FlxSprite();
            if(songList[i].toLowerCase() == "better off"){
                portrait.setGraphicSize(Std.int(portrait.width / 3.5));
                portrait.updateHitbox();
                portrait.x += 125;
            }
            else{
                portrait.setGraphicSize(Std.int(portrait.width / 3));
                portrait.updateHitbox();
            }
            portrait.ID = i;
          portraitGroup.add(portrait);
        }
        //add(portraitGroup);

        betaText = new FlxText(12, FlxG.height, FlxG.width, "BETA SUPER MARIO 64 (1996 BUILD)", 24);
        betaText.setFormat(Paths.font("vcr.ttf"), 36, FlxColor.WHITE, CENTER);
        betaText.y = 50;
        add(betaText);

    

        songText = new FlxText(12, FlxG.height, FlxG.width, "GAY SEX DOT COM!!!!!!!! WOWOOOO I LOVE GAY PORN SO MUCH IM ADDICTED IT MAKES ME SO AHPPY I LOVEEEVEVEEV GAYH PORNRNRNRNRN", 24);
        songText.setFormat(Paths.font("vcr.ttf"), 36, FlxColor.WHITE, CENTER);
        songText.y = 100;
        add(songText);

        super.create();
        updatePortraits();

    }

    override public function update(elapsed:Float) {
        var leftP = controls.UI_LEFT_P;
		var rightP = controls.UI_RIGHT_P;
		var accepted = controls.ACCEPT;
        var back = controls.BACK;
		var space = FlxG.keys.justPressed.SPACE;

        if(leftP)
            changeSelection(-1);
        if(rightP)
            changeSelection(1);
        if(accepted)
            loadSong(songList[curSelected].toLowerCase());
        if(back){
			MusicBeatState.switchState(new ClassifiedMainMenu());
            FlxG.sound.play(Paths.sound("back"));
        }

        super.update(elapsed);
    }

    function changeSelection(posOrNeg:Int){
        if(posOrNeg == 1){
            curSelected ++;
        }else if(posOrNeg == -1){
            curSelected --;
        }
        if(curSelected > portraitGroup.length - 1)
            curSelected = 0;
        if(curSelected < 0)
            curSelected = portraitGroup.length - 1;
        updatePortraits();
        FlxG.sound.play(Paths.sound("select"));
    }

    function loadSong(song:String) {

        PlayState.SONG = Song.loadFromJson(Paths.formatToSongPath(song), song);
        PlayState.isStoryMode = false;
        PlayState.storyDifficulty = 1;

        LoadingState.loadAndSwitchState(new PlayState(), false, true);
        FlxTween.tween(FlxG.sound.music, {volume: 0}, 1.2);
    }
    function updatePortraits(){
        for(i in portraitGroup.members){
            if(curSelected == i.ID){
                i.alpha = 1;   
                songText.text = songList[i.ID];
                songText.screenCenter(X);
                FlxG.sound.music.volume = FlxG.sound.volume;
            }
            else
                i.alpha = 0;
        }
    }
}

