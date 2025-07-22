package CHUNKING::Utils

public Object ProgressLog inherits CHUNKING::ChunKingRoot
	public string ProgressLogName = ".progress"
	
	// Get Or Create (If Not Exist) Progress Log
	public function integer GetProgressLog(string dirPath)
		integer result = 0
		
		if(!File.Exists(dirPath + .ProgressLogName))
			File.Create(dirPath + .ProgressLogName)
			.WriteProgressLog(dirPath, "0")
		end
		
		File progress = File.Open(dirPath + .ProgressLogName, File.ReadMode)
		result = Str.StringToInteger(File.Read( progress ))
		File.CLose(progress)
		
		return result
	end
	
	// Delete Progress Log
	public function void DeleteProgressLog(string dirPath)
		File.Delete(dirPath + .ProgressLogName)
	end
	
	// Write Progress Log
	public function void WriteProgressLog(string dirPath, string value)
		File progress = File.Open(dirPath + .ProgressLogName, File.WriteMode)
		
		if(!IsError(progress))
			File.Write(progress, value)
			File.Close(progress)
		end
	end
end
