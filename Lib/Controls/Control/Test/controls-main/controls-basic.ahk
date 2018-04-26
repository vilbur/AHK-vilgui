#SingleInstance force
#Include %A_LineFile%\..\..\..\..\..\Gui\Test\gui-setup\gui-construct.ahk
/* Button
*/
$Gui.Controls
	.Button().add()
	.Button()
		.value("Callback Button")                             ; text of button
		.callback("callbackFnCtrs", "Paramater 1", "Paramater 2") ; callback function
		.options("w96 x+16")                                  ; set options to control 
		.add("Button 2")                                      ; add control with name "Button 2"

	/* Edit
	*/
	.Edit()
		.value("Edit Control")
		.options("x-16 y+32")
		.callback("callbackFnCtrs", "Paramater 1", "Paramater 2") ; BUG: on event has type "leftclick"
		.add()

	/* Text
	*/
	.Text()
		.options("border")
		.add("Bordered Text")
	.Text()
		.value("Bar Text")
		.add()

	/* Checkbox
	*/
	.Checkbox().add()
	.Checkbox()
		.value("Callback Checkbox").add()
		.callback("callbackFnCtrs", "Paramater 1", "Paramater 2")
		.add() ; TODO: Send value with event

/** Callback
*/
callbackFnCtrs($Event, $params*){
	$Event.message(100)
	MsgBox,262144,, % $params[1] "`n" $params[2] "`n" $params[3],5
}

#Include %A_LineFile%\..\..\..\..\..\Gui\Test\gui-setup\gui-create.ahk
