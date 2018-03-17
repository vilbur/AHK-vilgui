/** Class Gui
*/
Class Gui_vgui{

	Monitor	:= new Monitor()
	;;;_resizable	:= false
	_center	:= {x:true, y:false}
	_size	:= {"min":	{w:0,	h:256}	; store min sizes of gui
		   ,"max":	{w:0,	h:1024}	; store max sizes of gui
		   ,"auto":	{w:0,	h:0}}	; store auto sizes of gui

	/** wrapper for https://autohotkey.com/docs/commands/Gui.htm
	 ;*	@param string $options strings from documentation 
	*/
	gui($command, $param1:="", $param2:="", $param3:="")
	{
		Gui, % this.hwnd ":" $command, %$param1%, %$param2%, %$param3%
		return this
	}
	/**	wrapper for https://autohotkey.com/docs/commands/Gui.htm#Show
	 *	@param string $options
	 */
	show($options:=""){
		;Dump(this.hwnd, "this.", 1)
		Gui, % this.hwnd ":Show", %$options%, % this.hwnd ; !!! BUG: GUI BREAKS if title "this.title" has whitespace
		return this
	}	
	
	/*---------------------------------------
		GUI METHODS
	-----------------------------------------
	*/
	/** wrapper for https://autohotkey.com/docs/commands/Gui.htm#Options
	 *	@param string $options strings from documentation 
	*/
	options($option:=""){
		Gui, % this.hwnd ":" $option
		return this
	}
	/** Resize GUI
	  *
	  */
	size($width:="", $height:=""){
		this._setSize("w", $width)
		this._setSize("h", $height)
		this._scrollbar()
		return this
	}
	/** Resize GUI by its content
	*/
	autosize(){
		;;;this._margin($_GUI_margin.ui.x(), $_GUI_margin.ui.y())
		this.show("AutoSize")
		this._correctMarginOfGui()
		this._scrollbar()
		$size	:= this._getGuiSize()
		this._size.auto 	:= {w:$size.w,	h:$size.h}
		return this
	}
	/*---------------------------------------
		GUI SET OPTIONS METHODS
	-----------------------------------------
	*/
	/** make gui resizeable
	  * default is unresizable gui 
	*/
	resizeable($toggle:=true){
		this.options(this._getPlusMinus($toggle) "Resize")
		return this
	}
	/** set minimal size of gui
	*/
	minSize($width:=128,$height:=128){
		this._minMaxSize("Min", "w", $width)
		this._minMaxSize("Min", "h", $height)
		return this
	}
	/** set maximal size of gui
	*/
	maxSize($width :="",$height:=""){
		this._minMaxSize("Max", "w", $width)
		this._minMaxSize("Max", "h", $height)
		return this
	}
	/** set fixed with of gui
	*/
	fixedWidth($width:=""){
		if(!$width)
			$width := this._getGuiSize().w

		this._minMaxSize("Min", "w", $width)
		this._minMaxSize("Max", "w", $width)

		return this
	}
	/** set window always on top
	*/
	alwaysOnTop($toggle:=true){
		this.options(this._getPlusMinus($toggle) "AlwaysOnTop")
		return this
	}
	/** center gui on display
	  * @param string $xy "x|y"
	*/
	center($xy, $toggle:=true){
		this._center[$xy] := $toggle
		if(this._center[$xy])
			this.show($xy "Center")
		return this
	}
	/*---------------------------------------
		PRIVATE METHODS
	-----------------------------------------
	*/


	/** _getPlusMinus
	*/
	_getPlusMinus($toggle){
		return % $toggle ? "+" : "-"
	}
	/** _minMaxSize
	*/
	_minMaxSize($minMax, $wh, $value){
		this._size[$minMax][$wh] := $value
		this.options( "+" $minMax "Size" ($wh=="w" ? $value : "") "x" ($h := $wh=="h" ? $value : ""))
	}
	/** _margin
	*/
	_margin($x, $y){
		Gui, % this.hwnd ":Margin", %$x%, %$y%
		return this
	}
	/** _scrollbar
	*/
	_scrollbar($toggle:=true){
		if($toggle && this._isScrollbarNeeded())
			UpdateScrollBars(this.hwnd, $width, this._getGuiSize().h )
		else
			Gui,% this.hwnd ":-0x200000"
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
			this.show($wh $value, this.hwnd )
			;this.show( $wh $value) ; Heght: -52 when menu is -32 without menu
			;this.show( $wh this._getSizeValue($wh, $value)) ; Heght: -52 when menu is -32 without menu
	}
	/** Add _margin to right and bottom of gui
		Margin is missing if elements are positioned with sections
	*/
	_correctMarginOfGui(){
		this.size("-8") ; remove margin added with autosize()
		this.size("+" $_GUI_margin.ui.x(), "+" $_GUI_margin.ui.y())
	}
	/** _isScrollbarNeeded
	*/
	_isScrollbarNeeded(){
		;WinGetPos,,,$width, $height, % this.hwnd
		return % this._getGuiSize().h < this._getControlsBboxSize("y")
	}
	/** _getControlsBboxSize
	*/
	_getControlsBboxSize($xy){
		return % this.Controls._Layout.ContainerMain.Bbox[$xy]
	}
	/** _getGuiSize
	*/
	_getGuiSize(){
		hwnd := WinExist(this.hwnd)
		VarSetCapacity(rc, 16)
		DllCall("GetClientRect", "uint", hwnd, "uint", &rc)
		return {w:NumGet(rc, 8, "int"), h:NumGet(rc, 12, "int")}
	}
		/** Set max gui height by Active monitor height
	*/
	_setMaxHeightByMonitor(){
		this._minMaxSize("Max", "h", this.Monitor.getDimensions("height", this.Monitor.findMonitorActive().monitor.active))
	}


}
