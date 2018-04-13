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
		
		;this.minSize()
		;this._tabsAutoSize()
		
		;this.fixedWidth()
		;this._setMaxHeightByMonitor()
		this.autosize()
		
		this.show($options)

		
		this.Style.Color.hwnd(this._hwnd)

		return this
	}

	/*---------------------------------------
		PRIVATE METHODS ON GUI CREATE
	-----------------------------------------
	*/
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
