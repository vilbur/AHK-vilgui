/** Modify rows

*/
Class ModifyRow_vgui extends Modify_vgui{

	_modify_row_column := ""

	/**  modify HELP: https://autohotkey.com/docs/commands/ListView.htm#bifCol
		A) modify()	; Run modify all columns by this._options
		B) modify("Auto")	; Modify all columns by value
		C) modify(1, "Auto")	; Modify columns 1 with value
		D) modify([1,3], "Auto")	; Modify columns 1 & 3 with value
		E) modify({1:64, 3:"Auto"})	; modify exact columns with their values
	*/
	modify($param1:="", $param2:=""){
		this._setOptions($param1, $param2)
		;Dump(this._options, "modify()._options", 1)

		;Dump(this._activateListView(), "this._activateListView()", 1)
		;Dump(this, "this.", 1)

		if(this._activateListView()) ; If list view already exists
			For $row, $options in % this._options
				this._applyModify($row, $options)

	}
	/** get array of values in cell of row
	  @return array
	*/
	value($row_num){
		;return "SHITA"
		$values:=[]
		loop, %  LV_GetCount("Column") {
			 LV_GetText( $row_content,  $row_num, A_Index )
			$values.push( $row_content)
			;return "SHITB"
			;$values.push( A_Index)
		}
		return %$values%
	}
	/*-----------------------------------------
		PRIVATE
	-----------------------------------------
	*/
	/** _applyModify
	*/
	_applyModify($row, $options){
		;MsgBox,262144,, % "_applyModify`n " $row ": " $options,2

		if($options)
			LV_Modify($row, $options)
		;GuiControl, +Redraw, % this._hwnd.list_view
	}

}
