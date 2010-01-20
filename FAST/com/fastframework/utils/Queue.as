package com.fastframework.utils {

	/**
	 * @author colin
	 */
	final public class Queue {
		private static var insArray:Array;

		private var requestArray:Array;
		private var needRemoveFirstRequest : Boolean=false;
		
		public static function instance(queueId:int=0):Queue{
			insArray ||= [];
			insArray[queueId] ||=new Queue(new SingletonBlocker());
			return insArray[queueId];
		}
	
		public static function clearAll():void{
			for(var i:Number = 0;i<insArray.length;i++){
				Queue(insArray[i]).clear();
			}
		}
	
		public function Queue(p_key:SingletonBlocker){
			requestArray = new Array();
			p_key;
		}
	
		public function next():Number {
			if(needRemoveFirstRequest==true){
				remove(0);
				needRemoveFirstRequest = false;
			}

			if(requestArray[0]!=null){
				requestArray[0]();
				remove(0);
			}
			return requestArray.length;
		}
	
		public function addRequest(request:Function):Number{
			//if the queue is empty, do the request immediately.
			//the item must remove by next();
			if (requestArray.length==0){
				needRemoveFirstRequest = true;
				request();
			}
		 	return requestArray.push(request);
		}
	
		public function clear():void{
		 	//clears the array, so no more loading will be started.
		 	requestArray = new Array();
		}
	
		public function addNextRequest(request:Function):void{
			if(requestArray.length==0){request();}
		 	requestArray.splice(0,0,request);
		}
	
		public function remove(index:Number):void{
			requestArray.splice(index,1);
		}
	
		public function getIndexByReference(request:Function):Number{
			var i:Number;
			for (i=0;i<requestArray.length;i++){
				if (requestArray[i] === request)return i;
			}
			return -1;
		}
	
		public function getItemAt(index:Number):Function{
			return requestArray[index];
		}
	
		public function getLength():Number{
			return requestArray.length;
		}
	}
}
class SingletonBlocker {}