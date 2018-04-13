/** GuiLayout
*/
Class GuiLayout_vgui extends GuiSize_vgui
{
	
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
	/** _margin
	*/
	_margin($x, $y)
	{
		Gui, % this._name ":Margin", %$x%, %$y%
		return this
	}
	/** _scrollbar
	*/
	_scrollbar($toggle:=true)
	{
		if($toggle && this._isScrollbarNeeded())
			UpdateScrollBars(this._name, $width, this._getGuiSize().h )
		else
			Gui,% this._name ":-0x200000"
		return this
	}

	/** Add _margin to right and bottom of gui
		Margin is missing if elements are positioned with sections
	*/
	_correctMarginOfGui()
	{
		this.size("-8") ; remove margin added with autosize()
		this.size("+" $_GUI_margin.ui.x(), "+" $_GUI_margin.ui.y())
	}
	/** _isScrollbarNeeded
	*/
	_isScrollbarNeeded()
	{
		;WinGetPos,,,$width, $height, % this._name
		return % this._getGuiSize().h < this._getControlsBboxSize("y")
	}
	/** _getControlsBboxSize
	*/
	_getControlsBboxSize($xy)
	{
		return % this.Controls._Layout.ContainerMain.Bbox[$xy]
	}

	/** Set max gui height by Active monitor height
	*/
	_setMaxHeightByMonitor()
	{
		this._minMaxSize("Max", "h", this.Monitor.getDimensions("height", this.Monitor.findMonitorActive().monitor.active))
	}
	
	
}
