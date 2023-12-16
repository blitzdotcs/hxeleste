package game;

import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import backend.OldPaths;

using StringTools;

class Chars extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'madeline';

	public function new(x:Float, y:Float, ?character:String = "madeline", ?isPlayer:Bool = false)
	{
		animOffsets = new Map<String, Array<Dynamic>>();
		super(x, y);

		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'madeline':
            {
				tex = OldPaths.getSparrowAtlas('MadelineNorm');
				frames = tex;
			    animation.addByPrefix('norm', "idle0", 6);
                playAnim('norm');
				antialiasing = false;
				setGraphicSize(Std.int(width * states.game.PlayState.pixelzoomshit));
            }    
		}
	}

	override function update(elapsed:Float)
    {
		super.update(elapsed);
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(animation.curAnim.name);
		if (animOffsets.exists(animation.curAnim.name))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}