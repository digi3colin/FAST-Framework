package com.fastframework.facebook {
	import com.fastframework.core.EventDispatcherUtils;
	import com.fastframework.utils.StringUtils;
	import flash.events.Event;
	import flash.events.EventDispatcher;


	/**
	 * @author colin
	 */
	final public class FBUser extends EventDispatcher implements IFASTEventDispatcher{
		private static var ins : FBUser;

		public static function instance():FBUser {
			ins ||=new FBUser(new SingletonBlocker());
			return ins;
		}
		public static const EVENT_LOGON:String     = "logon";
		public static const EVENT_LOGOUT:String    = "logout";
		public static const EVENT_NAMESET:String   = "nameSet";
		public static const EVENT_PICSET:String    = "picSet";
		public static const EVENT_BIGPICSET:String = "bigPicSet";

		private var _uid:String="";
		private var _pic : String="";
		private var _bigPic:String="";
		private var _name : String="";
		private var _verify:Boolean=false;
		public var defaultPic:String="blank.png";
		public var _loginInApplication:Boolean = false;

		public function FBUser(p_key:SingletonBlocker) {
			FBConnect.instance().when(FBConnectEvent.CALLBACK, this, fbCallback);
			p_key;
		}
				
		public function when(eventType : String, whichObject : Object, callFunction : Function) : * {
			EventDispatcherUtils.instance().when(this,eventType,whichObject,callFunction);
			return this;
		}
		
		private function fbCallback(e:FBConnectEvent):void{
			var para:Array = e.msg.split("FB.userGetInfo::");
			if(para[1]!=null){
				var vals:Array = String(para[1]).split(",");
				this.name   = vals[0]||"";
				this.pic    = StringUtils.entityDecode(vals[1]||defaultPic);
				this.bigPic = StringUtils.entityDecode(vals[2]||defaultPic);
			}
		}
		
		public function logon():void{
			_uid = FBConnect.instance().get_loggedInUser();//JS.instance().call('FB.Connect.get_loggedInUser');

			JS.instance().call("FB.Facebook.apiClient.users_getInfo(["+_uid+"],['name','pic_square','pic_big'],function(r,e){asCall('FB.userGetInfo::'+ r[0]['name']+','+r[0]['pic_square']+','+r[0]['pic_big'])})");
			this.dispatchEvent(new Event(FBUser.EVENT_LOGON));
		}
		
		public function logout(...e):void{
			_uid = "";
			name = "";
			pic  = "blank.png";
			_verify = false;
			this.dispatchEvent(new Event(FBUser.EVENT_LOGOUT));	
		}
		
		public function set name(name:String):void{
			_verify = (name!="");
			_name = name;
			this.dispatchEvent(new Event(FBUser.EVENT_NAMESET));
		}

		public function set pic(url:String):void{
			if(url=="null")url=defaultPic;
			_pic = url;
			this.dispatchEvent(new Event(FBUser.EVENT_PICSET));
		}
		
		public function set bigPic(url:String):void{
			if(url=="null")url=defaultPic;
			_bigPic = url;
			this.dispatchEvent(new Event(FBUser.EVENT_BIGPICSET));
		}

		public function get name():String{
			return _name;
		}
		
		public function get pic():String{
			return _pic;
		}
		
		public function get bigPic():String{
			return _bigPic;
		}

		public function get uid():String{
			return _uid;
		}
		
		public function get verify():Boolean{
			return (_loginInApplication&&_verify);
		}
	}
}

class SingletonBlocker{}