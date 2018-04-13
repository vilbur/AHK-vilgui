#Include %A_LineFile%\..\Lib\Includes.ahk

global $_GUI := {}
global $_GUI_margin
global $_GUI_tab_last
global $_last_window ; store gui name for lost focus event

/** Class VilGUI
*/
Class VilGUI extends Gui_vgui
{

	__New($hwnd)
	{	
		this._title	:= $hwnd	; BUG: GUI breaks If title with whitespace is used
		this._name	:= RegExReplace( $hwnd, "i)[^A-Z0-9]+", "" )
		;$_GUI[this._name]	:= this
		
		this.Margin	:= new GuiMargin_vgui()
		$_GUI_margin	:= this.Margin ; Set Global Margin BEFORE Layout Configured
		this.Controls	:= new Controls_vgui().parent(this).guiName(this._name)
		this.Events	:= new Events_vgui().parent(this)
		this.Menus	:= new Menus()
		
	}
	/** create gui
	 * Options are aplied after Gui is created
	 *
	 *
	 */
	create($options:="")
	{
		this._saveLastWindowCentering()
		
		this._sortLayouts()		
		this._addMenu()
		;this._addTrayMenu() ; BUG: default menu does not show
		this._bindMouseEvents()
		
		this.minSize()
		this.autosize()		
		this._tabsAutoSize()
		
		;this.fixedWidth()
		;this._setMaxHeightByMonitor()
		
		this.show($options)
		
		this._setGuiToGlobal()
		
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
	/**
	 */
	_setGuiToGlobal()
	{
		WinGet, $hwnd, ID, A		
		
		$_GUI[$hwnd]	:= this
	} 


}
