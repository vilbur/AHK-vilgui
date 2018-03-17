/** Base class for ModifyCol_vgui and ModifyRow_vgui

*/
Class Modify_vgui {

	_hwnd	:= {"gui":"", "list_view":""}
	_options 	:= {}

	/** hwnd
	*/
	hwnd($_GUI, $list_view){
		;MsgBox,262144,gui, %$_GUI%,3
		this._hwnd.gui	:= $_GUI
		this._hwnd.list_view	:= $list_view
		return this
	}
	/*-----------------------------------------
		OPTIONS
	-----------------------------------------
	*/
	/** _setOptions
		A) _setOptions()	; Run modify all rows\columns by this._options
		B) _setOptions("Auto")	; Modify all rows\columns by value
		C) _setOptions(1, "Auto")	; Modify rows\columns 1 with value
		D) _setOptions([1,3], "Auto")	; Modify rows\columns 1 & 3 with value
		E) _setOptions({1:64, 3:"Auto"})	; modify exact rows\columns with their values
	*/
	_setOptions($param1, $param2:=""){
		$isObject := isObject($param1)

		if( !$isObject && !$param2)                     ; example B
			this._optionToAll($param1)
		 else if( $param1 is number || $param1==0 && $param2)         ; example C
			this._addOption($param1, $param2)
		 else if( $isObject && $param2!="")             ; example D
			this._addOptionToColumns($param1, $param2)
		else if( $isObject && $param2=="" )             ; example E
			this._addOptionsObject($param1)

		;Dump(this._options, "this._options", 1)

	}

	/** Add Option To All rows_cols
	*/
	_optionToAll($option){
		;MsgBox,262144,, % "_optionToAll: " $option,2
		;this._activateListView()
		if(this._modify_row_column == "column")
			loop, % this.count()
				this._addOption(A_Index, $option)
		else
			this._addOption(0, $option)
	}
	/** Add Option To All rows_cols
	*/
	_addOptionToColumns($rows_cols, $option){
		;MsgBox,262144,, _addOptionToColumns,2
		For $i, $row_col in % $rows_cols
			this._addOption($row_col, $option)
	}
	/** Set options for rows_cols
	*/
	_addOptionsObject($options){
		;MsgBox,262144,, _addOptionsObject,2
		For $row_col, $option In % $options
			this._addOption($row_col, $option)
	}
	/** _addOption
	*/
	_addOption($row_col, $option){
		this._options[$row_col] := this._options[$row_col] ? this._options[$row_col] " " $option : $option
	}

	/*-----------------------------------------
		LISTVIEW EXIST|ACTIVATE|COUNT
	-----------------------------------------
	*/
	/** Activate ListView for manipulation
	*/
	_activateListView(){
		if(this._listViewExists()) {  ; If list view already exists
			Gui, % this._hwnd.gui ":Default"
			Gui, % this._hwnd.gui ":ListView", % this._hwnd.list_view
			return true
		}
		return false
	}
	/** _listViewExists
	*/
	_listViewExists(){
		return this._hwnd.list_view ? 1 : 0
	}
	/** Set\Get count of row or columns
		Set count on on ListView creation
		Get count of current rows\columns if ListView exist, otherwise return this._count

		@return integer
	*/
	count($count:=""){
		if(!$count)
			return % this._listViewExists() ? LV_GetCount(this._modify_row_column) : this._count

		this._count := $count
		return this
	}


}
