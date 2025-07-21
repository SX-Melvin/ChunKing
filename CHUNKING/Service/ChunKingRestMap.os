package CHUNKING::Service

public Object ChunKingRestMap inherits RESTIMPL::RESTAPIMap
	
	override Boolean	fEnabled = TRUE
	override List 		fMap = { 
	 	{ "POST | api/v1/chunking/series", "ChunKing|ActionChunking" },
		{ "POST | api/v1/chunking/parallel", "ChunKing|ActionChunkingParallel" }
	 }
	 	
end
