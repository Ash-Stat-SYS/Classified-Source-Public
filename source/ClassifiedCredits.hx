package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxSort;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.utils.Assets;

using StringTools;

class ClassifiedCredits extends MusicBeatState
{
    var fuckersInDaCredits:Array<Array<String>> = [
         //hi fredrick
         ['Fredrick', 'https://twitter.com/FredrickFunny', 'Director and Main Charter', '"Working with all of these people have been an absolute pleasure, everyone here have been the such a joy to work with and I love every single one of them to death, thank you for playing the mod!"'],
         ['Seeso', 'https://twitter.com/SeesoBeeso', 'Previous Director', '"hi"'],
         ['Korean Nooby', 'https://twitter.com/Korea_Nooby1122', 'Main Sprite Artist', '"tnvnfe my beloved"'],
         ['WassabiSoja', 'https://twitter.com/WassabiSoja', 'Composer of all BETA tracks', '"adding soja to my wassabi, worst mistake of my life"'],

         //artists
         ['Zepiereite', 'https://twitter.com/Zepiereite', 'Watery Grave Backgrounds, Credit Portraits, and Drew Arrows', '"coronation peach"'],
         ['Cattins', 'https://twitter.com/Cattinscool1001', 'All Art for Scuttlebug', '"I couldnt think of a good quote"'],
         ['Weedeet', 'https://twitter.com/weedeet1', 'Made Your Copy Background and Watery Grave BF Sprites', '"Sex is a myth its not real"'],
         ['Committeeofsex', 'https://twitter.com/Committeeofsex', 'Made Icons for Luigi, Wario, M, and Personalized', '"I love super mario."'],
         ['Tani', 'https://twitter.com/TaniSpiff', 'Finished Watery Grave BF Sprites', '"Fishe"'],
         ['Iseta', 'https://twitter.com/Iseta__', 'Did Your Copy Gameover Art and Credit Portraits', '"your copy"'],
         ['Anti', 'https://twitter.com/anticristadamon', 'Made the Gilbert Sprites', '"sos alto capo chavo"'],
         ['Will', 'https://twitter.com/willisaclown', 'Made Your Copy 3D Background', '"this is the only mod im in but not composing for"'],
         ['Slushy', 'https://twitter.com/Slushy_Anime', 'Modeled 3D Personalized, 3D BF, 3D GF, and Made Funhouse Background', '"i model deez nuts"'],
         ['Muberk', 'https://twitter.com/Muberk9', 'Animated 3D Personalized, Modeled 3D GF, and Made 3D Menus', '"I forgot how i got in"'],
         ['Mar', 'https://twitter.com/YourOPlayz', 'Modeled 3D BF, and Titlescreen Personalized Head', '"oonga goo gaga ginga ga googoo ginga gaga googa scrabble"'],



         //animators
         ['Rodan91',       'https://twitter.com/rodan91yt',   'Animated Wario', '"War begin...."'],
         ['Cheez', 'https://twitter.com/CheezSomething', 'Animated Luigi and Underwater Luigi', '"idk if i ever played a mario game in my life"'],
         ['Zekuta',       'https://twitter.com/ZekutaAnim', 'Animated Personalized and Your Copy GF', 'No Quote Provided.'],
         ['Mainxender', 'https://twitter.com/krabbidmoon', 'Animated M and Watery Grave BF', 'No Quote Provided.'],
         ['Vortex', 'https://twitter.com/VortexGotTaken', 'Animated Angry Wario and Arrows', '"        i identify as swag"'],

         
         //coders
         ['Ash', 'https://twitter.com/stat_is_lame', 'Main Coder', '"holy crushed ice !"'],
         ['DuskieWhy', 'https://twitter.com/DuskieWhy', 'Coder', '"Coded stuff for funsies.,....,,.,. i got on cuz of your copy"'], //u didnt get on cause of your copy u got on because of meeeeee :3
         
         //charters
         ['Decoy', 'https://www.youtube.com/watch?v=PuYZ-9zcp4w', 'Coder/Charter', '"MAY 17TH 2023, THE FOG IS COMING"'],
         ['Curious',    'https://twitter.com/curious_mp4', 'Charted BETA  Your Copy', '"i want you."'],
         
         //composers
         ['RedTV', 'https://twitter.com/RedTV53', 'Composer of Watery Grave, Scuttlebug', 'https://www.youtube.com/watch?v=cuM_inaKy6c'],
         ['NeoBeat', 'https://twitter.com/neo_beat', 'Composer of Funhouse, Shrouded', '"If you liked this mod, you should check out ARIN/ONEY KNOCK-OUT !! Featuring works from the people that brought you FNF: CLASSIFIED, this KNOCK-OUT !! mod features two arintastic, oneyrific songs that depict the ALL OUT NEWGROUNDS BRAWL between OneyNG and Egoraptor! Face off in the BATTLE OF A LIFETIME between two NEWGROUNDS ICONS to see which creator will TAKE IT ALL and which will TAKE THE FALL! You can download the mod from GameBanana and follow the OFFICIAL ARIN/ONEY KNOCK-OUT !! twitter page, where you can find updates, teasers, and MORE !!! Enjoy FNF: CLASSIFIED, and enjoy ARIN/ONEY KNOCK-OUT !! Featuring works from the people that brought you FNF: CLASSIFIED!"'],
         ['Scrumbo', 'https://twitter.com/scrumbo_', 'Composer of Funhouse and Helped with Scuttlebug', '"Hi what is Up Giys"'],
         ['Sturm', 'https://twitter.com/gurgney', 'Composer of Your Copy', '"Stay Tuned."'],
         ['Zinkk99', 'https://twitter.com/theroofofzn', 'Composer of Better Off and Credit Portraits', '"this team is amazing, im proud of everyone and of everything that we have done together, it was an amazing experience workin with u guys :), MELOSMEOATODOSPUTOSHIJOSDEPUTAWAAQUIEROESTARENCLASIFIEDMEIMPORTAUNAMIERDAMEIMPORTAUNCULOUNAVAGINAMELOSPASOPORLOSHUEVOSHIJOSDELAREVERENDAPUTAMELOSMEOATODOSMIERDAAPARECIENCLASSIFIEDYUSTEDES NO HIJOSDELAMARACAAAAHIJOSDELAMAARAAAAAAACAAAAAAAKHJASLAHJGHAVX BAFGAROPUATTAAAAAAAAAAAAAAAAAAAAAAAAAAASPUTAAAAAAAAAAAAAAAAAAAAAAAAAAS"'],
         ['Junetember', 'https://twitter.com/junetember', 'Composer of BETA Scuttlebug and Helped with BETA Better Off', '"Finger in ba bootyhole"'],
         ['Wrathstetic', 'https://twitter.com/wrathstetic', 'Composed Credits Theme', '"I CREATED TWITTER"'],
         ['FriedFrick', 'https://twitter.com/FriedFrick', 'Composed Menu Theme and Pause Music', '"Dont never buy no weed from the gas station"']
    ];


    var NICEGROUPOFPEOPLEgroup:FlxTypedGroup<FlxSprite>;
    var FUCKINGEVILBOX:FlxSprite;
    var FUCKINGEVILBOX2:FlxSprite;
    var vortexaskedforthis:FlxSprite;


    var queerText:FlxText;
    var taskText:FlxText;
    var quoteText:FlxText;
    var socialsText:FlxText;

    var curSelected:Int;

    override function create(){
        super.create();

    

		

        var YOURCOPYHOLYSHITTTT:FlxSprite = new FlxSprite().loadGraphic(Paths.image("credits/YOURCOPYREFERENCE"));
        YOURCOPYHOLYSHITTTT.scale.set(0.4, 0.4);
        YOURCOPYHOLYSHITTTT.updateHitbox();
        add(YOURCOPYHOLYSHITTTT);

        var cumshitter:FlxSprite = new FlxSprite().loadGraphic(Paths.image("credits/backFog"));
        cumshitter.scale.set(0.6, 0.6);
        cumshitter.updateHitbox();
        cumshitter.screenCenter();
        add(cumshitter);


        var spotlight:FlxSprite = new FlxSprite().loadGraphic(Paths.image('credits/spotlight'));
        spotlight.scale.set(0.4, 0.4);
        spotlight.updateHitbox();
        spotlight.screenCenter();
        add(spotlight);


        NICEGROUPOFPEOPLEgroup = new FlxTypedGroup<FlxSprite>();
        add(NICEGROUPOFPEOPLEgroup);

        for (i in 0...fuckersInDaCredits.length){
            var people:FlxSprite = new FlxSprite().loadGraphic(Paths.image('credits/people/' + fuckersInDaCredits[i][0].toLowerCase()));
            if(fuckersInDaCredits[i][0] == "DuskieWhy"){
                //yess im this petty
                //fuck you ash youre not allowed to be taller than me
                people.scale.set(0.4, 0.4);
                people.y -= 165;
                people.x -= 20;
            }else{
                people.scale.set(0.3, 0.3);
            }
            people.updateHitbox();
            people.screenCenter(X);
            people.y += 35;
            people.alpha = 0;
            people.ID = i;
            NICEGROUPOFPEOPLEgroup.add(people);
        }
      

        queerText = new FlxText(12, FlxG.height, 0, "people who worked on the mod", 48);
        queerText.screenCenter(X);
        queerText.y -= queerText.height * 1.5;
        queerText.setFormat(Paths.font("Mario64.ttf"), 36, FlxColor.WHITE, CENTER);
        add(queerText);

        FUCKINGEVILBOX = new FlxSprite().makeGraphic(Std.int(FlxG.width / 4), 640, FlxColor.GRAY);
        FUCKINGEVILBOX.alpha = 0.6;
        FUCKINGEVILBOX.x = (FlxG.width - FUCKINGEVILBOX.width) - 24;
        FUCKINGEVILBOX.y += 40;
        add(FUCKINGEVILBOX);

        FUCKINGEVILBOX2 = new FlxSprite().makeGraphic(Std.int(FlxG.width / 4) + 48, 640, FlxColor.GRAY);
        FUCKINGEVILBOX2.alpha = 0.6;
        FUCKINGEVILBOX2.x = FlxG.width - FUCKINGEVILBOX2.width;
        FUCKINGEVILBOX2.y = (FUCKINGEVILBOX.y + FUCKINGEVILBOX.height) + 24;
        add(FUCKINGEVILBOX2);

        taskText = new FlxText(12, FlxG.height, Std.int(FlxG.width / 4), "coder or charter or artist or 3d artist or musician or animator or", 24);
        taskText.setFormat(Paths.font("Mario64.ttf"), 36, FlxColor.WHITE, CENTER);
        taskText.x = FUCKINGEVILBOX.x;
        taskText.y = FUCKINGEVILBOX.y;
        add(taskText);

        quoteText = new FlxText(12, FlxG.height, Std.int(FlxG.width / 4), "No Quote Provided. DOT COM!!!!!!!! WOWOOOO I LOVE GAY PORN SO MUCH IM ADDICTED IT MAKES ME SO AHPPY I LOVEEEVEVEEV GAYH PORNRNRNRNRN", 24);
        quoteText.setFormat(Paths.font("Mario64.ttf"), 36, FlxColor.WHITE, CENTER);
        quoteText.x = FUCKINGEVILBOX2.x;
        quoteText.y = FUCKINGEVILBOX2.y;
        add(quoteText);

        socialsText = new FlxText(12, FlxG.height, Std.int(FlxG.width / 4), "press enter to check out this persons socials!", 24);
        socialsText.setFormat(Paths.font("Mario64.ttf"), 36, FlxColor.WHITE, CENTER);
        socialsText.x = FUCKINGEVILBOX2.x;
        socialsText.y = FUCKINGEVILBOX2.y + socialsText.height;
        add(socialsText);

        vortexaskedforthis = new FlxSprite(755, -70).loadGraphic(Paths.image('credits/orangutan'));
        vortexaskedforthis.scale.set(0.08, 0.08);
        add(vortexaskedforthis);

        updateTextShit();
        FlxG.sound.playMusic(Paths.music("classified_credits"), 1);
    }

    var cum:Int = 0;
    override public function update(elapsed:Float){
        var leftP = controls.UI_LEFT_P;
		var rightP = controls.UI_RIGHT_P;
		var accepted = controls.ACCEPT;
        var back = controls.BACK;
		var space = FlxG.keys.justPressed.SPACE;
       

        NICEGROUPOFPEOPLEgroup.sort(CoolUtil.sortByID, FlxSort.DESCENDING);

        //controls shit
        if(leftP)
            changeSelection(-1);
        if(rightP)
            changeSelection(1);
        if(accepted)
            CoolUtil.browserLoad(fuckersInDaCredits[curSelected][1]);
        if(back){
			MusicBeatState.switchState(new ClassifiedMainMenu());
            FlxG.sound.play(Paths.sound("back"));
        }

        for(cock in NICEGROUPOFPEOPLEgroup.members){
            if(curSelected == cock.ID){
                // cock.alpha = 1;
                cock.alpha = FlxMath.lerp(cock.alpha, 1, CoolUtil.boundTo(elapsed * 5, 0, 1));
                if(fuckersInDaCredits[cock.ID][0] == "Scrumbo"){
                    cock.scale.x += 0.000125;
                    // have fun buddy
                }
            }else{
                cock.alpha = FlxMath.lerp(cock.alpha, 0, CoolUtil.boundTo(elapsed * 5, 0, 1));
                // cock.alpha = 0;
            }
        }

        if (fuckersInDaCredits[curSelected][0] == "Vortex"){ vortexaskedforthis.visible = true; }
        else{ vortexaskedforthis.visible = false; }

        if(accepted)
        if(fuckersInDaCredits[curSelected][0] == "RedTV")
        CoolUtil.browserLoad(fuckersInDaCredits[curSelected][3]);

        super.update(elapsed);
    }

    override function destroy(){
        super.destroy();
    }

    function changeSelection(posOrNeg:Int){
        if(posOrNeg == 1){
            curSelected ++;
        }else if(posOrNeg == -1){
            curSelected --;
        }
        if(curSelected > NICEGROUPOFPEOPLEgroup.length - 1)
            curSelected = 0;
        if(curSelected < 0)
            curSelected = NICEGROUPOFPEOPLEgroup.length - 1;
        updateTextShit();
        FlxG.sound.play(Paths.sound("select"));
    }

    function updateTextShit(){
        cum = curSelected + 1;
        queerText.text = fuckersInDaCredits[curSelected][0] + '  -  [' + cum + '/' + NICEGROUPOFPEOPLEgroup.length + ']';
        queerText.screenCenter(X);

        taskText.text = fuckersInDaCredits[curSelected][2];
        quoteText.text = fuckersInDaCredits[curSelected][3];
        
        FUCKINGEVILBOX.makeGraphic(Std.int(FlxG.width / 4), Std.int(taskText.height) + 12, FlxColor.GRAY);
        FUCKINGEVILBOX2.makeGraphic(Std.int(FlxG.width / 4) + 48, (Std.int(quoteText.height) + 12) + (Std.int(socialsText.height)) + 12, FlxColor.GRAY);
        FUCKINGEVILBOX.x = ((FlxG.width - FUCKINGEVILBOX.width) - 24) - 6;
        FUCKINGEVILBOX2.x = (FlxG.width - FUCKINGEVILBOX2.width) - 6;
        FUCKINGEVILBOX2.y = (FUCKINGEVILBOX.y + FUCKINGEVILBOX.height) + 24;

        taskText.x = ((FUCKINGEVILBOX.width - taskText.width) / 2) + FUCKINGEVILBOX.x;
        taskText.y = FUCKINGEVILBOX.y + 6;

        quoteText.x = ((FUCKINGEVILBOX2.width - quoteText.width) / 2) + FUCKINGEVILBOX2.x;
        quoteText.y = FUCKINGEVILBOX2.y + 6;

        socialsText.x = ((FUCKINGEVILBOX2.width - socialsText.width) / 2) + FUCKINGEVILBOX2.x;
        socialsText.y = quoteText.height + (FUCKINGEVILBOX2.y + 6) + 12;
        // ava make this go in the box i dont know how to :face_holding_back_tears:

    }
}