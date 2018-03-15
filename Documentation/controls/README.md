### Basic controls


``` php
/* GUI setup 1
*/
$GuiTest := new VilGUIv3("GuiTest_2")

/* Button
*/
$GuiTest.Controls
			.Button().label("Label of Button").add()
			.Button().add("Button 2")
			.Button().value("Button Text").add("Button 3")
			.Button().callback("callbackFN", "Paramater 1", "Paramater 2").add("Callback Button")

/* Edit
*/
$GuiTest.Controls
			.Edit().label("Label of Edit").add()
			.Edit().value("Edit Text").add()
			.Edit().callback("callbackFN", "Paramater 1", "Paramater 2").add("Callback Edit") ; BUG: on write event has type "leftclick"

/* Text
*/
$GuiTest.Controls
			.Text().add()
			.Text().value("Foo Text").add()


/* Checkbox
*/
$GuiTest.Controls
			.Checkbox().label("Label of Checkbox").add()
			.Checkbox().value("Checkbox Text").add()
			.Checkbox().callback("callbackFN", "Paramater 1", "Paramater 2").add("Callback Checkbox") ; TODO: Send value with event

/* Show GUI
*/
$GuiTest.Gui.show()

/** Callback
*/
callbackFN($Event, $params*){
	$Event.message(100)
	MsgBox,262144,, % $params[1] "`n" $params[2] "`n" $params[3],5
}
```

![alt text](https://github.com/vilbur/ahk-vilgui/blob/master/Documentation/controls/controls-basic.jpeg?raw=true "Basic controls")
