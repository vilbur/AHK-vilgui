/** Class Gui
*/
Class Gui_vgui{

	Monitor	:= new Monitor()
	;_resizable	:= false
	_center	:= {x:true, y:false}
	_size	:= {"min":	{w:0,	h:256}	; store min sizes of gui
		   ,"max":	{w:0,	h:1024}	; store max sizes of gui
		   ,"auto":	{w:0,	h:0}}	; store auto sizes of gui

	/**
	  */
	show($options:=""){
		;MsgBox,262144,, Test,2
		this.parent().create()
		this.autosize()
		this.parent()._tabsAutoSize()

		this.fixedWidth()
		this._setMaxHeightByMonitor()

		;this.center("x",this._center.x)
		;this.center("y",this._center.y)
		this._guiShow($options)
		return this
	}
	/*---------------------------------------
		GUI SET OPTIONS
	-----------------------------------------
	*/
	/** Resize GUI by content in current tab
	*/
	size($w:="", $h:=""){
		this._setSize("w", $w)
		this._setSize("h", $h)
		this._scrollbar()
		return this
	}
	/** autosize
	*/
	autosize(){
		;this._margin($GUI_margin.ui.x(), $GUI_margin.ui.y())
		this._guiShow("AutoSize")
		this._correctMarginOfGui()
		this._scrollbar()
		$size	:= this._getGuiSize()
		this._size.auto 	:= {w:$size.w,	h:$size.h}
		return this
	}
	/** resizeable
	*/
	resizeable($toggle:=true){
		this._guiOption(this._getPlusMinus($toggle) "Resize")
		return this
	}
	/** maxSize
	*/
	maxSize($w:="",$h:=""){
		this._minMaxSize("Max", "w", $w)
		this._minMaxSize("Max", "h", $h)
		return this
	}
	/** minSize
	*/
	minSize($w:="",$h:=""){
		this._minMaxSize("Min", "w", $w)
		this._minMaxSize("Min", "h", $h)
		return this
	}
	/** fixedWidth
	*/
	fixedWidth($width:=""){
		if(!$width)
			$width := this._getGuiSize().w

		this._minMaxSize("Min", "w", $width)
		this._minMaxSize("Max", "w", $width)

		return this
	}
	/** alwaysOnTop
	*/
	alwaysOnTop($toggle:=true){
		this._guiOption(this._getPlusMinus($toggle) "AlwaysOnTop")
		return this
	}
	/** center
	*/
	center($xy, $toggle:=true){
		this._center[$xy] := $toggle
		if(this._center[$xy])
			this._guiShow($xy "Center")
		return this
	}
	;/** close
	;*/
	;close(){
	;	this._guiOption("Destroy")
	;	return this
	;}
	/*---------------------------------------
		PRIVATE METHODS
	-----------------------------------------
	*/
	/** _guiShow
	*/
	_guiShow($options:=""){
		;Dump(this.parent().hwnd, "this.", 1)
		Gui, % this.parent().hwnd ":Show", %$options%, % this.parent().hwnd ; !!! BUG: GUI BREAKS if title "this.parent().title" has whitespace
		return this
	}
	/** _guiShow
	*/
	_guiOption($option:=""){
		Gui, % this.parent().hwnd ":" $option
		return this
	}
	/** _getPlusMinus
	*/
	_getPlusMinus($toggle){
		return % $toggle ? "+" : "-"
	}
	/** _minMaxSize
	*/
	_minMaxSize($minMax, $wh, $value){
		this._size[$minMax][$wh] := $value
		this._guiOption( "+" $minMax "Size" ($wh=="w" ? $value : "") "x" ($h := $wh=="h" ? $value : ""))
	}
	/** _margin
	*/
	_margin($x, $y){
		Gui, % this.parent().hwnd ":Margin", %$x%, %$y%
		return this
	}
	/** _scrollbar
	*/
	_scrollbar($toggle:=true){
		if($toggle && this._isScrollbarNeeded())
			UpdateScrollBars(this.parent().hwnd, $width, this._getGuiSize().h )
		else
			Gui,% this.parent().hwnd ":-0x200000"
		return this
	}
	/** Set relative or absolute size of gui
		@param "w|h"	$wh	width or height
		@param int|string	$value	absolute or relative size of gui E.G: ABSOLUTE: 1024 | RELATIVE: -128 or "+128"
		    E.G: size(512, 1024 )  ; Gui size will be 512x1024 px
				 size("",  "+128") ; Current size will added   128 px
				 size("",  -128 )  ; Current size will removed 128 px
	*/
	_setSize($wh, $value){
		if(RegExMatch( $value, "^[\+\-]" )){ ; if $value is relative
			$size := this._getGuiSize()
			$value := ($wh=="w" ? $size.w : $size.h) + $value
		}
		if($value)
			this._guiShow( $wh $value) ; Heght: -52 when menu is -32 without menu
			;this._guiShow( $wh this._getSizeValue($wh, $value)) ; Heght: -52 when menu is -32 without menu
	}
	/** Add _margin to right and bottom of gui
		Margin is missing if elements are positioned with sections
	*/
	_correctMarginOfGui(){
		this.size("-8") ; remove margin added with autosize()
		this.size("+" $GUI_margin.ui.x(), "+" $GUI_margin.ui.y())
	}
	/** _isScrollbarNeeded
	*/
	_isScrollbarNeeded(){
		;WinGetPos,,,$width, $height, % this.parent().hwnd
		return % this._getGuiSize().h < this._getControlsBboxSize("y")
	}
	/** _getControlsBboxSize
	*/
	_getControlsBboxSize($xy){
		return % this.parent().Controls._Layout.ContainerMain.Bbox[$xy]
	}
	/** _getGuiSize
	*/
	_getGuiSize(){
		hwnd := WinExist(this.parent().hwnd)
		VarSetCapacity(rc, 16)
		DllCall("GetClientRect", "uint", hwnd, "uint", &rc)
		return {w:NumGet(rc, 8, "int"), h:NumGet(rc, 12, "int")}
	}
		/** Set max gui height by Active monitor height
	*/
	_setMaxHeightByMonitor(){
		this._minMaxSize("Max", "h", this.Monitor.getDimensions("height", this.Monitor.findMonitorActive().monitor.active))
	}
	/* Set address of parent gui
	   Parent gui is main Gui Or Tabs object for tabs
	*/
	parent($Parent:=""){
		if($Parent)
			this._parent	:= &$Parent
		return % $Parent ? this : Object(this._parent)
	}

}
