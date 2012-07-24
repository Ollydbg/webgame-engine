package com.zj.map {
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;

	public class SpriteMapRender extends AMapRender {

		public var mapSprite:Shape = new Shape();

		private var matrix:Matrix = new Matrix();

		private var _scaleBmd:BitmapData;

		private var scale:Number;

		public function SpriteMapRender() {

		}

		private var count:int;

		override protected function clear():void {

			mapSprite.graphics.clear();
		}

		override protected function drawMap(posX:int , posY:int , bmd:BitmapData):void {

			matrix.identity();

			matrix.tx = posX;

			matrix.ty = posY;

			mapSprite.graphics.beginBitmapFill(bmd , matrix);

			mapSprite.graphics.drawRect(posX , posY , bmd.width , bmd.height);

			mapSprite.graphics.endFill();
		}

		override protected function drawMosaic(posX:int , posY:int , url:String):void {

			loadMap(url);

			matrix.identity();

			matrix.scale(scale , scale);

			matrix.tx = -this.drawViewPort.x;

			matrix.ty = -this.drawViewPort.y;

			if (_scaleBmd) {

				mapSprite.graphics.beginBitmapFill(_scaleBmd , matrix);

				mapSprite.graphics.drawRect(posX , posY , _sliceWidth , _sliceHeight);

				mapSprite.graphics.endFill();
			}

		}

		override protected function getMap(url:String):BitmapData {

			return CacheMap.getMap(url);
		}

		override protected function loadMap(url:String):void {

			CacheMap.loadMap(url);
		}

		/**
		 * 缩略图
		 * */
		public function get scaleBmd():BitmapData {

			return _scaleBmd;
		}

		/**
		 * @private
		 */
		public function set scaleBmd(value:BitmapData):void {

			_scaleBmd = value;

			scale = mapWidth / scaleBmd.width;
		}

	}
}
