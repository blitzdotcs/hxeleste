package states.game;

import flixel.FlxState;
import game.Madeline;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import backend.AssetPaths;
import flixel.tile.FlxTilemap;
import flixel.FlxG;
import backend.Paths;
import haxe.Json;
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.FlxSprite;

typedef LevelData =
{
	var map:String;
	var player:String;
}

class PlayState extends FlxState
{
	public static var player:Madeline;
	var map:FlxOgmo3Loader;
	var tileMap:FlxTilemap;
	public static var LEVEL:Int = 1;
	var walls:FlxTilemap;
	var maincam:FlxCamera;

	override public function create()
	{
		maincam = new FlxCamera(0, 0, FlxG.width, FlxG.height);
        FlxG.cameras.add(maincam);
        FlxCamera.defaultCameras = [maincam];
		
		var level:LevelData = Json.parse((Paths.getLevelUno()));

		map = new FlxOgmo3Loader(Paths.getOgmoData(), Paths.getMapUno());
		tileMap = map.loadTilemap(Paths.getImage("tileMap"), "Blocks");
		add(tileMap);

		walls = map.loadTilemap(Paths.getImage("tileMap"), "Blocks");
		walls.follow();
		walls.setTileProperties(0, FlxObject.NONE);
		walls.setTileProperties(1, FlxObject.ANY);
		add(walls);

		player = new Madeline();
		map.loadEntities(placeEntities, "Entities");
		add(player);

		maincam.follow(player, FlxCameraFollowStyle.LOCKON);
        maincam.zoom = 0.1;

		super.create();
	}

	function placeEntities(entity:EntityData)
	{
		if (entity.name == "player")
		{
			player.setPosition(entity.x, entity.y);
		}
	}

	override public function update(elapsed:Float)
	{
        super.update(elapsed);
		FlxG.collide(player, walls);
	}
}