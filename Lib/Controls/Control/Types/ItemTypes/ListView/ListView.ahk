/** Class ListView_vgui
	Forum GuiListViewEx: https://autohotkey.com/board/topic/80686-class-guilistviewex-added-functions-for-gui-listviews/

	LISTVIEW DEFAULTS:
		EVENTS: RightClick - display context menu in list view

		MENU: RightClick context menu

		MENU ITEMS: Remove row

*/
Class ListView_vgui extends ListViewEvents_vgui
{

	_data	:= [] ; data for listbox
	_checkbox	:= false
	Menu	:= new Menu()
	_Columns	:= new ModifyCol_vgui()
	_Rows	:= new ModifyRow_vgui()

	/*-----------------------------------------
		PUBLIC - ADDING TO GUI
	-----------------------------------------
	*/
	/** Button
	*/
	add($name:="")
	{
		this.name($name)

		this.preAdd()
		this.Controls().add(this) ; clone added object if user insert one object multiple times

		return % this.Controls() ; Return Parent GUI, it allows chaining when controls are added
	}
	/** Proceed methods necessary BEFORE adding of object to GUI
	*/
	preAdd()
	{
		this._bindDefaultCallback(&this "._eventDefault")
		this._menuDefaults()
	}
	/**  Executed by Controls() class after adding to Gui
		 Proceed methods necessary ADTER adding of object to GUI
	*/
	postAdd()
	{
		if(this._data.MaxIndex())
			this.addData(this._data)

		this._Columns.hwnd(this.guiName(), this.hwnd).modify()
		this._Rows.hwnd(this.guiName(), this.hwnd).modify()
	}
	/*-----------------------------------------
		PUBLIC - SET PROPERTIES
	-----------------------------------------
	*/
	/** Default data for listview
	*/
	data($data)
	{
		this._data := $data
		return this
	}
	/** add Data to ListView
		HELP: https://autohotkey.com/docs/commands/ListView.htm#RowOptions

		@param array|object|2Dmatrix $data of rows E.g: [["row1","column2","column3"], ["row2","column2","column3"]]
		@param string $options
	*/
	addData($data, $options:="")
	{
		$data := !isObject($data[1]) ? this.objToArray([$data]) : this.objToArray($data)

		this._activateListView()
		For $r, $row_data in $data
			LV_Add($options,  $row_data*)

		;this._Columns.fitColumns()

		return this
	}
	/** checkbox
	*/
	checkbox($toggle:=true)
	{
		this._checkbox	:= $toggle
		if($toggle)
			this._Options.add("checked")
		return this
	}


	/*-----------------------------------------
		PUBLIC - MODIFY LISTVIEW
	-----------------------------------------
	/** Set value of control if not added in GUI yet
	*/
	value($value:="~null")
	{
		if($value=="~null"){
			$selected_rows := {}
			For $r, $row in % this._getCheckedOrFocusedRows()
				$selected_rows[$row] := this._Rows.value($row)
			return %$selected_rows%
		}
		
		return this
	}
	/** Change Order of columns
	*/
	changeOrder()
	{
		GuiControl, -ReDraw, % this.hwnd
		GuiListViewEx.SetColumnOrder(this.hwnd, [3, 2, 1])

		$ColArr := GuiListViewEx.GetColumnOrder(this.hwnd)
		For $i, $id In $ColArr
			LV_ModifyCol($id, "AutoHdr")
		GuiControl, +ReDraw, % this.hwnd
	}
	/** Set\Apply modifyCol OR get _Rows class
		@params reference: ModifyRow.modifyCol()

		@return object this OR ModifyCol class
	*/
	modify($param1:="", $param2:="")
	{
		if($param1=="" && $param2=="")
			return % this._Rows
		this._Rows.modify($param1, $param2)
		return this
	}
	/** Set\Apply modifyCol OR get _Columns class
		@params reference: ModifyCol.modifyCol()

		@return object this OR ModifyCol class
	*/
	modifyCol($param1:="", $param2:="")
	{
		if($param1=="" && $param2=="")
			return % this._Columns
		this._Columns.modify($param1, $param2)
		return this
	}
	/** Is Row checked
		@param	int $row_num row number to check, FOCUSED ROW IS USED IF UNDEFINED
		@return boolean
	*/
	isChecked($row_num:="")
	{
		this._activateListView()
		if(!$row_num)
			$row_num :=  LV_GetNext("F")

		SendMessage, 4140, $row_num - 1, 0xF000,,  % "ahk_id " this.hwnd  ; 4140 is LVM_GETITEMSTATE.  0xF000 is LVIS_STATEIMAGEMASK.
		return % (ErrorLevel >> 12) - 1	> 0
	}

	/*-----------------------------------------
		PRIVATE
	-----------------------------------------
	*/
	/** Set _Columns in ListView
	*/
	columns($columns)
	{
		this.items($columns)
		this._Columns.count(this._items.array.MaxIndex())
		return this
	}
	/** Activate ListView for manipulation
	*/
	_activateListView()
	{
		Gui, % this.guiName() ":Default"
		Gui, % this.guiName() ":ListView", % this.hwnd
	}
	/** Add default methods to menu
	*/
	_menuDefaults(){
		this._addDefaultMenuItem("RightClick", "Add", &this ".addRow")
		this._addDefaultMenuItem("RightClick", "Remove", &this ".removeRow")

		if(!this.Event.Add) ; dont overide custom callback
			this.on("Add", "createAddRowDialog" )
		return this
	}
	/** _addDefaultMenu	Item
	*/
	_addDefaultMenuItem($menu, $label, $callback){
		this.Menu.defaults($label, $callback)
		if(!this.Menu[$menu]) ; create new menu if not exists
			this.Menu.menu($menu)
		this.Menu[$menu].item($label)
	}
	/*-----------------------------------------
		HELPERS
	-----------------------------------------
	*/

	/** objToArray
	*/
	objToArray($obj)
	{
		$arr := []
		For $i, $value in $obj
			$arr.push(!isObject($value)?$value:this.objToArray($value))
		return %$arr%
	}
}
