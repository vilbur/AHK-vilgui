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
	/** Loop all Tabs
	*/
	_sortTabsLayout()
	{
		For $tabs_name, $address in % this.Controls._List._ControlsTypes.Tabs
		{
			$Tabs := this[$tabs_name]
			$Tabs.sortTabsLayouts()
			this.Controls._Layout.sort()	; Sort layout again - Sort controls under tabs
		}
	}

	/** _tabsAutoSize
	*/
	_tabsAutoSize()
	{
		if($width := this.Controls._OptionsDefaults.getDefaultOption("Tabs","w")=="auto")
		{
			$width := this._getGuiSize().w - $_GUI_margin.ui.x()*2
			For $tabs_name, $address in this.List._ControlsTypes.Tabs
				this[$tabs_name].size($width )
		}
	}
	/** _margin
	*/
	_margin($x, $y)
	{
		Gui, % this._gui("Margin"), %$x%, %$y%
		
		return this
	}
	/** _scrollbar
	*/
	_scrollbar($toggle:=true)
	{
		;MsgBox,262144,, % "isScrollbarNeeded: " this._isScrollbarNeeded(),2 
		
		if($toggle && this._isScrollbarNeeded())
			UpdateScrollBars(this._name, 0, this._getGuiSize().h )
			
		else
			Gui, % this._gui("-0x200000")			
			
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
		$gui_size	:= this._getGuiSize()
		$bbox_size	:= this._getControlsBboxSize("y")	
		;MsgBox,262144,, % $gui_size.h "`n" $bbox_size
		
		return % $gui_size.h < $bbox_size
	}
	/** _getControlsBboxSize
	*/
	_getControlsBboxSize($xy)
	{
		return % this.Controls._Layout.ContainerMain.Bbox[$xy]
	}
	/** _getControlsBboxSize with margin
	*/
	_getControlsBboxSizeWithMargin($xy)
	{
		$margin := $xy=="x" ? $_GUI_margin.ui.x() : $_GUI_margin.ui.y()
		
		return % this.Controls._Layout.ContainerMain.Bbox[$xy] + $margin
	}
	/** Set max gui height by Active monitor height
	*/
	_setMaxHeightByMonitor()
	{
		this._minMaxSize("Max", "h", this.Monitor.getDimensions("height", this.Monitor.findMonitorActive().monitor.active))
	}
	
	
}
