/** GuiSize
*/
Class GuiSize_vgui extends GuiPosition_vgui
{
	_sizes	:=	{"size":	{w:0,	h:0}	; store min sizes of gui
			,"min":	{w:0,	h:0}	; store min sizes of gui
			,"max":	{w:0,	h:0}	; store max sizes of gui
			,"auto":	{w:0,	h:0}}	; store auto sizes of gui
	
	_resizable	:= false
	
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

		this._fixSizeOnAutosize()
		
		;;;this._margin($_GUI_margin.ui.x(), $_GUI_margin.ui.y())
		this.show("AutoSize")
		
		this._restoreSizeOnAutosize()

		this._correctMarginOfGui()
		this._scrollbar()
		
		$size	:= this._getGuiSize()
		this._sizes.auto 	:= {"w": $size.w,	"h": $size.h}
		
		this.Events.Window.resume("size")

		return this
	}
	
	/** make gui resizeable
	  * default is unresizable gui 
	*/
	resizeable($toggle:=true)
	{
		if( this._resizable == $toggle )
			return this
		
		this._resizable := $toggle
		
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
	/* Fully clone object
	*/
	_objectClone($obj)
	{
		$obj_c := $obj.Clone()
		for $k,$v in $obj_c
			if IsObject($v)
				$obj_c[$k] := this._objectClone($v)
		return $obj_c
	}
		
	/*---------------------------------------
		PRIVATE METHODS
	-----------------------------------------
	*/
	/** Get real size of window with menus and borders
	*/
	_getGuiSize( $hwnd:="" )
	{
		if( ! $hwnd )
			$hwnd := this._hwnd
		
		VarSetCapacity(rc, 16)
		DllCall("GetClientRect", "uint", $hwnd, "uint", &rc)
		
		return {"w":NumGet(rc, 8, "int"), "h":NumGet(rc, 12, "int")}
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
		if(RegExMatch( $value, "^[\+\-]" )) ; if $value is relative
		{ 
			$size := this._getGuiSize()
			$value := ($wh=="w" ? $size.w : $size.h) + $value
		}
		if( ! $value)
			return
			
		this.show( $wh $value, this._name )
		
		this._sizes.size[$wh] := $value
	}
	/** _minMaxSize
	*/
	_minMaxSize($min_max, $wh, $value)
	{
		if( ! $value )
			return	
		
		this.resizeable()
		
		this._sizes[$min_max][$wh] := $value
		
		this.options( "+" $min_max "Size" ($wh=="w" ? $value : "") "x" ($h := $wh=="h" ? $value : ""))
	}

	/** Set size of guui as max size and backup this.sizes
	  *
	  * It allows autosize Gui only in one dimension
	 */
	_fixSizeOnAutosize()
	{
		if( ! this._sizes.size.w && ! this._sizes.size.h )
			return

		this._sizes_autosize_bak := this._objectClone(this._sizes)

		this.maxSize(this._sizes.size.w, this._sizes.size.h)
	}
	/** restore backuped this._sizes
	 */
	_restoreSizeOnAutosize()
	{
		if( ! this._sizes_autosize_bak )
			return
		
		this._sizes := this._objectClone(this._sizes_autosize_bak)
	
		this.options("-MaxSize")

		this.delete("_sizes_autosize_bak")
	
		this.maxSize(this._sizes.max.w, this._sizes.max.h)
	} 
	
}
