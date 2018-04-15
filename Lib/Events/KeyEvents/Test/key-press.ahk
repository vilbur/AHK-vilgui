#SingleInstance force
#Include %A_LineFile%\..\..\..\gui\lib\gui-construct.ahk

$Gui.Events.Key
	.onEscape("callbackKeyPress", "onEscape" ) 
	.onEscape("close")
	
	.onEnter("callbackKeyPress", "onEnter" ) 
	.onEnter("close")
	
	.on("number", "callbackKeyPress" ) 	; NOTE: "number" is for numbers 0-9

	.on("Space", "callbackKeyPress" )                        ; modifiers are passed to $Event object
	.on( ["control", "shift", "space"], "callbackKeyPress" ) ; event is called only if modifier keys are pressed
	.on( ["control", "lwin",  "X"], "callbackKeyPress" )	


/** callbackKeyPress
*/
callbackKeyPress($Event:="", $params*)
{
	$Event.message()
}


#Include %A_LineFile%\..\..\..\gui\lib\gui-create.ahk