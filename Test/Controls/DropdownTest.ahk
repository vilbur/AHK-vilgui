/** Class DropdownTest
*/
Class DropdownTest{

	runMainTest(){
		$arr_item_empty	:= [ "", "List with empty item",	"Foo value", "Bar value"]
		$arr_item_selected	:= [ "Item selected|",	"Foo value", "Bar value"]
		$arr_nothing_selected	:= [ "Nothing selected",	"Foo value", "Bar value"]
		$GuiTest.Controls
			.GroupBox("Dropdown Test").layout("row").add()
				.Dropdown().items("String Items||Foo value|Bar value").callback("callbackTest", "Param").add()
				.Dropdown().items($arr_item_selected).add()
				.Dropdown().items($arr_nothing_selected).add()
				.Dropdown().items($arr_item_empty).add()
	}

}
