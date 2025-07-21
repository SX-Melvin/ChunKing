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

	public function Assoc ActionChunking(Object	prgCtx, Record	request)
		string pathForChunKing = "D:\Apps\Opentext\Upload\ChunKing"
		Assoc   returnData = Assoc.CreateAssoc()
		Assoc   retVal = Assoc.CreateAssoc()
		
		retVal.ok = TRUE
		returnData.message = "Done"
		retVal.data = returnData
		retVal.statusCode = 200
		
		string guidPath = Str.Format("%1\%2\", pathForChunKing, request.guid)
		string chunkFilePath = Str.Format("%1%2", guidPath, request.chunkFile_filename)
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
		
		$ChunKing.Utils.ReplaceContentToChunk(chunkFilePath, request.chunkFile)
		
		if(request.isFinal == "true")
			string item
			File targetFile = File.Open( actualFilePath, File.WriteBinMode )
			
			for item in File.FileList(guidPath)

				// Is This .part File?
				if(IsDefined(Str.LocateI($ChunKing.Utils.GetFileExtension(item), "part")))
					// If Yes Then Proceed To Append All The Chunks Into The Actual File
					$ChunKing.Utils.AppendContentToChunk(targetFile, item)
					
					// Delete The Chunk After Appending Then Content
					File.Delete(item)
				end
				
			end
			
			File.Close( targetFile ) 
		end
		
		return retVal
	end
end
