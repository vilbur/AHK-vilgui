

/** Class controlDelete
*/
Class controlDelete{
	
	__New($new_section:=""){
		this.new_section := $new_section
	}
	
	runMainTest(){
		
		$GuiTest.Controls.layout("row")
			.Button().callback("dumpGui").add("Dump Gui" )
			.Button().callback("deleteControlTest").add("Delete GroupBox")
			.section()
		
		$GuiTest.Controls
			.GroupBox("GrouBoxForDeletion").add("GrouBoxForDeletion")
				.Button().callback("deleteTabs").add("deleteTabs")

		;Loop, 1 {
		;	$Tabs := $GuiTest.Tabs("Tabs " A_Index " - A|   B|   C").add("Tabs" A_Index).get()
		;	Loop, 2 {
		;		
		;		$Tabs.Tabs[A_Index].Controls
		;			.Button().callback("deleteAllControlsInTab").add("deleteAllControlsInTab1" )
		;			.Button().callback("deleteAllControlsInTab").add("deleteAllControlsInTab2" )					
		;
		;		.GroupBox().layout($tabs_layouts[A_Index]).add("GroupBoxTabs " A_Index )
		;		   .Button().callback("deleteSelf").add("btnDeleteSelf")
		;		   .Button().callback("deleteSelf").add("btnDeleteSelf")
		;		.GroupBox().layout($tabs_layouts[A_Index]).add("GroupBoxTabs " A_Index )
		;		   .Button().callback("deleteSelf").add("btnDeleteSelf")
		;		   .Button().callback("deleteSelf").add("btnDeleteSelf")		
		;	}
		;}
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
	$GuiTest.controls.get("GrouBoxForDeletion").delete()
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
/*
*/
deleteAllControlsInTab($Event:=""){
	;$Event.message()
	;$Event.Control().delete()
	$tab := $GuiTest.controls.get("Tabs1").getActive()
	
	
	$tab.Controls._Layout.ContainerMain.deleteSectionsFromContainer()
	
	$tab.Controls
		;.GroupBox().add("New Groupbox " A_Index )
			.Button().callback("dumpGui").add("Dump Gui" )
		;.Button().callback("deleteAllControlsInTab").add("new button" )
		
	$GuiTest._sortLayouts()
	
	;Dump($GuiTest, "$GuiTest", 0)
	;Dump($tab.Controls._Layout.ContainerMain, "tab.Controls._Layout.ContainerMain", 0)
	
	;Dump($tab, "tab", 1)
	;MsgBox,262144,active, %$active%,3
	;Dump($GuiTest, "$GuiTest", 0)

}
/**
 */
dumpGui($Event)
{
	Dump($GuiTest.Controls._Layout.ContainerMain, "$GuiTest.Controls._Layout.ContainerMain", 0)
}








