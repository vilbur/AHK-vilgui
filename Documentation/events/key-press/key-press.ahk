#SingleInstance force
#Include %A_LineFile%\..\..\..\gui\lib\gui-construct.ahk

;$Gui.Controls.layout("row")
		
	
$Gui.Events.Key
	;.onEscape("callbackKeyPress", "onEscape param", "Custom") 
	;.onEscape("close")
	;
	;.onEnter("callbackKeyPress", "onEnter param", "Custom") 
	;.onEnter("close")
	;.onExit(false) ; remove callbacks

	.bind("Space", "callbackKeyPress", "on F1 param", "Custom") 

/** callbackKeyPress
*/
callbackKeyPress($Event:="", $params*)
{
	;MsgBox,262144,callbackKeyPress, % $params[1] "`n" $params[2] "`n" $params[3],5
	$Event.message()
	;MsgBox,262144,, callbackKeyPress,2 
	;Dump($Event, "Event", 1)
}

#Include %A_LineFile%\..\..\..\gui\lib\gui-create.ahk
