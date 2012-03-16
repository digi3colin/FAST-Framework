package com.fastframework.net {
	import com.fastframework.core.FASTLog;
	import flash.net.URLLoader;
	import flash.utils.ByteArray;


	/**
	 * @author digi3studio
	 */
	public class ParseBIN implements ILoadParser {
		private var receiveBytes:ByteArray;

		public function onLoad(loader:ILoader):void{
			receiveBytes = URLLoader(loader.getContext()).data;
			receiveBytes.position = 0;
			loader.dispatchEvent(new LoaderEvent(LoaderEvent.READY));
			FASTLog.instance().log(receiveBytes.length+' bytes loaded', FASTLog.LOG_LEVEL_DETAIL);
		}

		public function getContext() : * {
			return receiveBytes;
		}
	}
}