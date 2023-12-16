package game;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
#if desktop
import flixel.input.gamepad.FlxGamepad;
#end
import backend.OldPaths;
import flixel.graphics.frames.FlxAtlasFrames;
import game.Chars;

class Madeline extends Chars
{
	public static inline var SPEED:Float = 90;
	static inline var GRAVITY:Float = 900;
	static inline var JUMP_POWER:Float = 100;
    static inline var DASH_POWER:Float = 100;
	public var canMove:Bool = true;
	var jumping:Bool = false;
	var jumpTimer:Float = 0;
    var dashing:Bool = false;
    var dashTimer:Float = 0;
    public var isDashing:Bool = false;
	var touch1_X:Float;
	var touch2_X:Float;
	public var gamepad:FlxGamepad;
	
	public function new(x:Float = 0, y:Float = 0, kinematic:Bool = false)
	{
		super(x, y);
		canMove = !kinematic;

		setSize(8, 8);
		offset.set(2, 6);

		if (canMove)
		{
			this.drag.x = SPEED * 10;
			this.acceleration.y = GRAVITY;
		}
	}

	override function setPosition(X:Float = 0, Y:Float = 0)
	{
		x = X + offset.x;
		y = Y + offset.y;
	}

	function movement(elapsed:Float)
	{
		if (FlxG.keys.pressed.LEFT && !FlxG.keys.pressed.RIGHT)
		{
			velocity.x = -SPEED;
			facing = FlxObject.LEFT;
		}

		if (FlxG.keys.pressed.RIGHT && !FlxG.keys.pressed.LEFT)
		{
			velocity.x = SPEED;
			facing = FlxObject.RIGHT;
		}

		if (jumping && !FlxG.keys.pressed.Z)
			jumping = false;

		if (FlxG.keys.pressed.Z && jumpTimer == -1 && isTouching(FlxObject.DOWN))

		if (isTouching(FlxObject.DOWN) && !jumping)
			jumpTimer = 0;

		if (jumpTimer >= 0 && FlxG.keys.pressed.Z)
		{
			jumping = true;
			jumpTimer += elapsed;
		}
		else
			jumpTimer = -1;

		if (jumpTimer > 0 && jumpTimer < .25)
			velocity.y = -JUMP_POWER;

        if (dashing && !FlxG.keys.pressed.X)
			dashing = false;

		if (FlxG.keys.pressed.X && dashTimer == -1 && isTouching(FlxObject.DOWN))

		if (isTouching(FlxObject.DOWN) && !dashing)
			dashTimer = 0;

		if (dashTimer >= 0 && FlxG.keys.pressed.X)
		{
			dashing = true;
			dashTimer += elapsed;
		}
		else
			dashTimer = -1;

		if (dashTimer > 0 && dashTimer < .25)
			velocity.y = -DASH_POWER;

        // reg

		if (FlxG.keys.pressed.X && velocity.y == 0)
		{
			isDashing = true;
			velocity.y = DASH_POWER;
		}
	}

	override function update(elapsed:Float)
	{
		if (canMove && !isDashing)
		{
			movement(elapsed);
		}

		super.update(elapsed);
	}
}