package CHUNKING::Utils

public Object Utils inherits CHUNKING::ChunKingRoot
	
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
	
	// Append Content From A File To Another
	public function void AppendContentToChunk(File targetFile, string contentToAddPath)
		File contentFile = File.Open( contentToAddPath, File.ReadBinMode )
		
		if ( !IsError( contentFile ) )
			File.WriteBytes(targetFile, File.ReadBytes( contentFile, $ChunKing.Common.ChunkSize ))
			File.Close( contentFile )
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
