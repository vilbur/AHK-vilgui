#SingleInstance force
#Include %A_LineFile%\..\..\..\gui\lib\gui-construct.ahk
/* Controls
*/
$Gui.Controls
	.Button()
		.value("Callback Button")
		.callback("onButtonClick")
		.add()
		
	.Edit()
		.value("New Buton Text")
		.add()
		
	.Text()
		.value("Button pos y")
		.add("Text1")
		
	.Checkbox()
		.add()

/** Callback
*/
onButtonClick($Event, $params*){

	$Gui.gui("Font", " cBlue bold italic")
	$Edit := $Gui.Controls.get("Edit1")
	$Text := $Gui.Controls.get("Text1")
	
	$Edit.guiControl("Hide")

	$Event.control()
		.size("", 44)
		.pos("", 15)		
		.edit($Edit.value())
		.guiControl("Disable")			
		
	$Text.edit( $Text.value() " " $Event.control().pos().y)
		.guiControl("Font")
			
	$Gui.Controls.get("Checkbox1")
		.edit(true)
}
#Include %A_LineFile%\..\..\..\gui\lib\gui-create.ahk