package;

import lime.math.Vector2;
import flash.display.BitmapData;
import flixel.FlxCamera;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxRect;
import flixel.FlxG;

class FlxClippedCamera extends FlxCamera {
  @:isVar public var boundingBox(get, set):FlxRect;
  private var realTarget:FlxObject;
  private var offset:Vector2;

  function get_boundingBox() {
    if (boundingBox == null) resetBounds();
    return boundingBox;
  }
  function set_boundingBox(boundingBox) {
    updateTarget();
    if (FlxG.renderBlit)
      buffer = updateBuffer(buffer);
    return this.boundingBox = boundingBox;
  }

  override public function new(x:Int = 0, y:Int = 0, width:Int = 0, height:Int = 0, zoom:Int = 0) {
    super(x, y, width, height, zoom);
    realTarget = target;
  }
  public function resetBounds():Void {
    this.boundingBox = new FlxRect(x, y, width, height);
  }
  private inline function updateTarget():Void { 
    realTarget = target; 
    // update the offset/realTarget to be based on the `boundingBox` position too, i just cbf writing that code. 
  }
  private inline function updateBuffer(buffer:BitmapData):BitmapData {
    var spr:FlxSprite = screen.clone();
    spr.pixels = buffer;
    spr.clipRect = boundingBox;
    return spr.pixels;
  }
}