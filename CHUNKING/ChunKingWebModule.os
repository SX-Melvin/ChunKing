package CHUNKING

public Object ChunKingWebModule inherits WEBDSP::WebModule

	override	Boolean	fEnabled = TRUE
	override	String	fModuleName = 'chunking'
	override	String	fName = 'ChunKing'
	override	List	fOSpaces = { 'chunking' }
	override	String	fSetUpQueryString = 'func=chunking.configure&module=chunking&nextUrl=%1'
	override	List	fVersion = { '1', '0', 'r', '0' }

end
