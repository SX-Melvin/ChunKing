package CHUNKING

/**
 * 
 *  This is a good place to put documentation about your OSpace.
 */
public Object ChunKingRoot

	public		Object	Globals = CHUNKING::ChunKingGlobals



	/**
	 *  Content Server Startup Code
	 */
	public function Void Startup()

		//
		// Initialize globals object
		//

		Object	globals = $ChunKing = .Globals.Initialize()

		//
		// Initialize objects with __Init methods
		//

		$Kernel.OSpaceUtils.InitObjects( globals.f__InitObjs )

	end

end
