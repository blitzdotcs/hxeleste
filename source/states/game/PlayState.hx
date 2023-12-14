package states.game;

import flixel.FlxState;
import game.Madeline;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import lime.utils.Assets;
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

	override public function create()
	{
		var level:LevelData = Json.parse(Assets.getText(Paths.getGSLevel(LEVEL)));

		map = new FlxOgmo3Loader(Paths.getGSOgmoData(), Paths.getGSMap(level.map));
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

		// preparar el juego
		FlxG.camera.follow(player, PLATFORMER, 1);

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