package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class CacheMap {

		private static var LOADING:String = "LOADING";

		public static var mapDic:Dictionary = new Dictionary();

		public static function getMap(url:String):BitmapData {

			return mapDic[url] == LOADING ? null : mapDic[url];
		}

		public static function loadMap(url:String):void {

			if (mapDic[url]) {

				return;
			}

			mapDic[url] = LOADING;

			LoaderManagerAll.getInstance().add(url).addEventListener(Event.COMPLETE , function(event:Event):void {

				mapDic[url] = Bitmap(event.target.content).bitmapData;
			});
		}
	}
}
