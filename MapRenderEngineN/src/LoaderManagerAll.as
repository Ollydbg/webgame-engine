package {
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;

	public class LoaderManagerAll {

		private var bulk:BulkLoader;

		private static var instance:LoaderManagerAll;

		public function LoaderManagerAll() {

			if (instance) {

				throw new Error("单例被重复创建");
			}

			bulk = BulkLoader.createUniqueNamedLoader(6);

			bulk.start(6);
		}

		public static function getInstance():LoaderManagerAll {

			return instance ||= new LoaderManagerAll();
		}

		public function add(url:* , props:Object = null):LoadingItem {

			return bulk.add(url , props);
		}
	}
}
