﻿package com.fastframework.utils {	import flash.display.DisplayObject;	import flash.system.Capabilities;	/**	 * @author colin	 */	final public class SystemUtils {		public static function isPlayerHigherThanRequirement(targetVersion:String):Boolean{			var currVersion:String = Capabilities.version;			var currVersionArray:Array = currVersion.split(" ");			var currVersionNumber:String = currVersionArray[currVersionArray.length-1];			currVersionArray = currVersionNumber.split(",");						var targetVersionArray:Array = targetVersion.split(",");			for(var i:Number=0;i<currVersionArray.length;i++){				if(Number(currVersionArray[i])<Number(targetVersionArray[i]))return false;				if(Number(currVersionArray[i])>Number(targetVersionArray[i]))return true;			}			return true;		}				public static function getMovieURLPath(mc:DisplayObject):String{			var pathArray:Array = mc.loaderInfo.url.split("/");			pathArray.pop();				return (pathArray.length==0)?"":(pathArray.join("/")+"/");		}				public static function getMovieFileName(mc:DisplayObject,withExtension:Boolean=true):String{						var pathArray:Array = mc.loaderInfo.url.split("/");			var fileName:String = unescape(String(pathArray.pop()));						//var fileName:String = mc.loaderInfo.url.substring(mc.loaderInfo.url.lastIndexOf("/"));			return (withExtension)?fileName:fileName.split(".swf")[0];		}				public static function getMovieURLCurrentFolderName(mc:DisplayObject):String{			var pathArray:Array = mc.loaderInfo.url.split("/");			pathArray.pop();			pathArray.pop();			return (pathArray.length==0)?"":(pathArray.join("/")+"/");		}	}}