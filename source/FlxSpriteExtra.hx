package;

import flixel.graphics.FlxGraphic;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class FlxSpriteExtra extends FlxSprite
{
	override function makeGraphic(Width:Int, Height:Int, Color:FlxColor = FlxColor.WHITE, Unique:Bool = false, ?Key:String):FlxSpriteExtra {
		return cast super.makeGraphic(Width, Height, Color, Unique, Key);
	}

	public function makeSolid(Width:Int, Height:Int, Color:FlxColor = FlxColor.WHITE, Unique:Bool = false, ?Key:String):FlxSpriteExtra
	{
		var graph:FlxGraphic = FlxG.bitmap.create(1, 1, Color, Unique, Key);
		frames = graph.imageFrame;
		scale.set(Width, Height);
		updateHitbox();
		return this;
	}

	public var visWidth(get, never):Float;
	public var visHeight(get, never):Float;

	inline function get_visWidth():Float {
		return Math.abs(scale.x) * frameWidth;
	}
	inline function get_visHeight():Float {
		return Math.abs(scale.y) * frameHeight;
	}

	public inline function hideFull() {
		alpha = 0;
	}

	public inline function hide() {
		alpha = 0.0001;
	}
	public inline function show() {
		alpha = 1;
	}
}