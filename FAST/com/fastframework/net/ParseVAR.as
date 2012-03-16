package com.fastframework.net {
	import com.fastframework.core.FASTLog;
	import flash.net.URLLoader;
	import flash.net.URLVariables;


	/**
	 * @author Colin
	 */
	public class ParseVAR implements ILoadParser {
		private var base:URLVariables;

		public function onLoad(loader:ILoader):void{
			base = URLLoader(loader.getContext()).data;
			FASTLog.instance().log(base.toString(), FASTLog.LOG_LEVEL_DETAIL);

			loader.dispatchEvent(new LoaderEvent(LoaderEvent.READY));
		}

		public function getContext() : * {
			return base;
		}
	}
}