package CHUNKING::Service

public Object ChunKingRest inherits RESTIMPL::RestAPIs
	override	Boolean	fEnabled = TRUE
	override	String	fResource = 'ChunKing'
	override	Integer	fVersion = 1

	public List fPrototypeActionChunking = {
		{'isFinal',-1,'is this the final chunk?',false},
		{'chunkFile',-1,'the chunk file',false},
		{'fileName',-1,'the original file name',false},
	 	{'guid',-1,'indetifier for each chunks',false}
	}
	 	
	public List fPrototypeActionChunkingParallel = {
		{'chunkFile',-1,'the chunk file',false},
		{'fileName',-1,'the original file name',false},
	 	{'guid',-1,'indetifier for each chunks',false}
	}
	
	// Parallel / Asynchronous Chunk
	public function Assoc ActionChunkingParallel(Object	prgCtx, Record	request)
		Assoc   returnData = Assoc.CreateAssoc()
		Assoc   retVal = Assoc.CreateAssoc()
		string item
		retVal.ok = TRUE
		returnData.message = "Done"
		retVal.data = returnData
		retVal.statusCode = 200
		
		// Where We Hold The Chunk Files
		string guidPath = Str.Format("%1\%2\", $ChunKing.Common.ChunkDir, request.guid)
		
		// Where We Hold This Request's Chunk File
		string chunkFilePath = Str.Format("%1%2", guidPath, request.chunkFile_filename)
		
		// Where We Hold The Actual File (We Use This File To Combine All The Chunks Later)
		string actualFilePath = Str.Format("%1%2", guidPath, request.fileName)
		
		// Create The Folder If Not Exist
		if(!File.Exists(guidPath))
			File.Create(guidPath)
		end
		
		// Create The Actual File If Not Exist
		if(!File.Exists(actualFilePath))
			File.Create(actualFilePath)
		end
		
		// Create The Chunk File If Not Exist
		if(!File.Exists(chunkFilePath))
			File.Create(chunkFilePath)
		end
		
		// Fill The Chunk Content
		$ChunKing.Utils.ReplaceContentToChunk(chunkFilePath, request.chunkFile)
		
		// Check If Chunk Files Greater Than Combine Count
		if(Length($chunking.Utils.GetChunkFiles(guidPath)) >= $ChunKing.Common.ChunkCombineCount)
			
			// We Will Combine All The Chunks, Loop All Files Inside The Folder
			for item in $ChunKing.Utils.TakeOrderedChunks(guidPath)

				// If Yes Then Proceed To Append All The Chunk Content Into The Actual File
				$ChunKing.Utils.AddContentToChunk(actualFilePath, item)
				
				// Delete The Chunk File After Appending The Content
				File.Delete(item)
				
				$ChunKing.ProgressLog.WriteProgressLog(guidPath, item[Length(item)])
				
			end

		end
		
		return retVal
	end
	
	// Series / Linear / Synchronous Chunk
	public function Assoc ActionChunking(Object	prgCtx, Record	request)
		Assoc   returnData = Assoc.CreateAssoc()
		Assoc   retVal = Assoc.CreateAssoc()
		
		retVal.ok = TRUE
		returnData.message = "Done"
		retVal.data = returnData
		retVal.statusCode = 200
		
		// Where We Hold The Chunk Files
		string guidPath = Str.Format("%1\%2\", $ChunKing.Common.ChunkDir, request.guid)
		
		// Where We Hold This Request's Chunk File
		string chunkFilePath = Str.Format("%1%2", guidPath, request.chunkFile_filename)
		
		// Where We Hold The Actual File (We Use This File To Combine All The Chunks Later)
		string actualFilePath = Str.Format("%1%2", guidPath, request.fileName)
		
		// Create The Folder If Not Exist
		if(!File.Exists(guidPath))
			File.Create(guidPath)
		end
		
		// Create The Actual File If Not Exist
		if(!File.Exists(actualFilePath))
			File.Create(actualFilePath)
		end
		
		// Create The Chunk File If Not Exist
		if(!File.Exists(chunkFilePath))
			File.Create(chunkFilePath)
		end
		
		// Fill The Chunk Content
		$ChunKing.Utils.ReplaceContentToChunk(chunkFilePath, request.chunkFile)
		
		// Is This The Last Chunk?
		if(request.isFinal == "true")
			string item
			
			// Open The Actual File
			File targetFile = File.Open( actualFilePath, File.WriteBinMode )
			
			// We Will Combine All The Chunks, Loop All Files Inside The Folder
			for item in $chunking.Utils.GetChunkFiles(guidPath)
				
				// If Yes Then Proceed To Append All The Chunk Content Into The Actual File
				$ChunKing.Utils.AppendContentToChunk(targetFile, item)
				
				// Delete The Chunk File After Appending The Content
				File.Delete(item)
				
			end
			
			// Save The Actual File
			File.Close( targetFile ) 
			
			// TODO: Do Something After Combining All The Chunks, Maybe Moving The File To Somewhere...
		end
		
		return retVal
	end
end
