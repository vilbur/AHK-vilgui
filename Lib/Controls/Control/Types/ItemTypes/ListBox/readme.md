 # ListBox  ### Listbox use [LBEX](https://github.com/AHK-just-me/LBEX) library  * All methods from LBEX library are accessible with Listbox control  * All methods share same parameters __EXCEPT__ HLB parameter - hwnd of control is not needed  ## Methods  | __Add__( ByRef $String, $String )    |Adds a string to a list box.    |  |:---    |:---    |  |`@param string` ByRef $String    |    |  |`@param String` $String    |item for adding    |  |`@return Control`    |    |  ##  | __CalcIdealWidth__( [Content], [Delimiter], [FontOptions], [FontName] )    |Calculates the ideal width of a list box needed to display the current content.    |  |:---    |:---    |  |`@param string` Content    |    |  |`@param string` [ Delimiter="|" ]    |    |  |`@param string` FontOptions    |    |  |`@param string` FontName    |    |  |`@return string`    |    |  ##  ## Examples  
``` php
$ListBox := $Gui.Controls.ListBox( "A|B|C" )							.checked( [2,3] )							.options("w256 Multi")							.add("ListBoxTest_1")							.get()/* Setters*/$ListBox	.delete(1)	.deleteAll()		.add("Item A|Item B")	.add(["Item D", "Item E"])	.insert(3, "Item C")	.setSel(2)	.selectString("Item A")	.selectRange(3,4)	.setCurSel(3)	.setFocus(3)	.setItemData(1, 123456789)	.setItemHeight(1, 24)	.setTopIndex(3)	/* Getters*/$find	:= $ListBox.find("Item")$find_exact	:= $ListBox.findExact("Item B")$count	:= $ListBox.GetCount()$current_sel	:= $ListBox.GetCurrentSel()$get_data	:= $ListBox.GetData(1)$focused_item	:= $ListBox.GetFocus()$item_height	:= $ListBox.GetItemHeight()$select_count	:= $ListBox.GetSelCount()$sel_items	:= $ListBox.GetSelItems(2)$sel_start	:= $ListBox.GetSelStart()$sel_state	:= $ListBox.GetSelState(4)$item_text	:= $ListBox.GetText(4)$text_length	:= $ListBox.GetTextLen(4)$top_index	:= $ListBox.GetTopIndex()$item_from_point	:= $ListBox.ItemFromPoint(0,24)








  
```    