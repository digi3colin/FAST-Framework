package {
	import com.fastframework.core.EventDispatcherUtils;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;


	/**
	 * @author colin
	 */
	 
	 /*
	  * 
var reEmail:RegExp = new RegExp("^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}$","i");
var txf:SmartTextField = new SmartTextField(txt);
txf.setValidateFunction(function(str:String):Boolean{return reEmail.test(str)});
txf.focusClear = true;

txf.addEventListener(SmartTextField.EVENT_VALID,valid);
txf.addEventListener(SmartTextField.EVENT_INVALID,invalid);

function valid(e:Event):void{
	trace(e.target);
	trace(txt.text+' is valid');
}

function invalid(e:Event):void{
	trace(txt.text+' is invalid,'+txf.invalidMsg);
}
	  * 
	  */
	public class SmartTextField extends EventDispatcher implements IFASTEventDispatcher{
		private var _validateFunction:Function;
		private var _submitFunction:Function;
		private var base:TextField;
		private var oText:String="";
		
		public var alwaysCheck:Boolean = false;
		public var focusClear:Boolean = false;
		public var invalidMsg:String = "input invalid.";
		
		public static const EVENT_VALID:String = "onValid";
		public static const EVENT_INVALID:String = "onInvalid";
		public static const EVENT_RESET:String = "onReset";
		public static const EVENT_CHANGE:String = Event.CHANGE;

		public function SmartTextField(txf:TextField){
			oText = txf.text;
			base = txf;
			base.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown,false,0,true);
			base.addEventListener(FocusEvent.FOCUS_OUT, focusOut,false,0,true);
			base.addEventListener(FocusEvent.FOCUS_IN, focusIn,false,0,true);
			base.addEventListener(Event.CHANGE, onChange,false,0,true);
		}

		public function setValidateFunction(fnt:Function):void{
			_validateFunction = fnt;
		}

		public function validate(...e):Boolean{
			if(validateWithoutEventDispatch()){
				dispatchEvent(new Event(SmartTextField.EVENT_VALID));
				return true;
			}else{
				dispatchEvent(new Event(SmartTextField.EVENT_INVALID));
				return false;
			}
			return false;
		}

		public function validateWithoutEventDispatch():Boolean{
			var result:Boolean=false;
			if(_validateFunction!=null){
				result = _validateFunction(base.text);
			}else{
				result=true;
			}			
			if(result==false){
				return false;
			}
			return result;
		}

		public function setSubmit(fnt:Function):void{
			_submitFunction = fnt;
		}

		public function getBase():TextField{
			return base;
		}
		
		public function clear():void{
			base.text = "";
			dispatchEvent(new Event(SmartTextField.EVENT_RESET));
		}

		private function onChange(e:Event):void{
			dispatchEvent(new Event(SmartTextField.EVENT_CHANGE));
		}

		private function onKeyDown(e:KeyboardEvent):void{
			if(alwaysCheck==true){
				validate();
			}
			if(e.keyCode==13)submit();
		}

		private function submit():Boolean{
			if(validate()==false)return false;
			if(_submitFunction==null)return false;

			_submitFunction();
			return true;
		}
		
		public function when(eventType : String, whichObject : Object, callFunction : Function) : * {
			EventDispatcherUtils.instance().when(this,eventType,whichObject,callFunction);
			return this;
		}
		
		private function focusOut(e:FocusEvent):void{
			validate();
			if(base.text=="")base.text = oText;
		}
		
		private function focusIn(e:FocusEvent):void{
			if(focusClear==true && (oText==base.text||base.text=="-"||base.text=="0")){
				base.text="";
			}
		}
	}
}
