/** Class RadioTest
*/
Class RadioTest{

	runMainTest(){
		MsgBox,262144,, Test,2  
		$GuiTest.Controls
			.GroupBox().layout("column").add("GUI_Radio")
			;this.itemsString()
			;this.itemsArray()
			;this.itemsObject()
	}
	/** itemsString
	*/
	itemsString(){
		$GuiTest.Controls.Radio().items("String A||String B|String C").add("RadioString")
		.section()
		$GuiTest.Controls.Radio().items("String check A|String check B|String check C").checked("String check B").add("RadioString")
		.section()
	}
	/** itemsArray
	*/
	itemsArray(){
		$GuiTest.Controls.Radio().items(["Array item A", "Array item B", "Array item C"]).checked(3).add("RadioArray")
		.section()
	}
	/** itemsObject
	*/
	itemsObject(){
		$GuiTest.Controls.Radio().items({"objKey1":"Obj item A", "objKey2":"Obj item B", "objKey3":"Obj item C"}).checked("objKey3").add("RadioObj1")
		; .section()
	}


}
