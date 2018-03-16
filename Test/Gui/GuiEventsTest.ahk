/** Class GuiEventsTest
*/
Class GuiEventsTest{

	runMainTest(){
		this.addGuiEvent()
		this.CotrolsEvents()
		; 2) then exit script
	}
	/** addGuiEvent
	*/
	addGuiEvent(){
		$GuiEvents.Events.Gui
			.escape("guiEventTest", "On escape event", "Gui will be destroyed")	; 1) Call this function on Escape pressed
			.escape("close")	; 2) then Destroy guiw on Escape pressed
	
			$GuiEvents.Events.Gui
				.submit("submitGuiCallbackTest", "EVENT", "BY", "GUI")	; 1) Call this function on submit pressed
				.submit("close")                         ; 2) then close gui on Escape pressed
				
			 $GuiEvents.Events.Gui
				 .close("guiEventTest", "On close event", "Script will exit")	; 1) Call this function on window closed
				 .close("exit")    	
	}
	/** CotrolsEvents
	*/
	CotrolsEvents(){
		$GuiEvents.Controls.Edit("TEST").on("keyPress","guiEventTest").add()
		;$GuiEvents.Controls.Edit("mouse Left Click").on("mouseLeftClick","guiEventTest").add()
		$GuiEvents.Controls.Edit("mouse Left Click").on("mouseActivate","guiEventTest").add()
		;$GuiEvents.Controls.Edit("mouse Left Click").on("mouseWheel","guiEventTest").add()
	}

}


/** guiEventTest
*/
guiEventTest($Event:="", $params*){
	 MsgBox,262144,, guiEventTest,2
	$Event.message()
	;MsgBox,262144,, % $params[1] "`n" $params[2] "`n" $params[3],5
}
/** buttonCallbackTest
*/
submitGuiCallbackTest($Event, $params*){
	 MsgBox,262144,, submitGuiCallbackTest,2
	$Event.message()
	MsgBox,262144,, % $params[1] "`n" $params[2] "`n" $params[3],5
}