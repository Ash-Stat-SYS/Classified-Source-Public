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
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;

using StringTools;

class ClassifiedFreeplay extends MusicBeatState
{
    var songList:Array<String> = [
        'Watery Grave',
        'Funhouse',
        'Your Copy',
        'Shrouded',
        'Scuttlebug',
        'Better Off'
    ];
    var portraitGroup:FlxTypedGroup<FlxSprite>;
    var songText:FlxText;
    var bg:FlxSprite;
    var gf:FlxSprite;
    var bf:FlxSprite;
    var gray:FlxSprite;
    var warningBlx:FlxSprite;
    var warningTxt:FlxText;

    var curSelected:Int = 0;

    override function create() {
        portraitGroup = new FlxTypedGroup<FlxSprite>();
        for(i in 0...songList.length){
            var portrait:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('freeplay/paintings/${songList[i].toLowerCase()}'));
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
        add(portraitGroup);

        bg = new FlxSprite().loadGraphic(Paths.image("freeplay/bg/room"));
        bg.setGraphicSize(Std.int(bg.width / 3));
        bg.updateHitbox();
        add(bg);

        bf = new FlxSprite().loadGraphic(Paths.image("freeplay/bfAndGf/bf"));
        bf.setGraphicSize(Std.int(bf.width / 3));
        bf.updateHitbox();
        add(bf);

        gf = new FlxSprite().loadGraphic(Paths.image('freeplay/bfAndGf/gf${FlxG.random.int(1,4)}'));
        gf.setGraphicSize(Std.int(gf.width / 3));
        gf.updateHitbox();
        add(gf);

        var arrow:FlxSprite = new FlxSprite().loadGraphic(Paths.image("freeplay/bg/arrow"));
        arrow.setGraphicSize(Std.int(arrow.width / 3));
        arrow.updateHitbox();
        add(arrow);

        var arrow:FlxSprite = new FlxSprite().loadGraphic(Paths.image("freeplay/bg/arrow"));
        arrow.setGraphicSize(Std.int(arrow.width / 3));
        arrow.updateHitbox();
        arrow.angle = 180;
        add(arrow);

        songText = new FlxText(12, FlxG.height, FlxG.width, "GAY SEX DOT COM!!!!!!!! WOWOOOO I LOVE GAY PORN SO MUCH IM ADDICTED IT MAKES ME SO AHPPY I LOVEEEVEVEEV GAYH PORNRNRNRNRN", 24);
        songText.setFormat(Paths.font("sm64-v2-1.ttf"), 36, FlxColor.WHITE, CENTER);
        songText.y = 50;
        add(songText);
       
        gray = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        gray.alpha = 0;
        add(gray);

        warningTxt = new FlxText(12, FlxG.height, FlxG.width, "This song has some effects that might be triggering to those with epilepsy.\nIf you have epilepsy, please avoid this song or turn shaders to DISABLED in settings.\nOtherwise, Enjoy!", 24);
        warningTxt.setFormat(Paths.font("sm64-v2-1.ttf"), 30, FlxColor.WHITE, CENTER);
        // warningTxt.y = 50;
        warningTxt.screenCenter();
        warningTxt.alpha = 0;

        warningBlx = new FlxSprite().makeGraphic(Std.int(warningTxt.width), Std.int(warningTxt.height + 24), FlxColor.GRAY);
        warningBlx.alpha = 0;
        warningBlx.screenCenter();

        add(warningBlx);
        add(warningTxt);

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

        if(song != "scuttlebug"){
            LoadingState.loadAndSwitchState(new PlayState(), false, true);
            FlxTween.tween(FlxG.sound.music, {volume: 0}, 1.2);    
        }else{
            FlxTween.tween(gray, {alpha: 0.6});
            FlxTween.tween(warningBlx, {alpha: 0.8});
            FlxTween.tween(warningTxt, {alpha: 1});
            new FlxTimer().start(8, function(tmr:FlxTimer){
                LoadingState.loadAndSwitchState(new PlayState(), false, true);
                FlxTween.tween(FlxG.sound.music, {volume: 0}, 1.2);  
            });
        }
    }
    function updatePortraits(){
        for(i in portraitGroup.members){
            if(curSelected == i.ID){
                i.alpha = 1;   
                songText.text = songList[i.ID];
                songText.screenCenter(X);
                if(songList[i.ID] == "Shrouded"){
                    bg.loadGraphic(Paths.image("freeplay/bg/roomEvil"));
                    bf.visible = false;
                    gf.visible = false;
                    FlxG.sound.music.volume = 0;
                }else{
                    bg.loadGraphic(Paths.image("freeplay/bg/room"));
                    bf.visible = true;
                    gf.visible = true;
                    FlxG.sound.music.volume = FlxG.sound.volume;
                }
            }
            else
                i.alpha = 0;
        }
    }
}
