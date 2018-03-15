/** Class Tabs_vgui
*/
Class Tabs_vgui extends ControlItems_vgui {

	Tabs	:= []
	/** add
	*/
	add($name:=""){
		this.name($name)
		return % this.Controls().add(this)
	}
	/**  Executed by Controls() class after adding to Gui
		 Proceed methods necessary ADTER adding of object to GUI
	*/
	postAdd(){
		this.addTabs()
		this.Controls().parent()[this._name] := this
	}
	/** setTab
	*/
	addTabs(){
		For $t, $tab_name in this._items.array
			this.Tabs.push(new Tab_vgui(A_Index).name($tab_name).setControls(this))
		return this
	}
	/** get Controls Values from each tab
		@return [{ctrl_name:value}] array of tabs with objects of control names and values
	*/
	getControlsValues(){
		$tabs_form_data := []
		For $t, $Tab in this.Tabs
			if($tab_form_data := $Tab.Controls.values())
				$tabs_form_data.push($tab_form_data)
		return %$tabs_form_data%
	}
	/** get Active Tab Number
		NOTE: Tabs option "AltSubmit" MUST BE SET FOR tab number, without return tab title
		@return int|string number of title of active name
	*/
	active(){
		GuiControlGet, $active_tab,, % this.hwnd
		return %$active_tab%
	}
	/** Get Active Tab Object
		NOTE: Tabs option "AltSubmit" MUST BE SET FOR tab number, without return tab title
		@return object of active tab
	*/
	getActive(){
		return % this[this.active()]
	}
	/** Highlight tabs title
	*/
	highlight($tab_num, $toggle:=true){
		PostMessage, 0x1333, % $tab_num-1 , %$toggle%,, % "ahk_id " this.hwnd
		return this
	}
	/**
	*/
	select($tab_num){
		SendMessage, 0x1330, % $tab_num-1,,, % "ahk_id " this.hwnd
	}




	/*---------------------------------------
		Layout
	-----------------------------------------
	*/
	/** sortTabsLayouts
	*/
	sortTabsLayouts(){
		;MsgBox,262144,, sortTabsLayouts,2
		;Dump($Tab, "Tab", 0)
		$Bbox_all_tabs	:= new Bbox_vgui()
		For $t, $Tab in this.Tabs
			$Bbox_all_tabs.add( $Tab.Controls._Layout.ContainerMain
									.setOriginByPosition($GUI_margin.container.x(), $GUI_margin.container.y())  ; Set margins to TOP & LEFT of TAB
									.sortSections()
									.Bbox) ; Sort layout of tab, get tab`s bounding box and add bbox to bbox of all tabs
		this.resizeTabsByBoundingBox($Bbox_all_tabs.remove(this.pos()))
	}
	/** resizeTabsByBoundingBox
	*/
	resizeTabsByBoundingBox($Bbox){
		;Dump($Bbox, "Bbox", 1)
		$tabs_min_size	:= {"x":200, "y":100}
		$width	:= ($Bbox.x>$tabs_min_size.x ? $Bbox.x : $tabs_min_size.x) + $GUI_margin.container.x() +5	; Set margins to RIGHT of TAB
		$height	:= ($Bbox.y>$tabs_min_size.y ? $Bbox.y : $tabs_min_size.y) + $GUI_margin.container.y() +5	; Set margins to BOTTOM of TAB
		this.size($width, $height)
		;Dump($height, $width, 1)
		;$Tabs.size($Bbox.x + $GUI_margin.ui.x(), $Bbox.y + $GUI_margin.ui.y())
	}



}
