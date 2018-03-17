#SingleInstance force
#Include %A_LineFile%\..\..\..\..\VilGUIv3.ahk

/* GUI
*/
$Gui := new VilGUIv3("ItemTypeControls")

/* Items for controls
*/

$items := {"1_string":               "String A selected||String B|String C"
          ,"2_array":                ["Array item A|", "Array item B", "Array item C"]
          ,"3_object":               {"key1":"item A", "key2":"item B", "key3":"item C"}
          ,"4_empty_item_multi_sel": [ "", "List with empty item|",	"Foo selected", "Bar"]
          ,"5_nothing_selected":     [ "1 nothing selected", "2", "3"]}


$Gui.Controls

	/* Dropdown
	*/
	.Dropdown()
		.items($items["1_string"])
		.add()
		
	/* Radio
	*/
	.Radio()
		.items($items["2_array"])
		.checked(3)			
		.add()
		
	/* ListBox
	*/
	.ListBox()
		.items($items["3_object"])
		.checked("key2")
		.add()

/* Show GUI
*/
$Gui.Gui.show()