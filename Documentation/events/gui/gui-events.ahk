#SingleInstance force
#Include %A_LineFile%\..\..\..\gui\gui-construct.ahk

$Gui.Controls.layout("row")
	.Edit().value("Lorem ipsum").label("Test Input").add().section()
	.GroupBox().layout("row").add("Event Buttons")

	; EVENT BUTTONS
	.Button().submit()
	.Button().close()
	.Button().exit()			
	
$Gui.Events.Gui
	.onEscape("callbackGui", "onEscape", "Custom") ; 1) Call this function on Escape pressed
	.onEscape("close")                                  ; 2) Then close gui window
	
	.onSubmit("callbackGui", "onSubmit", "Custom") ; 1) Call this function on onSubmit pressed
	.onSubmit("close")                               ; 2) then exit script
	
	.onClose("callbackGui", "onClose", "Custom")	; 1) Call this function on window closed
	.onClose("exit")                                         

	.onExit("callbackGui", "onExit", "Custom")	; 1) Call this function on exiting script
	;.onExit(false)	; remove callbacks

/** callbackGui
*/
callbackGui($Event:="", $params*){
	MsgBox,262144,callbackGui, % $params[1] "`n" $params[2] "`n" $params[3],5
	$Event.message()
}

#Include %A_LineFile%\..\..\..\gui\gui-create.ahk 