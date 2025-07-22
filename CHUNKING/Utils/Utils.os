package CHUNKING::Utils

public Object Utils inherits CHUNKING::ChunKingRoot
	
	// Replace Content From A File To Another
	public function List GetChunkFiles(string chunkDir)
		List result = {}
		
		string item
		for item in File.FileList(chunkDir)
			if(IsDefined(Str.LocateI($ChunKing.Utils.GetFileExtension(item), "part")))
				result = List.SetAdd(result, item)
			end
		end
		
		return result
	end
	
	// Replace Content From A File To Another
	public function void ReplaceContentToChunk(string targetPathstring, string contentToAddPath)
		File targetFile = File.Open( targetPathstring, File.WriteBinMode )
		File contentFile = File.Open( contentToAddPath, File.ReadBinMode )
		
		if ( !IsError( contentFile ) )
	        File.WriteBytes(targetFile, File.ReadBytes( contentFile, $ChunKing.Common.ChunkSize ))
		    File.Close( contentFile ) 
		end

        File.Close( targetFile ) 
	end
	
	// Take .part Files In Order According To Their Part Number
	public function List TakeOrderedChunks(string chunkDir, integer take = 0)
		List result = {}
		integer prevNum = $ChunKing.ProgressLog.GetProgressLog(chunkDir)
		
		if(take == 0)
			take = $ChunKing.Common.ChunkCombineCount
		end
		
		string item
		for item in .GetChunkFiles(chunkDir)
			string ext = $ChunKing.Utils.GetFileExtension(item)
			integer partNum = Str.StringToInteger(ext[Length(ext)])
			
			if(partNum == prevNum+1)
				result = List.SetAdd(result, item)
				prevNum = partNum	
			end

			if(Length(result) == take)
				break
			end
		end

		return result
	end
	
	// Append Content From A File To Another
	public function void AppendContentToChunk(File targetFile, string contentToAddPath)
		File contentFile = File.Open( contentToAddPath, File.ReadBinMode )
		
		if ( !IsError( contentFile ) )
			File.WriteBytes(targetFile, File.ReadBytes( contentFile, $ChunKing.Common.ChunkSize ))
			File.Close( contentFile )
		end
	end
	
	// Append Content From A File To Another
	public function void AddContentToChunk(string targetFile, string contentToAddPath)
		File currentContentFile = File.Open( targetFile, File.ReadBinMode )
		
		if(!IsError(currentContentFile))
			Bytes currentContent = File.ReadBytes( currentContentFile, $ChunKing.Common.ChunkSize )
			File.Close(currentContentFile)
			
			File contentFile = File.Open( contentToAddPath, File.ReadBinMode )
			File targetContentFile = File.Open( targetFile, File.WriteBinMode )
			
			if ( !IsError( contentFile ) )
				File.WriteBytes(targetContentFile, currentContent)
				File.WriteBytes(targetContentFile, File.ReadBytes( contentFile, $ChunKing.Common.ChunkSize ))
				File.Close( contentFile )
			end
		end
		
	end
	
	// Get File Extension
	function string GetFileExtension(string fileName, boolean withoutDot = false)
		string result = fileName
		List names = Str.Elements(fileName, ".")
		if(Length(names) > 1)
			if(withoutDot)
				result = names[Length(names)]
			else
				result = Str.Format(".%1", names[Length(names)])
			end
		end

		return result
	end
	
end
