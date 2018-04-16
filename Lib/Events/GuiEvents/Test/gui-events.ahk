#SingleInstance force
#Include %A_LineFile%\..\..\..\..\Gui\Test\gui-setup\gui-construct.ahk

$Gui.Events.Gui
	.onSubmit("callbackGui", "onSubmit Custom") 
	.onSubmit("close")
	
	.onClose("callbackGui", "onClose Custom")	
	.onClose("exit")
	
	.onExit("confirmExit", "Exit script ?")	
	.onExit(false) ; remove callback

 
/** callbackGui
*/
callbackGui($Event:="", $params*)
{
	MsgBox,262144,callbackGui, % $params[1] "`n" $params[2] "`n" $params[3],5
	$Event.message()
}

/** onExit callback must return true to exit script
*/
confirmExit($Event:="", $params*)
{
	MsgBox, 262148,, % $params[1]
	IfMsgBox, Yes
		return true
}


#Include %A_LineFile%\..\..\..\..\Gui\Test\gui-setup\gui-create.ahk