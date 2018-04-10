#SingleInstance force
#Include %A_LineFile%\..\..\..\gui\lib\gui-construct.ahk

$Gui.Controls.layout("row")
	.Edit().value("Lorem ipsum").label("Test Input").add().section()
	.GroupBox().layout("row").add("Event Buttons")

	; EVENT BUTTONS
	.Button().submit()
	.Button().close()
	.Button().exit()			
	
$Gui.Events.Gui

	.onSubmit("callbackGui", "onSubmit param", "Custom") 
	.onSubmit("close")
	
	.onClose("callbackGui", "onClose param", "Custom")	
	.onClose("exit")

	.onExit("callbackGui", "onExit param", "Custom")	
	;.onExit(false) ; remove callbacks

/** callbackGui
*/
callbackGui($Event:="", $params*){
	MsgBox,262144,callbackGui, % $params[1] "`n" $params[2] "`n" $params[3],5
	$Event.message()
}

#Include %A_LineFile%\..\..\..\gui\lib\gui-create.ahk 