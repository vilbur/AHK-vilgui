#SingleInstance force
#Include %A_LineFile%\..\..\..\..\..\Gui\Test\gui-setup\gui-construct.ahk
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
		.items($items["1_string"]) ; checked by pipe "||"
		.tooltip( "Dropdown" )
		.add()
		
	/* Radio
	*/
	.Radio()
		.items($items["2_array"])
		.checked(3) ; checked by array index
		.tooltip( "Tooltip Radio" )
		.add()
		
	/* ListBox
	*/
	.ListBox()
		.items($items["3_object"])
		.checked("key2") ; checked by object key
		.add()
		
#Include %A_LineFile%\..\..\..\..\..\Gui\Test\gui-setup\gui-create.ahk
