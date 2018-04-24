#SingleInstance force
#Include %A_LineFile%\..\..\..\..\..\..\..\Gui\Test\gui-setup\gui-construct.ahk

$ListBox := $Gui.Controls.ListBox( "A|B|C" )
							.checked( [2,3] )
							.options("w256 Multi")
							.add("ListBoxTest_1")
							.get()
/* Setters
*/
$ListBox
	.delete(1)
	.deleteAll()	
	.add("Item A|Item B")
	.add(["Item D", "Item E"])
	.insert(3, "Item C")
	.setSel(2)
	.selectString("Item A")
	.selectRange(3,4)
	.setCurSel(3)
	.setFocus(3)
	.setItemData(1, 123456789)
	.setItemHeight(1, 24)
	.setTopIndex(3)
	
/* Getters
*/
$find         := $ListBox.find("Item")
$find_exact   := $ListBox.findExact("Item B")
$count        := $ListBox.GetCount()
$current_sel  := $ListBox.GetCurrentSel()
$get_data     := $ListBox.GetData(1)
$focused_item := $ListBox.GetFocus()
$item_height  := $ListBox.GetItemHeight()
$select_count := $ListBox.GetSelCount()
$sel_items    := $ListBox.GetSelItems(2)
$sel_start    := $ListBox.GetSelStart()
$sel_state    := $ListBox.GetSelState(4)
$item_text    := $ListBox.GetText(4) 