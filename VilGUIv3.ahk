#Include %A_LineFile%\..\Lib\Includes.ahk

global $GUI := {}
global $GUI_margin

/** Class VilGUIv3
*/
Class VilGUIv3{

	;_Tabs	:= []

	__New($hwnd){
		this.hwnd	:= $hwnd
		this.Margin	:= new GuiMargin_vgui()
		$GUI[$hwnd]	:= this
		$GUI_margin	:= this.Margin ; Set Global Margin BBFORE Layout Configured
		this.List	:= new ControlsList_vgui()
		this.Controls	:= new Controls_vgui().parent(this).hwnd(this.hwnd)
		this.Gui	:= new Gui_vgui().parent(this)
		this.Events	:= new Events_vgui().parent(this)
		this.Menus	:= new Menus()
	}
	/** create()
	*/
	create(){
		;MsgBox,262144,, Test,2
		this.sortLayouts()
		this.Menus.Main.show(this.hwnd)
		this.Menus.Tray.show()

		this.Events.Mouse.bindWheel().bindScroll()	; Allow scroll
		;this.Events.Mouse.bindEvent()	; Allow scroll
		;Dump(this.List, "this.List", 0)
		;Dump(this, "this", 0)
		return this
	}

	/** submit gui
		@return object values of all controls
	*/
	submit($Events:=""){

		$form_data := this.Controls.values()
		For $tabs_name, $address in this.Controls.Types.Tabs
				$form_data[$tabs_name] := this[$tabs_name].getControlsValues()

		;this.Events.gui.call("submit", $form_data)	; call GUI events
		return %$form_data%
	}
	/** close
	*/
	close(){
		;MsgBox,262144,, CLOSE,2
		this.Gui._guiOption("Destroy")
	}
	/** exit
	*/
	exit($callback_custom:=""){
		if(!$callback_custom)
			ExitApp
	}
	/*---------------------------------------
		Layout
	-----------------------------------------
	*/
	/** sortLayouts
	*/
	sortLayouts(){
		;this.Controls.Layout.ContainerMain.origin({"x":$GUI_margin.ui.x(), "y": $GUI_margin.ui.y()}) ; Set margins to TOP & LEFT of UI
		this.Controls._Layout.sort()	; Sort layout
		this._sortTabsLayout()	; Sort layout in tabs

	}
	/** _sortTabsLayout
	*/
	_sortTabsLayout(){
		;Dump(this.List, "this.List", 0)
		For $tabs_name, $address in this.List._ControlsTypes.Tabs {
			this[$tabs_name].sortTabsLayouts()
			this.Controls._Layout.sort()	; Sort layout again - Sort controls under tabs
			;this[$tabs_name].sortTabsLayouts()
		}
	}
	/** tabs
	*/
	tabs($tabs){
		return % new Tabs_vgui(this.Controls).items($tabs)
	}
	/** _tabsAutoSize
	*/
	_tabsAutoSize(){
		if($width := this.Controls._OptionsDefaults.getDefaultOption("Tabs","w")=="auto"){
			$width := this.Gui._getGuiSize().w - $GUI_margin.ui.x()*2
			For $tabs_name, $address in this.List._ControlsTypes.Tabs
				this[$tabs_name].size($width )

		}
	}

}
