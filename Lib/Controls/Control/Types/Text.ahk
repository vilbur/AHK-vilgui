/** Class Text_vgui
*/
Class Text_vgui extends Control_vgui{

	/** add
	*/
	add($name:=""){
		this.name($name)
		this._setTextVerticalAlign()
		return % this.Controls().add(this) ; clone added object if user insert one object multiple times
	}

	/** Set default vertical align of text to middle
		Remove word "top" from options, it is not allowed by AHK, by it is used by Vilgui E.G: .options("top")
		
		Align middle is suspended if value contains new line "`n" E.G: "First line `n Second line"
	  
		DEFAULT TEXT ALIGN:
			VILGUI:	MIDDLE (0x200)
			AHK:	TOP
	*/
	_setTextVerticalAlign(){
		if (RegExMatch( this._Options.options , "i)top" ))
			return % RegExReplace( this._Options.options, "top", "" ) ; remove word Top

		if( ! RegExMatch( this._value, "i)`n" ) )
			this._Options.options .= " 0x200" ; add 0x200 for middle align
	}


}