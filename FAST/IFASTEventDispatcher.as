/** * @author colin */package {	import flash.events.IEventDispatcher;	
	
	public interface IFASTEventDispatcher extends IEventDispatcher{		function when(eventType:String,whichObject:Object,callFunction:Function):*;	}}