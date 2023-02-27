package;

import flixel.system.FlxAssets.FlxShader;
import openfl.display.BitmapData;
import openfl.display.ShaderInput;
import openfl.utils.Assets;
import flixel.FlxG;
import openfl.Lib;

class CamFuckShader extends FlxShader
{    
    @:glFragmentSource('
    #pragma header

    uniform sampler2D bgImage;
    uniform vec3 iResolution;

    void main()
    {        
        vec2 uv = openfl_TextureCoordv;
        vec2 uv2= openfl_TextureCoordv;
        uv *= 1.5;
        uv += vec2(-.25, -.25);
        vec3 col = texture2D(bitmap, uv).rgb;
        if(uv.x < 0.|| uv.x > 1.|| uv.y < 0.|| uv.y > 1.)
            col = texture2D(bgImage, uv2).rgb;
        gl_FragColor = vec4(col,1.0);
    }
    ')

    public function new(){
        super();
    }
}