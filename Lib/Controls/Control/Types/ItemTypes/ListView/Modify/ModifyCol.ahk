/** Modify columns
*/
Class ModifyCol_vgui extends Modify_vgui {

	_modify_row_column := "column"


	/**  modify HELP: https://autohotkey.com/docs/commands/ListView.htm#bifCol
		A) modify()	; Run modify all columns by this._options
		B) modify("Auto")	; Modify all columns by value
		C) modify(1, "Auto")	; Modify columns 1 with value
		D) modify([1,3], "Auto")	; Modify columns 1 & 3 with value
		E) modify({1:64, 3:"Auto"})	; modify exact columns with their values
	*/
	modify($param1:="", $param2:=""){
		;this._activateListView()
		this._setOptions($param1, $param2)
		if(this._activateListView()) ; If list view already exists
			For $column, $options in % this._options
				this._applyModifyCol($column, $options)

		;Dump(this, "this.", 1)
		this.fitColumns()
	}
	/** fit Last Columns to width of list view
	*/
	fitColumns(){
		this._applyModifyCol(this._options.MaxIndex(), "AutoHdr")
	}

	/*-----------------------------------------
		PRIVATE
	-----------------------------------------
	*/
	/** _applyModifyCol
	*/
	_applyModifyCol($column, $options){
		;MsgBox,262144,, % "_applyModifyCol`n " $column ": " $options,2

		;Dump($options, $column, 1)
		if($options)
			LV_ModifyCol($column, $options)
	}



}
