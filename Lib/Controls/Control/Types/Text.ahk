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

	/** Get Vertical Align
		Default Text align is middle (0x200)
		Default Text align in ahk is TOP, If options contains "top", word is removed
	*/
	_setTextVerticalAlign(){
		if (RegExMatch( this._Options.options , "i)top" ))
			return % RegExReplace( this._Options.options, "top", "" ) ; remove word Top

		this._Options.options .= " 0x200" ; add 0x200 for middle align
	}


}