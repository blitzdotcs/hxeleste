package backend;

import flixel.graphics.FlxGraphic;
import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;

class Paths
{
	inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end;
	// taken from FlxGrapeSoda
	static inline var OGMO_DATA:String = "maps";

	static public function getImage(file:String)
		{
			return 'assets/images/$file.png';
		}
	
		static public function getSound(file:String)
		{
			return 'assets/sounds/$file.wav';
		}
	
		static public function getMusic(file:String)
		{
			#if web
			return 'assets/music/$file.mp3';
			#else
			return 'assets/music/$file.ogg';
			#end
		}
	
		static public function getLevel(number:Int)
		{
			return 'assets/data/levels/level$number.json';
		}
	
		static public function getMap(file:String)
		{
			return 'assets/data/maps/$file.json';
		}
	
		static public function getOgmoData()
		{
			return 'assets/data/$OGMO_DATA.ogmo';
		}
	
	// Old shit below

	/**
	 * For a given key and library for an image, returns the corresponding BitmapData.
	 		* We can probably move the cache handling here.
	 * @param key 
	 * @param library 
	 * @return BitmapData
	 */
	static public function loadImage(key:String, ?library:String):FlxGraphic
	{
		var path = image(key, library);

		if (OpenFlAssets.exists(path, IMAGE))
		{
			var bitmap = OpenFlAssets.getBitmapData(path);
			return FlxGraphic.fromBitmapData(bitmap);
		}
		else
		{
			return null;
		}
	}

	inline static function getPreloadPath(file:String)
	{
		return 'assets/$file';
	}

	static public function sound(key:String, ?library:String)
	{
		return 'assets/sounds/$key.$SOUND_EXT';
	}

	inline static public function font(key:String)
	{
		return 'assets/fonts/$key';
	}

	static public function getLevelUno()
	{
		return 'assets/data/levels/level1.json';
	}

	static public function getMapUno()
	{
		return 'assets/data/maps/level1remake.json';
	}

	inline static public function image(key:String, ?library:String)
	{
		return 'assets/images/$key.png';
	}    

	// EDITED GRAPE SODA
	static public function getGSLevel(number:Int)
	{
		return 'assets/data/levels/level$number.json';
	}
	
	static public function getGSMap(file:String)
	{
		return 'assets/data/maps/$file.json';
	}
	
	static public function getGSOgmoData()
	{
		return 'assets/data/$OGMO_DATA.ogmo';
	}
}