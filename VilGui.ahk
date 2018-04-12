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
		;this.hwnd	:= $hwnd		
		this.hwnd	:= RegExReplace( $hwnd, "i)[^A-Z0-9]+", "" )
		
		;this.title	:= $hwnd	; BUG: GUI breaks If title with whitespace is used
		this.Margin	:= new GuiMargin_vgui()
		$_GUI[this.hwnd]	:= this
		$_GUI_margin	:= this.Margin ; Set Global Margin BEFORE Layout Configured
		;this.List	:= new ControlsList_vgui()
		this.Controls	:= new Controls_vgui().parent(this).hwnd(this.hwnd)
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

		this.fixedWidth()
		this._setMaxHeightByMonitor()
		
		this.show($options)
				
		return this
	}
	/** submit gui
		@return object values of all controls
	*/
	submit()
	{
		$form_data := this.Controls.values()
		For $tabs_name, $address in this.Controls.Types.Tabs
			$form_data[$tabs_name] := this[$tabs_name].getControlsValues()

		this.Events.gui.call("onSubmit", {data:$form_data})	; call GUI events
		return %$form_data%
	}
	/** close window
	*/
	close()
	{
		;MsgBox,262144,, CLOSE,2		
		this.Events.gui.call("onClose")
		this.options("Destroy")
	}
	/** exit script
	*/
	exit()
	{
		;MsgBox,262144,, EXIT,2		
		this.Events.gui.call("onExit")
		ExitApp
	} 
	/*---------------------------------------
		PRIVATE METHODS ON GUI CREATE
	-----------------------------------------
	*/
	/** _addMenu()
	*/
	_addMenu()
	{
		this.Menus.Main.show(this.hwnd)
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

	/*---------------------------------------
		Layout
	-----------------------------------------
	*/
	/** _sortLayouts
	*/
	_sortLayouts()
	{
		;this.Controls.Layout.ContainerMain.origin({"x":$_GUI_margin.ui.x(), "y": $_GUI_margin.ui.y()}) ; Set margins to TOP & LEFT of UI
		this.Controls._Layout.sort()	; Sort layout
		this._sortTabsLayout()	; Sort layout in tabs

	}
	/** _sortTabsLayout
	*/
	_sortTabsLayout()
	{
		For $tabs_name, $address in % this.Controls._List._ControlsTypes.Tabs {
			;Dump($tabs_name, "tabs_name", 1)
			this[$tabs_name].sortTabsLayouts()
			this.Controls._Layout.sort()	; Sort layout again - Sort controls under tabs
		}
	}
	/** tabs
	*/
	tabs($tabs)
	{
		return % new Tabs_vgui(this.Controls).items($tabs)
	}
	/** _tabsAutoSize
	*/
	_tabsAutoSize()
	{
		if($width := this.Controls._OptionsDefaults.getDefaultOption("Tabs","w")=="auto"){
			$width := this._getGuiSize().w - $_GUI_margin.ui.x()*2
			For $tabs_name, $address in this.List._ControlsTypes.Tabs
				this[$tabs_name].size($width )
		}
	}


}
