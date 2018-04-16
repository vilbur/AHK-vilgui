#SingleInstance force
#Include %A_LineFile%\..\..\..\Gui\Test\gui-setup\gui-construct.ahk
/* DEFINE COLORS
*/
$Gui.Style.Color
	.focus( "00FF00", "FF0080")
	.focus( "024FC0", "FFFFFF", "listbox")

/* ADD CONTROLS
*/
$items := ["item A|", "item B", "item C"]

$Gui.Controls
	.Dropdown().items($items).add()	
	.Radio().items($items).add()
	.ListBox().items($items).add()

#Include %A_LineFile%\..\..\..\Gui\Test\gui-setup\gui-create.ahk