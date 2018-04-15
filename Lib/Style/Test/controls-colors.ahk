#SingleInstance force
#Include %A_LineFile%\..\..\..\gui\lib\gui-construct.ahk

/* DEFINE COLORS
*/
$Gui.Style.Color
	.focus( 0x00FF00, 0xFF0080)
	.focus( "024FC0", "FFFFFF", "listbox")

/* ADD CONTROLS
*/
$items := ["item A|", "item B", "item C"]

$Gui.Controls
	.Dropdown().items($items).add()	
	.Radio().items($items).add()
	.ListBox().items($items).add()
	
		
#Include %A_LineFile%\..\..\..\gui\lib\gui-create.ahk  