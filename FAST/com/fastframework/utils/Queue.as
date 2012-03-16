package com.fastframework.utils {
	import com.fastframework.core.SingletonError;
	import flash.utils.Dictionary;


	/**
	 * @author colin
	 */
	final public class Queue {
		private static var insArray:Dictionary;
		private var commands:Array;

		public static function instance(queueId:int=0):Queue{
			insArray ||= new Dictionary();
			return insArray[queueId] || new Queue(queueId);
		}
	
		public static function clearAll():void{
			for each(var q:Queue in insArray){
				q.clear();
			}
		}
	
		public function Queue(queueId:int=0){
			if( insArray[queueId] != null ) throw new SingletonError(insArray[queueId]);
			insArray[queueId] = this;

			commands = new Array();
		}

		public function addCommand(command:ICommand):int{

			//if the queue is empty, do the request immediately.
			//the item must remove by next();
			commands.push(command);
			if(commands.length==1){
				command.execute();
			}
		 	return commands.length;
		}

		public function addNextCommand(command:ICommand):void{
			if(commands.length==0){
				commands.push(command);
				command.execute();
				return;
			}
		 	commands.splice(1,0,command);
		}

		public function next():Number {
			commands[0]=null;
			commands.shift();
			if(commands.length>0)ICommand(commands[0]).execute();
			return commands.length;
		}

		public function remove(index:int):void{
			commands.splice(index,1);
		}

		public function clear():void{
		 	//clears the array, so no more loading will be started.
		 	commands = new Array();
		}
	
		public function getLength():int{
			return commands.length;
		}
	}
}