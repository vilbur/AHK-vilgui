/** Class TabsTest
*/
Class TabsTest{
	__New($new_section:=""){
		this.new_section := $new_section
		
	}
	runMainTest(){
		
		$tabs_layouts := ["column","row"] ; layouts for each tabs
		if(this.new_section!="")
			$GuiTest.Controls.section()

		Loop, 1 {
			$Tabs := $GuiTest.Tabs("Tabs " A_Index " - A|   B|   C").add("Tabs" A_Index).get()
			Loop, 2 {

				 $Tabs.Tabs[A_Index].Controls
					 .GroupBox().layout($tabs_layouts[A_Index]).add("GroupBoxTabs " A_Index " A")
						.Button().callback("callbackTest", "Param").add("Test Callback")
						.Button().add()
					 .GroupBox().add("GroupBoxTabs1 B")
						.Edit().value("Tab 1 Edit").add()
						.Button().add()

			}
		}
	}
	/** selectNextTab
	*/
	selectNextTab($Event:=""){
		$Event.message()
		;MsgBox,262144,, selectNextTab,2
		$Tabs := $GuiTest.CallbackTabs
		$Tabs.select( $Tabs.active()+1 )
	}


}
/*-----------------------------------------
	CALLBACKS
-----------------------------------------
*/

/** callbackTest
*/
callbackTest($Event:="", $params*){
	;MsgBox,262144,, Test,2
	$Event.message()
	;$GuiTest.Menu.Context.show()
}

/*
*/
tabsCallback($Event:="", $params*){
	$Event.message()
	$Event.Control().highlight($Event.data.tab)


}