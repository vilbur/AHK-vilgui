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
		this._title	:= $title	; BUG: GUI breaks If title with whitespace is used
		this._name	:= RegExReplace( $title, "i)[^A-Z0-9]+", "" )
		;$_GUI[this._name]	:= this
		
		this.Margin	:= new GuiMargin_vgui()
		$_GUI_margin	:= this.Margin ; Set Global Margin BEFORE Layout Configured
		this.Controls	:= new Controls_vgui().parent(this).guiName(this._name)
		this.Events	:= new Events_vgui().parent(this)
		this.Menus	:= new Menus()
		this.Style	:= new Style_vgui()
	
		this._saveLastWindowCentering()
	}
	/** create gui
	 * Options are aplied after Gui is created
	 *
	 */
	create($options:="")
	{
		this._sortLayouts()		
		this._addMenu()
		this._addTrayMenu() ; BUG: default menu does not show IN TESTING
		this._bindMouseEvents()
		
		this._tabsAutoSize()
		
		this._setMaxHeightByMonitor()

		
		this.show( this._getInitOptions() " " $options )
		this._setHwnd()

		this.minSize( this._sizes.min.w, this._sizes.min.h )

		
		this.autosize()
		
		if( this._fixed_width )
			this.fixedWidth(this._fixed_width)		
		
		;if( ! this._resizeable )
			;this.resizeable(this._resizeable)
		
		if( this._center.window )
			this.center()
		
		this.Style.Color.hwnd(this._hwnd)

		return this
	}

	/*---------------------------------------
		PRIVATE METHODS ON GUI CREATE
	-----------------------------------------
	*/
	/**
	 */
	_getInitOptions()
	{
		;$abs_min_size := "w128 h24 " ; absolute minimum size to display gui without controls
		
		$options :=	{x:	this._position.x
			,y:	this._position.y
			,w:	this._sizes.size.w
			,h:	this._sizes.size.h
			,xCenter:	this._center.x
			,yCenter:	this._center.y}
		;Dump($options, "options", 1)
		return % $abs_min_size this._joinOptions( this._removeCenterIfPositionDefined( $options ) )			
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
		this.Menus.Tray.show()
	}
	/** _bindMouseEvents()
	*/
	_bindMouseEvents()
	{
		this.Events.Mouse.bindWheel().bindScroll()	; Allow scroll
	}



}
