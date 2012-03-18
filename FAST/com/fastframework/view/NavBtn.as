package com.fastframework.view {	import com.fastframework.core.FASTEventDispatcher;	import com.fastframework.core.utils.MovieClipTools;	import com.fastframework.core.utils.SystemUtils;	import com.fastframework.navigation.Navigation;	import flash.display.DisplayObjectContainer;	import flash.display.InteractiveObject;	import flash.display.SimpleButton;	/**	 * @author Colin	 */
	final public class NavBtn extends FASTEventDispatcher implements IButtonClip{
		public static var FILEPREFIX:String = 'FILEPREFIX';		private var base:NavButton;

		public function NavBtn(mc:InteractiveObject,navId:String="",targetContainer:String=""){			if((mc is SimpleButton || mc is DisplayObjectContainer)==false){				throw new Error('NavBtn only accept SimpleButton or DisplayObjectContainer');			}			var n:String = mc.name;			n = mc.name.replace(FILEPREFIX, SystemUtils.getMovieFileName(mc, false));
			var para:Array = n.split("$");			var hitArea:SimpleButton;						if(mc is SimpleButton){				hitArea = mc as SimpleButton;			}else{				hitArea = MovieClipTools.findButton(DisplayObjectContainer(mc));			}
			base = new NavButton(hitArea,								(navId=="")?para[1]:navId,								(targetContainer=="")?para[2]:targetContainer);			base.highlightButtonByNavKey(Navigation.instance().getNavKey());
		}

		public function addElement(element : IButtonElement) : IButtonClip {
			base.addElement(element);			return this;
		}
			public function getElements():Array{			return base.getElements();		}
		public function select() : IButtonClip {
			base.select();			return this;
		}		public function setMouseOverDelay(miniSecond : int) : IButtonClip {			base.setMouseOverDelay(miniSecond);			return this;		}				public function setMouseOutDelay(miniSecond : int) : IButtonClip {			base.setMouseOutDelay(miniSecond);			return this;		}				public function clearMouseOver() : IButtonClip {			base.clearMouseOver();			return this;		}				public function clearMouseOut() : IButtonClip {			base.clearMouseOut();			return this;		}
	}}
