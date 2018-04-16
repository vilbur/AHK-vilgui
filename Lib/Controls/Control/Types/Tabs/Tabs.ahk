/** Class Tabs_vgui
  
   MESSAGE CONSTANTS: https://autohotkey.com/boards/viewtopic.php?p=25871#p25871

*/
Class Tabs_vgui extends ControlItems_vgui
{
	Tabs	:= []
	
	/** add
	*/
	add($name:="")
	{
		this.name($name)
		return % this.Controls().add(this)
	}
	/**  Executed by Controls() class after adding to Gui
		 Proceed methods necessary ADTER adding of object to GUI
	*/
	postAdd()
	{
		this.addTabs()
		this.Controls().parent()[this._name] := this
	}
	/** setTab
	*/
	addTabs()
	{
		For $t, $tab_name in this._items.array
			this.Tabs.push( new Tab_vgui(A_Index).name($tab_name).setControls(this) )
		return this
	}
	/** get Controls Values from each tab
		@return [{ctrl_name:value}] array of tabs with objects of control names and values
	*/
	getControlsValues()
	{
		$tabs_form_data := []
		
		For $t, $Tab in this.Tabs
			if($tab_form_data := $Tab.Controls.values())
				$tabs_form_data.push($tab_form_data)
				
		return %$tabs_form_data%
	}
	/** get Active Tab Number
		@return int|string number of title of active name
	*/
	active()
	{
		SendMessage, 0x130B, 0, 0, ,  % "ahk_id " this.hwnd
		$active_tab_index = %ErrorLevel%
		
		return % $active_tab_index +1
	}
	/** Get Active Tab Object
		@return object of active tab
	*/
	getActive()
	{
		return % this.Tabs[this.active()]
	}
	/** Get count of tabs
	 */
	count()
	{
		return % this.Tabs.length()
	}
	/** Highlight tabs title
	*/
	highlight($tab_num, $toggle:=true)
	{
		PostMessage, 0x1333, % $tab_num-1 , %$toggle%,, % "ahk_id " this.hwnd
		return this
	}
	/**
	*/
	select($tab_num)
	{
		SendMessage, 0x1330, % $tab_num-1,,, % "ahk_id " this.hwnd
	}
	/** Get Text of active tab
		TODO: Should be reached by SendMessage dynamically
	 */
	value()
	{
		return % this.Tabs[this.active()].name()
	}
	/** delete control from Layout, ControlList and Gui 
	 */
	delete()
	{
		;MsgBox,262144,, DELETE TABS,2 
		;Object(this._layout_container).deleteControl(this)
		;this.Controls()._List.delete(this.hwnd)
		;	
		;WM_CLOSE=0x10
		;PostMessage, %WM_CLOSE%,,,, % "ahk_id " this.hwnd
	}

	/*---------------------------------------
		Layout
	-----------------------------------------
	*/
	/** Sort layout of each tab
	*/
	sortTabsLayouts()
	{
		$Bbox_all_tabs	:= new Bbox_vgui()
		
		For $t, $Tab in this.Tabs
			$Bbox_all_tabs.add( this._getTabBoundingBox( $Tab ) ) ; Sort layout of tab, get tab`s bounding box and add bbox to bbox of all tabs
		
		this._resizeTabsByBoundingBox($Bbox_all_tabs.remove(this.pos()))
	}
	/**
	 */
	_getTabBoundingBox( $Tab )
	{
		$tab_bbox := $Tab.Controls._Layout.ContainerMain
									.setOriginByPosition($_GUI_margin.container.x(), $_GUI_margin.container.y())  ; Set margins to TOP & LEFT of TAB
									.sortSections()
									.Bbox

		return $tab_bbox							
	} 
	
	
	/** _resizeTabsByBoundingBox
	*/
	_resizeTabsByBoundingBox($Bbox)
	{
		;Dump($Bbox, "Bbox", 1)
		$tabs_min_size	:= {"x":200, "y":100}
		$width	:= ($Bbox.x>$tabs_min_size.x ? $Bbox.x : $tabs_min_size.x) + $_GUI_margin.container.x() +5	; Set margins to RIGHT of TAB
		$height	:= ($Bbox.y>$tabs_min_size.y ? $Bbox.y : $tabs_min_size.y) + $_GUI_margin.container.y() +5	; Set margins to BOTTOM of TAB
		
		this.size($width, $height)
		;Dump($height, $width, 1)
		;$Tabs.size($Bbox.x + $_GUI_margin.ui.x(), $Bbox.y + $_GUI_margin.ui.y())
	}
	/*---------------------------------------
		SUBMIT
	-----------------------------------------
	*/

}

