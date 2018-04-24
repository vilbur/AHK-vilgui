#Include %A_LineFile%\..\Lib\Includes.ahk

global $_GUI := {} ; stores multiple GUIs by hwnd of gui window
global $_GUI_margin
global $_GUI_tab_last
global $_last_window ; store gui name for lost focus event

/** Class VilGUI
*/
Class VilGUI extends Gui_vgui
{
	_name	:= "" ; sanitized title
	_title	:= "" 
	_hwnd	:= 0

	__New($title)
	{
		this._saveLastWindowCentering()
		
		this._base	:= &this
		this._title	:= $title	; BUG: GUI breaks If title with whitespace is used
		this._name	:= RegExReplace( $title, "i)[^A-Z0-9]+", "" )
		;$_GUI[this._name]	:= this
		
		this.Margin	:= new GuiMargin_vgui()
		$_GUI_margin	:= this.Margin ; Set Global Margin BEFORE Layout Configured
		this.Controls	:= new Controls_vgui().parent(this).guiName(this._name)
		this.Events	:= new Events_vgui().parent(this)
		this.Menus	:= new Menus()
		this.Style	:= new Style_vgui()

	}
	/** create gui
	 * Options are aplied after Gui is created
	 *
	 */
	create($options:="")
	{		
		this._sortLayouts()
		;this._tabsAutoSize()

		this._addMenu()
		this._addTrayMenu() ; BUG: default menu does not show IN TESTING
		
		this._bindMouseEvents()
		
		this._setMaxHeightByMonitor()
		
		this.show( this._getPositionOptions() "  " $options )
		
		this._setHwnd()
		
		this.autosize()
	
		this._applyInitOptions()

		this.Style.Color.hwnd(this._hwnd)
		
		WinSet Redraw,, % this.ahkId()

		return this
	}
	/**
	 */
	_applyInitOptions()
	{
		if( this._fixed_width )
			this.fixedWidth(this._fixed_width)		
				
		;if( this._center.window )
		;	this.center("window")
	}  

	/*---------------------------------------
		PRIVATE METHODS ON GUI CREATE
	-----------------------------------------
	*/
	/**
	 */
	_getPositionOptions()
	{
		$size_without_controls := ! this.Controls._Control ? "w128 h24 " : " " ; absolute minimum size to display gui without controls
		
		if( this._center.window )
		{
			$center_position := this._getCenterToWindowPositions()
			;Dump($center_position, "center_position", 1)
			this._position.x	:= $center_position.x
			this._position.y	:= $center_position.y			
		}
		
		$options :=	{x:	this._position.x
			,y:	this._position.y
			,w:	this._sizes.size.w
			,h:	this._sizes.size.h
			,xCenter:	this._center.x
			,yCenter:	this._center.y}
		;Dump($options, "options", 1)
		
		$options_string := this._joinOptions( this._removeCenterIfPositionDefined( $options ) )
		
		;MsgBox,262144,options_string, %$options_string%,3 
		
		return % $size_without_controls " " $options_string 			
	}
	
	/**
	 */
	_removeCenterIfPositionDefined( $options )
	{
		For $i, $xy in ["x", "y"]
			if( $options[$xy] )
				$options.delete($xy "Center")
		;Dump($options, "options", 1)
		return $options
	}
	/**
	 */
	_joinOptions( $options )
	{
		For $option, $value in $options
			if( $value )
				$options_string .= $option ( RegExMatch( $option, "^[xywh]$") ? $value " " : " ")
		;MsgBox,262144,options_string, %$options_string%,3 
		return $options_string
	}
	
	/** _addMenu()
	*/
	_addMenu()
	{
		this.Menus.Main.show(this._name)
	}
	/** _addTrayMenu()
	*/
	_addTrayMenu()
	{
		this.Menus.Tray
			.default(true)
			.show()
	}
	/** _bindMouseEvents()
	*/
	_bindMouseEvents()
	{
		this.Events.Mouse.bindWheel().bindScroll()	; Allow scroll
	}



}
