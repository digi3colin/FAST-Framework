package com.fastframework.net {
	import com.fastframework.core.SingletonError;
	/**
	 * @author colin
	 */
	public class ResolveLink{
		private var _swfPath:String="";
		private var _testingServer:String="";
		private var _server:String='';

		private static var ins:ResolveLink;
		public static function instance():ResolveLink {
			return ins || new ResolveLink();
		}

		public function ResolveLink() {
			if(ins!=null){throw new SingletonError(this);}
			ins = this;
		}

		public function setup(swfPath:String, testingServer:String=''):void{
			if(_swfPath!=swfPath){
				if(_swfPath!='')trace('warning:resource path '+_swfPath+' change to '+swfPath);
				this._swfPath=swfPath;
			}

			if(_testingServer!=testingServer){
				if(_testingServer!="")trace('warning:testing server '+_testingServer+' change to '+testingServer);
				this._testingServer=testingServer;
			}

			this._server = (_swfPath.indexOf('file:///')==0)?this._testingServer:_swfPath.split('media/')[0];
		}

		public function create(fileName:String,isDynamicAsset:Boolean=false):String{
			//if load absolute path resource, no need to resolve link.
			if(fileName.indexOf("http://")==0)return fileName;

			//resource is upload by user, no need to translate 
			if(fileName.match("upload/")!=null)return _server+'media/'+fileName;

			//resolve link by enviorment;
			if(isDynamicAsset==true){
				return _server+fileName;
			}else{
				var ext:String = String(fileName.split("?")[0]).split(".")[1];
				var specifyFolder:String = "";
				//only swf on server append no cache;
				var noCache:String = (_swfPath.indexOf('http://')==0)?'&r='+Math.floor(Math.random()*10000):'';

				switch(ext){
						case "jpg":
						case "jpeg":
						case "gif":
						case "png":
							specifyFolder = "../img/";
							noCache="";
							break;
						case "flv":
							specifyFolder = "../flv/";
							noCache="";
							break;
						case "xml":
							specifyFolder = "../xml/";
							break;
						case "swf":
							specifyFolder = "";
							break;
						default:
							specifyFolder = "../";
				}


				var path:String = _swfPath+specifyFolder+fileName;
				return (noCache=="")?path:addCacheString(path, noCache);
			}
		}

		private function addCacheString(path:String,cacheString:String):String{
			return path+((path.indexOf('?')==-1)?'?':'')+cacheString;
		}
	}
}
