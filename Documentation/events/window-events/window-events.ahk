#SingleInstance force
#Include %A_LineFile%\..\..\..\gui\lib\gui-construct.ahk


$Gui.Events.Window
	.bind("created",	"callbackWindow", "On created")
	.bind("change",	"callbackWindow", "On change")	
	.bind("focus",	"callbackWindow", "On focus")
	.bind("blur",	"callbackWindow", "On blur")
	
/** callbackWindow
*/
callbackWindow($Event:="", $params*)
{
	$Event.message()
}


#Include %A_LineFile%\..\..\..\gui\lib\gui-create.ahk 