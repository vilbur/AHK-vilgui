#SingleInstance force
#Include %A_LineFile%\..\..\..\gui\lib\gui-construct.ahk


$Gui.Events.Window
	;.bind("created",	"callbackWindow", "On created")
	;.bind("close",	"callbackWindow", "On close")	
	;.bind("focus",	"callbackWindow", "On focus")
	;.bind("blur",	"callbackWindow", "On blur")
	
	;.bind("size",	"callbackWindow", "On size")
	;.bind("move",	"callbackWindow", "On move")		
	.bind("sizedmoved",	"callbackWindow", "On sizedmoved")	
	

/** callbackWindow
*/
callbackWindow($Event:="", $params*)
{
	$Event.message()
}


#Include %A_LineFile%\..\..\..\gui\lib\gui-create.ahk


