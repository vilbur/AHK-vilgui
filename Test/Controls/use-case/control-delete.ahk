

/** Class controlDelete
*/
Class controlDelete{
	
	__New($new_section:=""){
		this.new_section := $new_section
	}
	
	runMainTest(){
		
		$GuiTest.Controls.Button().callback("deleteControlTest").add("deleteGroupBox")
		
		$GuiTest.Controls
			.GroupBox("GroupBoxControl").add("testGroupBox")
				.Button().callback("deleteTabs").add("deleteTabs")

		Loop, 1 {
			$Tabs := $GuiTest.Tabs("Tabs " A_Index " - A|   B|   C").add("Tabs" A_Index).get()
			Loop, 2 {
				
				$Tabs.Tabs[A_Index].Controls
				.Button().callback("deleteSelf").add("deleteSelf")
		
				.GroupBox().layout($tabs_layouts[A_Index]).add("GroupBoxTabs " A_Index )
				   .Button().callback("deleteSelf").add("deleteSelf")
			}
		}
	}
	/** selectNextTab
	*/
	selectNextTab($Event:=""){
		$Event.message()

		$Tabs := $GuiTest.CallbackTabs
		$Tabs.select( $Tabs.active()+1 )
	}


}
/*-----------------------------------------
	CALLBACKS
-----------------------------------------
*/

/** deleteControlTest
*/
deleteControlTest($Event:=""){

	$GuiTest.controls.get("testGroupBox").delete()
	;Dump($GuiTest.controls, "GuiTest.controls", 0)
	;Dump($GuiTest, "GuiTest", 0)	
	
}

/*
*/
deleteSelf($Event:=""){
	;$Event.message()
	$Event.Control().delete()
}
/*
*/
deleteTabs($Event:=""){
	;$Event.message()
	;$Event.Control().delete()
	$GuiTest.controls.get("Tabs1").delete()

}