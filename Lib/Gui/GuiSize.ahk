/** GuiSize
*/
Class GuiSize_vgui extends GuiPosition_vgui
{
	_size	:=	{"min":	{w:0,	h:256}	; store min sizes of gui
			,"max":	{w:0,	h:1024}	; store max sizes of gui
			,"auto":	{w:0,	h:0}}	; store auto sizes of gui
			
	/** Resize GUI
	  *
	  */
	size($width:="", $height:="")
	{
		this._setSize("w", $width)
		this._setSize("h", $height)
		this._scrollbar()
		return this
	}
	/** Resize GUI by its content
	*/
	autosize()
	{
		this.Events.Window.pause("size")

		;;;this._margin($_GUI_margin.ui.x(), $_GUI_margin.ui.y())
		this.show("AutoSize")
		this._correctMarginOfGui()
		this._scrollbar()
		
		$size	:= this._getGuiSize()
		this._size.auto 	:= {w:$size.w,	h:$size.h}
		
		this.Events.Window.resume("size")

		return this
	}
	/** make gui resizeable
	  * default is unresizable gui 
	*/
	resizeable($toggle:=true)
	{
		this.options(this._getPlusMinus($toggle) "Resize")
		return this
	}
	/** set minimal size of gui
	*/
	minSize($width:=512,$height:=128)
	{
		this._minMaxSize("Min", "w", $width)
		this._minMaxSize("Min", "h", $height)
		return this
	}
	/** set maximal size of gui
	*/
	maxSize($width :="",$height:="")
	{
		this._minMaxSize("Max", "w", $width)
		this._minMaxSize("Max", "h", $height)
		return this
	}
	/** set fixed with of gui
	*/
	fixedWidth($width:="")
	{
		if(!$width)
			$width := this._getGuiSize().w

		this._minMaxSize("Min", "w", $width)
		this._minMaxSize("Max", "w", $width)

		return this
	}
	
	
	/*---------------------------------------
		PRIVATE METHODS
	-----------------------------------------
	*/
	/** _getGuiSize
	*/
	_getGuiSize()
	{
		hwnd := WinExist(this._name)
		VarSetCapacity(rc, 16)
		DllCall("GetClientRect", "uint", hwnd, "uint", &rc)
		return {w:NumGet(rc, 8, "int"), h:NumGet(rc, 12, "int")}
	}
	/** Set relative or absolute size of gui
		@param "w|h"	$wh	width or height
		@param int|string	$value	absolute or relative size of gui E.G: ABSOLUTE: 1024 | RELATIVE: -128 or "+128"
		    E.G: size(512, 1024 )  ; Gui size will be 512x1024 px
				 size("",  "+128") ; Current size will added   128 px
				 size("",  -128 )  ; Current size will removed 128 px
	*/
	_setSize($wh, $value)
	{
		if(RegExMatch( $value, "^[\+\-]" )){ ; if $value is relative
			$size := this._getGuiSize()
			$value := ($wh=="w" ? $size.w : $size.h) + $value
		}
		if($value)
			this.show($wh $value, this._name )
			;this.show( $wh $value) ; Heght: -52 when menu is -32 without menu
			;this.show( $wh this._getSizeValue($wh, $value)) ; Heght: -52 when menu is -32 without menu
	}
	/** _minMaxSize
	*/
	_minMaxSize($min_max, $wh, $value)
	{
		this._size[$min_max][$wh] := $value
		this.options( "+" $min_max "Size" ($wh=="w" ? $value : "") "x" ($h := $wh=="h" ? $value : ""))
	}

	
	
}
