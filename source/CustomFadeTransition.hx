package;

import Conductor.BPMChangeEvent;
import flixel.FlxG;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxGradient;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.FlxCamera;

class CustomFadeTransition extends MusicBeatSubstate {
	public static var finishCallback:Void->Void;
	private var leTween:FlxTween = null;
	public static var nextCamera:FlxCamera;
	var isTransIn:Bool = false;
	var transWhite:FlxSprite;
	var transGradient:FlxSprite;

	public function new(duration:Float, isTransIn:Bool, sound:Bool = false) {
		super();

		this.isTransIn = isTransIn;
		var zoom:Float = CoolUtil.boundTo(FlxG.camera.zoom, 0.05, 1);
		var width:Int = Std.int(FlxG.width / zoom);
		var height:Int = Std.int(FlxG.height / zoom);
		// transGradient = FlxGradient.createGradientFlxSprite(width, height, (isTransIn ? [0x0, FlxColor.BLACK] : [FlxColor.BLACK, 0x0]));
		// transGradient.scrollFactor.set();
		// add(transGradient);

		transWhite = new FlxSprite().makeGraphic(width, height + 400, FlxColor.WHITE);
		transWhite.scrollFactor.set();
		add(transWhite);

		// transGradient.x -= (width - FlxG.width) / 2;
		// transWhite.x = transGradient.x;

		if(isTransIn) {
			transWhite.alpha = 1;
			FlxTween.tween(transWhite, {alpha: 0}, duration, {
				onComplete: function(twn:FlxTween) {
					close();
				}
			});
			// transGradient.y = transWhite.y - transWhite.height;
			// FlxTween.tween(transGradient, {y: transGradient.height + 50}, duration, {
			// 	onComplete: function(twn:FlxTween) {
			// 		close();
			// 	},
			// ease: FlxEase.linear});
		} else {
			transWhite.alpha = 0;
			FlxTween.tween(transWhite, {alpha: 1}, duration, {
				onComplete: function(twn:FlxTween) {
					if(finishCallback != null) {
						finishCallback();
					}
				}
			});
			if(sound)
				FlxG.sound.play(Paths.sound("sparkle"));
			// transGradient.y = -transGradient.height;
			// transWhite.y = transGradient.y - transWhite.height + 50;
			// leTween = FlxTween.tween(transGradient, {y: transGradient.height + 50}, duration, {
			// 	onComplete: function(twn:FlxTween) {
			// 		if(finishCallback != null) {
			// 			finishCallback();
			// 		}
			// 	},
			// ease: FlxEase.linear});
		}

		if(nextCamera != null) {
			transWhite.cameras = [nextCamera];
			// transGradient.cameras = [nextCamera];
		}
		nextCamera = null;
	}

	override function update(elapsed:Float) {
		if(isTransIn) {
			// transWhite.y = transGradient.y + transGradient.height;
		} else {
			// transWhite.y = transGradient.y - transWhite.height;
		}
		super.update(elapsed);
		if(isTransIn) {
		// 	transWhite.y = transGradient.y + transGradient.height;
		} else {
		// 	transWhite.y = transGradient.y - transWhite.height;
		}
	}

	override function destroy() {
		if(leTween != null) {
			finishCallback();
			leTween.cancel();
		}
		super.destroy();
	}
}