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
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

using StringTools;


var loadedWeeks:Array<WeekData> = [];

class ClassifiedMainMenu extends MusicBeatState
{
    var optionStuff:Array<String> = [
        'Story Mode',
        'Freeplay',
        'Credits',
        'Options'
    ];
    var cumShitFartShitBallsDickCock:FlxTypedGroup<FlxSprite>;
    var greenbutton:FlxSprite;
    var bluebutton:FlxSprite;
    var redbutton:FlxSprite;
    var purplebutton:FlxSprite;



    override function create(){
        super.create();
        FlxG.mouse.visible = true;
        
        var yellowCunFart:FlxSprite = new FlxSprite().loadGraphic(Paths.image("mainmenushit/funnyBG"));
        yellowCunFart.screenCenter();
        add(yellowCunFart);

        cumShitFartShitBallsDickCock = new FlxTypedGroup<FlxSprite>();
        add(cumShitFartShitBallsDickCock);

        addDickCockSucker(0, 330, 176);
        addDickCockSucker(1, 660, 176);
        addDickCockSucker(2, 330, 315);
        addDickCockSucker(3, 660, 315);

        
        var greenbutton:FlxSprite = new FlxSprite(-105, 25).loadGraphic(Paths.image("mainmenushit/Quite_Green"));
        greenbutton.scale.set(0.150, 0.150);
        add(greenbutton);

        var bluebutton:FlxSprite = new FlxSprite(75, 25).loadGraphic(Paths.image("mainmenushit/Bluestone1"));
        bluebutton.scale.set(0.150, 0.150);
        add(bluebutton);


        var redbutton:FlxSprite = new FlxSprite(250, 25).loadGraphic(Paths.image("mainmenushit/RedStone1"));
        redbutton.scale.set(0.150, 0.150);
        add(redbutton);


        var purplebutton:FlxSprite = new FlxSprite(410, 25).loadGraphic(Paths.image("mainmenushit/Purple1"));
        purplebutton.scale.set(0.150, 0.150);
        add(purplebutton);

        var file:FlxSprite = new FlxSprite(0, 96).loadGraphic(Paths.image("mainmenushit/phile"));
        file.scale.set(2.8, 2.8);
        file.updateHitbox();
        file.screenCenter(X);
        add(file);


        // if(FlxG.sound == null)
        FlxG.sound.playMusic(Paths.music("classified_menu"));
    }

    function addDickCockSucker(id:Int, x:Float, y:Float){
        var button:FlxSprite = new FlxSprite(x, y);
        // if(id != 1){
            button.loadGraphic(Paths.image("mainmenushit/button"));
        // }else{
            // if(!ClientPrefs.freeplayUnlocked){
                // button.loadGraphic(Paths.image("mainmenushit/lockedbutton"));
            // }
            // else{
                // button.loadGraphic(Paths.image("mainmenushit/button"));
            // }
        // }
            
        button.ID = id;
        button.scale.set(0.9, 0.9);
        cumShitFartShitBallsDickCock.add(button);

        var cum:FlxText = new FlxText(12, FlxG.height, 0, optionStuff[id], 24);
        cum.setFormat(Paths.font("Mario64.ttf"), 36, FlxColor.WHITE, LEFT);
        cum.x = (button.x + button.width) + 10;
        cum.y = y;
        add(cum);
    }


   

    var canClick:Bool = true;

    override function update(elapsed:Float) 
    {
        super.update(elapsed);
        
        for (COCKKKK in cumShitFartShitBallsDickCock.members){
            if(FlxG.mouse.overlaps(COCKKKK)){
                COCKKKK.scale.x = FlxMath.lerp(COCKKKK.scale.x, 1.15, CoolUtil.boundTo(elapsed * 10, 0, 1));
                COCKKKK.scale.y = FlxMath.lerp(COCKKKK.scale.y, 1.15, CoolUtil.boundTo(elapsed * 10, 0, 1));
                
                if(FlxG.mouse.pressed && canClick){

                    canClick = false;
                    // FlxG.camera.fade(FlxColor.WHITE, 1);
                    var daChoice:String = optionStuff[COCKKKK.ID];
    
                    switch(daChoice){
                        case 'Story Mode':
                            loadWeek();
                            FlxG.sound.play(Paths.sound('select'));
                        case 'Freeplay':
                            // if(ClientPrefs.freeplayUnlocked){
                                MusicBeatState.switchState(new ClassifiedFreeplay());
                                FlxG.sound.play(Paths.sound('select'));
    
                            // }else{
                            //     FlxG.camera.shake(0.06125, 0.125);
                            //     new FlxTimer().start(0.25, function(tmr:FlxTimer) {
                            //         canClick = true;
                            //     });
                            // }
                        case 'Credits':
                            MusicBeatState.switchState(new ClassifiedCredits());
                            FlxG.sound.play(Paths.sound('select'));
                        case 'Options':
                            FlxG.sound.play(Paths.sound('select'));
                            LoadingState.loadAndSwitchState(new options.OptionsState());
                    }
                }
            }
            else{
                COCKKKK.scale.x = FlxMath.lerp(COCKKKK.scale.x, 0.9, CoolUtil.boundTo(elapsed * 7.5, 0, 1));
                COCKKKK.scale.y = FlxMath.lerp(COCKKKK.scale.y, 0.9, CoolUtil.boundTo(elapsed * 7.5, 0, 1));
                
            }
        }
        if (controls.BACK)
        {
            FlxG.sound.play(Paths.sound('back'));
            MusicBeatState.switchState(new TitleState());
        }

        if(FlxG.keys.justPressed.B){
            MusicBeatState.switchState(new ClassifiedBetaFreeplay());
        }
        if(FlxG.keys.justPressed.F){
            MusicBeatState.switchState(new ClassifiedFreeplay());
        }
        
    
    }

 

    function loadWeek()
    {
        PlayState.storyPlaylist = ['Watery Grave', 'Funhouse', 'Your Copy'];
        PlayState.isStoryMode = true;

        PlayState.SONG = Song.loadFromJson(StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase(), StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase());        
        PlayState.campaignScore = 0;
        PlayState.storyDifficulty = 2;
        Paths.currentModDirectory = "shared";
        Paths.currentLevel = "shared";
   
        MusicBeatState.switchStateSM64(new PlayState());
    }
}