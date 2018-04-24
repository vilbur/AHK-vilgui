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
$find	:= $ListBox.find("Item")
$find_exact	:= $ListBox.findExact("Item B")
$count	:= $ListBox.GetCount()
$current_sel	:= $ListBox.GetCurrentSel()
$get_data	:= $ListBox.GetData(1)
$focused_item	:= $ListBox.GetFocus()
$item_height	:= $ListBox.GetItemHeight()
$select_count	:= $ListBox.GetSelCount()
$sel_items	:= $ListBox.GetSelItems(2)
$sel_start	:= $ListBox.GetSelStart()
$sel_state	:= $ListBox.GetSelState(4)
$item_text	:= $ListBox.GetText(4)
$text_length	:= $ListBox.GetTextLen(4)
$top_index	:= $ListBox.GetTopIndex()
$item_from_point	:= $ListBox.ItemFromPoint(0,24)


;Dump($find, "find", 1)
;Dump($find_exact, "find_exact", 1)
;Dump($count, "count", 1)
;Dump($current_sel, "current_sel", 1)
;Dump($get_data, "get_data", 1)
;Dump($focused_item, "focused_item", 1)
;Dump($item_height, "item_height", 1)
;Dump($select_count, "select_count", 1)
;Dump($sel_items, "sel_items", 1)
;Dump($sel_start, "sel_start", 1)
;Dump($sel_state, "sel_state", 1)
;Dump($item_text, "item_text", 1)
;Dump($text_length, "text_length", 1)
;Dump($top_index, "top_index", 1)
;Dump($item_from_point, "item_from_point", 1)

#Include %A_LineFile%\..\..\..\..\..\..\..\Gui\Test\gui-setup\gui-create.ahk
  