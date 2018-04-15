#SingleInstance force
#Include %A_LineFile%\..\..\..\..\Gui\Test\gui-setup\gui-construct.ahk
	
/* EVENT BUTTONS
*/	
;$Gui.Events.Mouse

/** callbackGui
*/
callbackMouse($Event:="", $params*)
{
	;MsgBox,262144,callbackGui, % $params[1] "`n" $params[2] "`n" $params[3],5
	$Event.message()
}

#Include %A_LineFile%\..\..\..\..\Gui\Test\gui-setup\gui-create.ahk