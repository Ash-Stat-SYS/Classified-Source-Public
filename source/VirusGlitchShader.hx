package;

// STOLEN FROM HAXEFLIXEL DEMO LOL
import flixel.system.FlxAssets.FlxShader;
import openfl.display.BitmapData;
import openfl.display.Shader;
import openfl.display.ShaderInput;
import openfl.utils.Assets;
import flixel.FlxG;
import openfl.Lib;

class VirusGlitchEffect
{
    public var shader(default, null):VirusGlitchShader = new VirusGlitchShader();

    public var time(default, set):Float = 0;
    public var resolution(default, set):Float = 0;
    public var enabled(default, set):Bool = true;
    public var colorMultiplier(default, set):Float = 0;
    public var hasColorTransform(default, set):Bool = false;

    public function new(res:Float, time:Float, colorMultiplier:Float, colorTransform:Bool):Void
    {
        set_time(time);
        set_resolution(res);
        set_colorMultiplier(colorMultiplier);
        set_hasColorTransform(colorTransform);
        shader.uEnabled.value = [false];
    }
    public function update(elapsed:Float):Void
    {
        shader.time.value[0] += elapsed;
    }
    public function set_resolution(v:Float):Float
    {
        resolution = v;
        shader.screenSize.value = [resolution];
        return this.resolution;
    }
    function set_enabled(v:Bool):Bool
    {
        shader.uEnabled.value = [enabled = v];
        return v;
    }
	function set_hasColorTransform(value:Bool):Bool {
		this.hasColorTransform = value;
        shader.hasColorTransform.value = [hasColorTransform];
        return hasColorTransform;
	}

	function set_colorMultiplier(value:Float):Float {
        this.colorMultiplier = value;
        shader.colorMultiplier.value = [value];
        return this.colorMultiplier;
    }

	function set_time(value:Float):Float {
        this.time = value;
        shader.time.value = [value];
        return this.time;
    }
}

class VirusGlitchShader extends FlxShader
{
    @:glFragmentSource('
    #pragma header

    // ---- gllock required fields -----------------------------------------------------------------------------------------
    #define RATE 0.75
    
    uniform float time;
    uniform float end;
    uniform sampler2D imageData;
    uniform vec2 screenSize;
    uniform bool uEnabled;
    // ---------------------------------------------------------------------------------------------------------------------
    
    float rand(vec2 co){
      return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453) * 2.0 - 1.0;
    }
    
    float offset(float blocks, vec2 uv) {
      float shaderTime = time*RATE;
      return rand(vec2(shaderTime, floor(uv.y * blocks)));
    }
    
    void main(void) {
      vec2 uv = openfl_TextureCoordv;
      if (!uEnabled) {
        gl_FragColor = texture(bitmap, uv);
        return;
      }
      gl_FragColor = texture(bitmap, uv);
      gl_FragColor.r = texture(bitmap, uv + vec2(offset(64.0, uv) * 0.03, 0.0)).r;
      gl_FragColor.g = texture(bitmap, uv + vec2(offset(64.0, uv) * 0.03 * 0.16666666, 0.0)).g;
      gl_FragColor.b = texture(bitmap, uv + vec2(offset(64.0, uv) * 0.03, 0.0)).b;
    }
    ')

    public function new()
    {
        super();
    }
}
class Effect {
	public function setValue(shader:FlxShader, variable:String, value:Float){
		Reflect.setProperty(Reflect.getProperty(shader, 'variable'), 'value', [value]);
	}
}