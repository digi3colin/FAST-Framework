package {

	/**
	 * @author colin
	 */
	public interface IProxy {
		function getValue(property:int,asyncHandler:Function):*;
		function removeHandler(asyncHandler:Function):void;
	}
}
