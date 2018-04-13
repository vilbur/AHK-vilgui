/** Class ListView_vgui
	Forum GuiListViewEx: https://autohotkey.com/board/topic/80686-class-guilistviewex-added-functions-for-gui-listviews/
*/
Class ListViewEvents_vgui extends ControlItems_vgui
{
	/*-------------------------------------------------------------------------------------------------------------------------------
		EVENTS - These methods fires events, it allows custom function after operation, E.G: Do something after row was removed
	---------------------------------------------------------------------------------------------------------------------------------
	*/
	/** removeRow
	*/
	removeRow()
	{
		$rows	:= this._arrayReverse( this._getCheckedOrFocusedRows())
		;Dump($rows, "rows", 1)
		For $i, $row_num in $rows
			LV_Delete($row_num)

		;Dump(this.Event, "this.Event", 0)
		;;sleep,10000
		this.Event.callEventCallback("Remove", {"rows": $rows})
	}
	/** addRow
	*/
	addRow()
	{
		;MsgBox,262144,, addRow,2
		this.Event.callEventCallback("Add", this._items.array)
		;this.addData($data)
	}
	/*---------------------------------------
		EVENTS METHODS
	-----------------------------------------
	*/
	/** Event Default is fired before all custom events
		@return object event data for custom event
	*/
	_eventDefault()
	{
		;MsgBox,262144,, _eventDefault,2
		this._showEventMenu()
		return %	{"row":	A_GuiEvent=="ColClick" ? 0 : LV_GetNext("F")
			,"checked":	this.isChecked()}
	}
	/** Show Menu on Event
	*/
	_showEventMenu()
	{
		$event_type := this.Event._getEventType()

		if(this.Menu[$event_type])
			this.Menu[$event_type].show()
	}
	/*---------------------------------------
		PRIVATE EVENTS METHODS
	-----------------------------------------
	*/
	/** Get Checked Or Focused Rows
	*/
	_getCheckedOrFocusedRows()
	{
		this._activateListView()
		$rows	:= []
		$row_num	:= 0 ; This causes the first loop iteration to start the search at the top of the list.
		$CF	:= this._checkbox && LV_GetNext(0, "C") ? "C" : "" ; work on checked, if any row is checked, otherwise work on focused rows
		;MsgBox,262144,%$CF%, %  LV_GetNext(0, "C"),3
		While, $row_num := LV_GetNext($row_num, $CF)
			$rows.push($row_num)
		return %$rows%
	}
	/*
	*/
	_arrayReverse($array)
	{
		$array_reversed := Array()
		Loop, % $len:=$array.MaxIndex()
			$array_reversed[$len-(A_Index-1)] := $array[A_Index]
		return %$array_reversed%
	}
}

global $addRowDialog
/** addRowDialog
*/
class addRowDialog{

	dialog := ""
	/** createGui
	*/
	createDialog($Event){
		$addRowDialog	:= this
		this.Event	:= $Event
		this.list_view	:= $Event.control()
		;Dump(this._Control, "this._Control", 1)
		this.dialog := new VilGUI("addRow")
		this.dialog.Events.Gui.submit("close")
		this.addControls()
		this.dialog.gui.show().alwaysOnTop()
	}
	/** add Edit input with label for each column
	*/
	addControls(){
		this.dialog.controls.Groupbox().layout("row").add("New row data")

		For $c, $column in this.Event.data
			this.dialog.controls.edit().label($column).options("w256").add($column).section()
		this.dialog.controls.button().callback(&$addRowDialog ".addData").submit()
	}

	/** add Data from dialog to list view
	*/
	addData($Event){
		;this.dialog.close()
		this.list_view.addData($Event.data)
	}

}
/**
  */
createAddRowDialog($Event){
		;$Event.message()
	new addRowDialog().createDialog($Event)
}
