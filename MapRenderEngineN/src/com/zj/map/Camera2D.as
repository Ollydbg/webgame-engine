package com.zj.map {
	import flash.geom.Rectangle;

	public class Camera2D {

		private static var instance:Camera2D;

		/**
		 * 视口裁剪区域
		 * */
		private var viewport:Rectangle = new Rectangle();

		public function Camera2D() {

			if (instance) {

				throw new Error("单例创建重复");
			}
		}

		private var _zoom:Number;

		private var _width:int;

		private var _height:int;


		/**
		 * 地图的宽高
		 * */
		public var mapWidth:int;

		public var mapHeight:int;

		/**
		 * 获取镜头的单例
		 * */
		public static function getInstance():Camera2D {

			return instance ||= new Camera2D();
		}

		/**
		 * 获取渲染视口区域
		 * */
		public function getViewPort(x:int , y:int):Rectangle {

			var halfwidth:int = _width >> 1;

			var halfheight:int = _height >> 1;

			//初次检查小于边际情况
			viewport.x = halfwidth > x ? 0 : x - halfwidth;

			viewport.y = halfheight > y ? 0 : y - halfheight;

			//再次检查大于边际情况
			viewport.x = (viewport.x > (mapWidth - _width)) ? (mapWidth - _width) : viewport.x;

			viewport.y = (viewport.y > (mapHeight - _height)) ? (mapHeight - _height) : viewport.y;

			//检查地图小于视口的情况
			mapWidth < _width ? viewport.x = ((mapWidth >> 1) - halfwidth) : false;

			mapHeight < _height ? viewport.y = ((mapHeight >> 1) - halfheight) : false;

			return viewport;
		}

		/**
		 * 拉近镜头等级
		 * */
		public function get zoom():Number {

			return _zoom;
		}

		public function set zoom(value:Number):void {

			_zoom = value;
		}

		/**
		 * 镜头的宽高
		 * */
		public function get width():int {
			return _width;
		}

		/**
		 * @private
		 */
		public function set width(value:int):void {

			_width = value;

			viewport.width = value;
		}

		public function get height():int {

			return _height;
		}

		public function set height(value:int):void {

			_height = value;

			viewport.height = value;
		}
	}
}
