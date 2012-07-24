package com.zj.map {
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	/**
	 * 虚拟的地图渲染类 提供一些公共的方法
	 * 切片高度默认为256*256
	 *
	 * */
	public class AMapRender implements IMapRender {

		protected var _mapWidth:int;

		protected var _mapHeight:int;

		protected var _sliceWidth:int = 256;

		protected var _sliceHeight:int = 256;

		protected var _sliceWA:Number;

		protected var _sliceHA:Number;

		protected var _mapId:int;

		protected var mapPrefix:String = "res/";

		protected var drawViewPort:Rectangle;

		protected var lastDrawViewPort:Rectangle = new Rectangle();

		public function AMapRender() {

		}

		public function render(rect:Rectangle):void {

			drawViewPort = rect;

			if (lastDrawViewPort.x == drawViewPort.x && lastDrawViewPort.y == drawViewPort.y) {

				return;
			}

			lastDrawViewPort.x = drawViewPort.x;

			lastDrawViewPort.y = drawViewPort.y;

			//横着数 第多少张
			var firstX:int = (rect.x * _sliceWA) >> 0;

			//竖着数 第多少张
			var firstY:int = (rect.y * _sliceHA) >> 0;

			//横着算起来 一共有多少张
			var mapCellW:int = Math.ceil(_mapWidth * _sliceWA);

			//竖着算起来 一共有多少张
			var mapCellH:int = Math.ceil(_mapHeight * _sliceHA);

			//横着算起来 多少张为绘制的结束
			var endX:int = Math.ceil((rect.x + rect.width) * _sliceWA);

			//竖着算起来，多少张为绘制的结束
			var endY:int = Math.ceil((rect.y + rect.height) * _sliceHA);

			//做一些清理工作
			clear();

			for (var i:int = firstY ; i <= endY ; i++) {

				//绘制地图开始的位置Y
				var mapdrawPosY:int = (i * _sliceHeight) - rect.y;

				//计算行初始化
				var beginY:int = i * mapCellW;

				for (var j:int = firstX ; j <= endX ; j++) {

					var cellIndex:int =  beginY + j;

					//判断一下是否小于最大的 大于最小的 避免出现地图小于视口
					if (cellIndex < mapCellW * mapCellH && cellIndex >= 0) {

						//绘制地图开始的位置X
						var mapdrawPosX:int = (j * _sliceWidth) - rect.x;

						var mapurl:String = mapPrefix + String(cellIndex) + ".jpg";

						//拿url地址的图片
						var bmd:BitmapData = getMap(mapurl);

						//绘制地图 绘制马赛克 加载地图  注意 不要重复加载
						bmd ? drawMap(mapdrawPosX , mapdrawPosY , bmd) : drawMosaic(mapdrawPosX , mapdrawPosY , mapurl);

					}
				}
			}
		}

		/**
		 * 清理画布
		 * */
		protected function clear():void {

		}

		/**
		 * 获取地图的接口函数
		 * */
		protected function getMap(url:String):BitmapData {

			return null;
		}

		/**
		 * 绘制地图的接口函数
		 * */
		protected function drawMap(posX:int , posY:int , bmd:BitmapData):void {

		}

		/**
		 * 绘制马赛克的接口函数 子类必须实现
		 * */
		protected function drawMosaic(posX:int , posY:int , url:String):void {

			loadMap(url);
		}

		/**
		 * 加载URL地址的资源 子类覆盖的时候一定不要重复加载
		 * */
		protected function loadMap(url:String):void {

		}

		/**
		 * 地图宽度
		 * */
		public function get mapWidth():int {

			return _mapWidth;
		}

		/**
		 * @private
		 */
		public function set mapWidth(value:int):void {

			_mapWidth = value;
		}

		/**
		 * 地图高度
		 * */
		public function get mapHeight():int {

			return _mapHeight;
		}

		/**
		 * @private
		 */
		public function set mapHeight(value:int):void {

			_mapHeight = value;
		}

		/**
		 * 切片的宽度
		 * */
		public function get sliceWidth():int {

			return _sliceWidth;
		}

		/**
		 * @private
		 */
		public function set sliceWidth(value:int):void {

			_sliceWidth = value;

			_sliceWA = 1 / _sliceWidth;
		}

		/**
		 * 切片的高度
		 * */
		public function get sliceHeight():int {

			return _sliceHeight;
		}

		/**
		 * @private
		 */
		public function set sliceHeight(value:int):void {

			_sliceHeight = value;

			_sliceHA = 1 / _sliceHeight;
		}

		public function get mapId():int {
			return _mapId;
		}

		public function set mapId(value:int):void {

			_mapId = value;

			mapPrefix = "res/" + _mapId + "/";
		}

	}
}
