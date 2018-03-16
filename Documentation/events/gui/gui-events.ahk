#SingleInstance force
#Include %A_LineFile%\..\..\..\..\VilGUIv3.ahk

/* GUI setup 1
*/
$GuiEvents := new VilGUIv3("GuiEvents")

	$GuiEvents.Controls.layout("row")
		.Edit().value("Lorem ipsum").label("Test Input").add().section()
		.GroupBox().layout("row").add("Event Buttons")

		; EVENT BUTTONS
		.Button().submit()
		.Button().close()
		.Button().exit()			
		
	$GuiEvents.Events.Gui
		.onEscape("callbackFunction", "onEscape", "Custom") ; 1) Call this function on Escape pressed
		.onEscape("close")                                  ; 2) Then close gui window
		
		.onSubmit("callbackFunction", "onSubmit", "Custom") ; 1) Call this function on onSubmit pressed
		.onSubmit("close")                               ; 2) then exit script
		
		.onClose("callbackFunction", "onClose", "Custom")	; 1) Call this function on window closed
		.onClose("exit")                                         

		.onExit("callbackFunction", "onExit", "Custom")	; 1) Call this function on exiting script
		;.onExit(false)	; remove callbacks

$GuiEvents.show()


/** callbackFunction
*/
callbackFunction($Event:="", $params*){
	MsgBox,262144,callbackFunction, % $params[1] "`n" $params[2] "`n" $params[3],5
	$Event.message()
}