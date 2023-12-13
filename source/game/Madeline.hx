package game;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
#if desktop
import flixel.input.gamepad.FlxGamepad;
#end
import backend.Paths;

class Madeline extends FlxSprite
{
	public static inline var SPEED:Float = 90;
	public static var SKIN:String = Paths.getImage("Madeline");
	static inline var GRAVITY:Float = 900;
	static inline var JUMP_POWER:Float = 100;
    static inline var DASH_POWER:Float = 100;

	public var canMove:Bool = true;
	public var animated:Bool = true;

	var jumping:Bool = false;
	var jumpTimer:Float = 0;
    var dashing:Bool = false;
    var dashTimer:Float = 0;
    public var isDashing:Bool = false;

	var touch1_X:Float;
	var touch2_X:Float;

	#if desktop
	public var gamepad:FlxGamepad;
	#end

	function loadSkin()
	{
		loadGraphic(SKIN, true, 12, 24);

		// para las colisiones
		setSize(8, 18);
		offset.set(2, 6);

		// para las animaciones
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		animation.add("idle0", [1], 5);
	}

	public function new(x:Float = 0, y:Float = 0, kinematic:Bool = false)
	{
		super(x, y);
		loadSkin();
		canMove = !kinematic;

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
		var jump:Bool = false,
			left:Bool = false,
			right:Bool = false,
			dash:Bool = false;

		var jumpAlt:Bool = false,
			leftAlt:Bool = false,
			rightAlt:Bool = false,
			dashAlt:Bool = false;

		if (gamepad != null)
		{
			jumpAlt = gamepad.pressed.A;
			leftAlt = gamepad.analog.value.LEFT_STICK_X < 0 || gamepad.pressed.DPAD_LEFT;
			rightAlt = gamepad.analog.value.LEFT_STICK_X > 0 || gamepad.pressed.DPAD_RIGHT;
			dashAlt = gamepad.pressed.B;
		}

		jump = FlxG.keys.anyPressed([Z, C]) || jumpAlt;
		left = FlxG.keys.pressed.LEFT || leftAlt;
		right = FlxG.keys.pressed.RIGHT || rightAlt;
		dash = FlxG.keys.anyJustPressed([X]) || dashAlt;

		if (left && !right)
		{
			velocity.x = -SPEED;
			facing = FlxObject.LEFT;
		}

		if (right && !left)
		{
			velocity.x = SPEED;
			facing = FlxObject.RIGHT;
		}

		if (jumping && !jump)
			jumping = false;

		if (jump && jumpTimer == -1 && isTouching(FlxObject.DOWN))

		if (isTouching(FlxObject.DOWN) && !jumping)
			jumpTimer = 0;

		if (jumpTimer >= 0 && jump)
		{
			jumping = true;
			jumpTimer += elapsed;
		}
		else
			jumpTimer = -1;

		if (jumpTimer > 0 && jumpTimer < .25)
			velocity.y = -JUMP_POWER;

        // dash shit lol (A copy of the jump thing so basically as of rn it's a double jump)
        if (dashing && !dash)
			dashing = false;

		if (dash && dashTimer == -1 && isTouching(FlxObject.DOWN))

		if (isTouching(FlxObject.DOWN) && !dashing)
			dashTimer = 0;

		if (dashTimer >= 0 && dash)
		{
			dashing = true;
			dashTimer += elapsed;
		}
		else
			dashTimer = -1;

		if (dashTimer > 0 && dashTimer < .25)
			velocity.y = -DASH_POWER;

        // reg

		if (dash && velocity.y == 0)
		{
			isDashing = true;
			velocity.y = DASH_POWER;
		}
	}

	function playerAnimation()
	{
		if (!isTouching(FlxObject.DOWN) && canMove)
			animation.play("idle");
		else
		{
			if (!isDashing)
			{
				if (velocity.x != 0)
					animation.play("idle");
				else
					animation.play("idle");
			}
			else
			{
				if (animation.finished)
					isDashing = false;
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (canMove && !isDashing)
		{
			movement(elapsed);
		}
		if (animated)
			playerAnimation();

		super.update(elapsed);
	}
}