// this ver of playstate just removes the level shit and just adds madeline
package states.game;

import flixel.FlxState;
import game.Madeline;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import backend.AssetPaths;
import flixel.tile.FlxTilemap;
import flixel.FlxG;
import backend.Paths;
import backend.OldPaths;
import haxe.Json;
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.FlxSprite;

typedef LevelDataq =
{
	var map:String;
	var player:String;
}

class PlayState2 extends FlxState
{
	public static var player:Madeline;
	var map:FlxOgmo3Loader;
	var tileMap:FlxTilemap;
	public static var LEVEL:Int = 1;
	var walls:FlxTilemap;
	var maincam:FlxCamera;

	override public function create()
	{
		var jokebg:FlxSprite;
		jokebg = new FlxSprite(FlxG.width * 0.4, FlxG.height * 0.07).loadGraphic(OldPaths.image('testbg'));
		add(jokebg);

		maincam = new FlxCamera(0, 0, FlxG.width, FlxG.height);
        FlxG.cameras.add(maincam);
        FlxCamera.defaultCameras = [maincam];

		player = new Madeline(0, 0);
		add(player);

		maincam.follow(player, FlxCameraFollowStyle.LOCKON);
        maincam.zoom = 0.1;

		super.create();
	}

	override public function update(elapsed:Float)
	{
        super.update(elapsed);
	}
}