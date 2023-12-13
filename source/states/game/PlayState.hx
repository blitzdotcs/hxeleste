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

typedef LevelData =
{
	var map:String;
	var music:String;
	var player:String;
}

class PlayState extends FlxState
{
	public static var player:Madeline;
	var map:FlxOgmo3Loader;
	var tileMap:FlxTilemap;
	public static var LEVEL:Int = 1;
	var walls:FlxTilemap;

	override public function create()
	{
		var level:LevelData = Json.parse((Paths.getLevelUno()));

		map = new FlxOgmo3Loader(Paths.getOgmoData(), Paths.getMap(level.map));
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

		FlxG.camera.follow(player, TOPDOWN, 1);

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