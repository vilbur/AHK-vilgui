/** ListViewTest
*/
Class ListViewTest{


	runMainTest(){
		this.createListView()
		this.addDataToExistingList(5)
		; this.modifyCols()
		; this.modifyRows()
		; this.addMenuDefaults()
		;this.createCustomEventMenu()
		;this.addItemToExistingMenu()
	}
	/** createListView
	*/
	createListView(){
		$GuiTest.Controls.GroupBox().layout("column").add("List View Test Box")
		this.ListView := this.getListView().add("ListViewTest").get()
	}
	/** addDataToExistingList
	*/
	getListView(){
		return % $GuiTest.Controls.ListView()
						.columns(["Column A", "Column B", "Column C"])
						.options("w720 h256")
						.checkbox()
						; .callback("listViewCallback","Callback for all events")
						;.on("FocusEnd", "listViewCallback", "Focus End")
						;.on("KeyPress", "listViewCallback", "KeyPress")
						; .on("DoubleClick", "listViewCallback","Double Click")
						.on("Remove", &this ".onRemove", "test")
						.on("Add", &this ".onAdd", "test" )
						;.on("Remove", "listViewCallback" )
						.modifyCol("Auto")	; Modify all columns by value
						; .modifyCol(64)	; Modify all columns by value
						; .modifyCol(1,32)	; Modify columns 1 with value
						; .modifyCol([1,2],64)	; Modify column s 1 & 2 with value
						; .modifyCol({2:128})	; modify exact columns with their values
						.modify( 1, "Check")
						.data(this._getRowData(1))
	}
	/** addDataToExistingList
	*/
	addDataToExistingList($row_num:=1){
		this.ListView.addData(this._getRowData($row_num, 2), "-Check")
	}
	/** modifyCols
	*/
	modifyCols(){
		; this.ListView.modifyCol( 0, "-Check")
		; this.ListView.modifyCol( 3, "-Check")
		this.ListView.modifyCol( "AutoHdr")
	}
	/** modifyRows
	*/
	modifyRows(){
		this.ListView.modify( "-Check")     ; uncheck all row
		; this.ListView.modify( 0, "-Check") ; uncheck all row
		this.ListView.modify( [3,4], "Check")
		this.ListView.modify( 5, "Check")
	}
	/** addMenuDefaults
	*/
	addMenuDefaults(){
		this.ListView.Menu
			.defaults("Custom Default",	"listViewCallback")
			.defaults("Set Columns Widths", "listViewChangeWidths")
	}
	/** createCustomEventMenu
	*/
	createCustomEventMenu(){
		this.ListView.Menu
					.menu("ColClick")
						.item("Set Columns Widths")
						.item("Callback Test", "listViewCallback")
	}

	/** addItemToExistingMenu
	*/
	addItemToExistingMenu(){
		this.ListView.Menu.RightClick
							.item("Set Columns Widths")
							.item("Custom Default")
	}
	/** onRemove
	*/
	onRemove($Event:=""){
		$Event.message(10)
	}
	/** onAdd
	*/
	onAdd($Event:=""){
		MsgBox,262144,, onAdd,2
		$Event.message(10)
	}
	/** _getRowData
	*/
	_getRowData($row_num:=1, $start:=0){
		$rows	:= []
		$add	:= $start?$start-1 :0
		loop, % $row_num
			$rows.push( ["Row " A_Index +$add,"Lorem ipsum luctus habitasse eleifend diam turpis duis","sodales urna feugiat platea conubia volutpat"])
			; $rows.push( ["Row " A_Index +$add,"Lorem","sodales"])
		return %$rows%
	}


}


/*-----------------------------------------
	CALLBACKS
-----------------------------------------
*/
/** listViewChangeWidths
*/
listViewChangeWidths($Event:=""){
	;MsgBox,262144,, listViewChangeWidths,2

	$ListView	:= $GuiTest.Controls.get("ListViewTest")

	$ListView.modifyCol(2, 256)
	sleep,2000
	$ListView.modifyCol( 128 )
	sleep,2000
	$ListView.modifyCol( {1:64, 3:32} )
	sleep,2000
	$ListView.modifyCol( [64,"Auto",256] )
	sleep,2000
	;$ListView.modifyCol().fitColumns()
}
/** listViewCallback
	$event.types = "LeftClick|RightClick|DoubleClick|DoubleClickRight|Drag|Activated|Edit|MouseRelease|Focus|ItemChanged|KeyPress|Selection|Scroll"
*/
listViewCallback($Event:="", $params*){
	;Dump($Event, "Event", 1)
	if(!$Event)
		MsgBox,262144,, listViewCallback,2
	else
		$Event.message()

}