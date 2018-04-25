/** GuiSize
*/
Class GuiSize_vgui extends GuiPosition_vgui
{
	_sizes	:=	{"size":	{w:0,	h:0}	; store min sizes of gui
			,"min":	{w:128,	h:64}	; store min sizes of gui
			,"max":	{w:0,	h:0}	; store max sizes of gui
			,"auto":	{w:0,	h:0}}	; store auto sizes of gui
	
	_resizable	:= false
	_fixed_width	:= false	; store value for gui create()
	
	/** Set size of gui
	  * @param	int|string	$width	absolute or relative size e.g.: 512 OR "+128"
	  * @param	int|string	$height	absolute or relative size
	  *
	  * @return self test description 
	  */
	size($width:="", $height:="")
	{
		this._setSize("w", $width)
		this._setSize("h", $height)
		
		this._scrollbar()
		
		return this
	}
	/** Resize gui by content
	 *
	 *  Respect size(), minSize(), maxSize()
	 */
	autosize() 
	{
		this.Events.Window.pause("size")
		
		;this._fixSizeOnAutosize()
		
		this.show("AutoSize")
		
		;this._restoreSizeOnAutosize()
		
		this._correctMarginOfGui()	; // BUG: sometimes makes gui huge, marging need review
		this._scrollbar()	; // BUG: sometimes shows scrollbar event it is not need, probably related to _correctMarginOfGui()	
		
		$size	:= this._getGuiSize()
		this._sizes.auto 	:= {"w": $size.w,	"h": $size.h}
		
		this.Events.Window.resume("size")

		return this
	}
	
	/** Make gui resizeable
	 *
	 * Default is unresizable gui 
	 */
	resizeable($toggle:=true)
	{
		this._resizable := $toggle
		
		this.options(this._getPlusMinus($toggle) "Resize")
		
		return this
	}
	/** Set minimal size of gui
	 *
	 * @param	int	$width
	 * @param	int	$height
	 */
	minSize($width:="",$height:="")
	{
		this._minMaxSize("Min", "w", $width)
		this._minMaxSize("Min", "h", $height)
		
		return this
	}
	/** Set maximal size of gui
	 *
	 * @param	int	$width
	 * @param	int	$height
	*/
	maxSize($width :="",$height:="")
	{
		this._minMaxSize("Max", "w", $width)
		this._minMaxSize("Max", "h", $height)
		
		return this
	}
	/** Set fixed with of gui
	 *
	 * Fix to current without $width 
	 * @param	int	$width
	*/
	fixedWidth($width:=true)
	{
		if( $width==true && this._hwnd )
			$width := this._getGuiSize().w

		if( this._hwnd && this._fixed_width )
		{
			this.size($width)
			this._minMaxSize("Min", "w", $width)
			this._minMaxSize("Max", "w", $width)
			
		}else
			this._fixed_width := $width

		return this
	}	
	/*---------------------------------------
		PRIVATE METHODS
	-----------------------------------------
	*/
	/** Get clinet size of window with menus and borders
	 *  Or get bounding box of control, if gui does not exist yet
	 *  
	 */
	_getGuiSize( $hwnd:="" )
	{
		if( ! $hwnd )
			$hwnd := this._hwnd

		if( $hwnd )
		{
			VarSetCapacity(rc, 16)
			DllCall("GetClientRect", "uint", $hwnd, "uint", &rc)
			
			return {"w":NumGet(rc, 8, "int"), "h":NumGet(rc, 12, "int")}
		}
		else
			return {"w":this._getControlsBboxSizeWithMargin("x"), "h":this._getControlsBboxSizeWithMargin("y")}
		
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
		$value := this._getRelativeSize( $wh, $value )
		
		if( ! $value )
			return

		this._sizes.size[$wh] := $value
			
		if( this._hwnd )
			this.show( $wh $value, this._name )
	}
	/** if $value is relative
	 */
	_getRelativeSize( $wh, $value )
	{
		if( ! RegExMatch( $value, "^[\+\-]" )) 
			return $value
		
		$size := this._getGuiSize()
		
		return % ($wh=="w" ? $size.w : $size.h) + $value
	} 
	/** _minMaxSize
	*/
	_minMaxSize($min_max, $wh, $value)
	{
		if( ! $value )
			return	
		
		;this.options("+Resize")
		
		this._sizes[$min_max][$wh] := $value
		
		this.options( "+" $min_max "Size" ($wh=="w" ? $value : "") "x" ($h := $wh=="h" ? $value : ""))
		
		;this.resizeable( this._resizable )
	}

	/** Set size of guu as max size and backup this.sizes
	  *
	  * It allows autosize Gui only in one dimension
	 */
	_fixSizeOnAutosize()
	{
		if( ! this._sizes.size.w && ! this._sizes.size.h )
			return
	
		this._sizes_autosize_bak := this._objectClone(this._sizes)
	
		this.minSize(this._sizes.size.w, this._sizes.size.h)
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
	
		this.minSize(this._sizes.min.w, this._sizes.min.h)
		this.maxSize(this._sizes.max.w, this._sizes.max.h)		
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
}
