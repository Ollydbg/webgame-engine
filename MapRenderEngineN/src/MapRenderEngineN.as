package {
	import com.zj.map.Camera2D;
	import com.zj.map.SpriteMapRender;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;

	[SWF(width = "1600" , height = "900" , backgroundColor = "#000000" , frameRate = "60")]
	public class MapRenderEngineN extends Sprite {

		private var maprender:SpriteMapRender  = new SpriteMapRender();

		public function MapRenderEngineN() {

			stage.align = StageAlign.TOP_LEFT;

			stage.scaleMode = StageScaleMode.NO_SCALE;

			loadMinMap();

			addChild(maprender.mapSprite);

			SWFProfiler.init(stage , this);
		}

		/**
		 * 加载小地图
		 * */
		private function loadMinMap():void {

			LoaderManagerAll.getInstance().add("res/1.png").addEventListener(Event.COMPLETE , loaderComplete_handler);
		}

		private function loaderComplete_handler(event:Event):void {

			maprender.mapId = 1;

			maprender.mapHeight = 6000;

			maprender.mapWidth = 7000;

			maprender.sliceHeight = 300;

			maprender.sliceWidth = 300;

			maprender.scaleBmd = Bitmap(event.target.content).bitmapData;

			Camera2D.getInstance().height = 900;

			Camera2D.getInstance().width = 1600;

			Camera2D.getInstance().mapHeight = 6000;

			Camera2D.getInstance().mapWidth = 7000;

			this.addEventListener(Event.ENTER_FRAME , thisEnterFrame_handler);
		}

		private var ww:int = 0;

		private var q:int = 0;

		private function thisEnterFrame_handler(event:Event):void {

			var rect:Rectangle = Camera2D.getInstance().getViewPort(ww , ww);

			ww += 5;

			maprender.render(rect);
		}
	}
}
