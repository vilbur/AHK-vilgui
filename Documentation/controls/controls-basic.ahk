#SingleInstance force
#Include %A_LineFile%\..\..\..\VilGUIv3.ahk

/* GUI
*/
$Gui := new VilGUIv3("BasicControls")

/* Button
*/
$Gui.Controls
	.Button().label("Label of Button", "w128").add()
	.Button().add("Button 2")
	.Button().value("Button Text").add("Button 3")
	.Button().callback("callbackFN", "Paramater 1", "Paramater 2").add("Callback Button")

/* Edit
*/
$Gui.Controls
	.Edit().label("Label of Edit", "w128").add()
	.Edit().value("Edit Text").add()
	.Edit().value("Callback").callback("callbackFN", "Paramater 1", "Paramater 2").add("Callback Edit") ; BUG: on write event has type "leftclick"

/* Text
*/
$Gui.Controls
	.Text().add()
	.Text().value("Foo Text").add()


/* Checkbox
*/
$Gui.Controls
	.Checkbox().label("Label of Checkbox", "w128").add()
	.Checkbox().value("Checkbox Text").add()
	.Checkbox().callback("callbackFN", "Paramater 1", "Paramater 2").add("Callback Checkbox") ; TODO: Send value with event

/* Show GUI
*/
$Gui.Gui.show()

/** Callback
*/
callbackFN($Event, $params*){
	$Event.message(100)
	MsgBox,262144,, % $params[1] "`n" $params[2] "`n" $params[3],5
}