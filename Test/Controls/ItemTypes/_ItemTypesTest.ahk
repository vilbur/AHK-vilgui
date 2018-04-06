/** Global data for test of item types
*/
global	$test_items :=	{"1_string"	:	"String A||String B|String C"
		,"2_array"	:	["Array item A|", "Array item B", "Array item C"]
		,"3_object"	:	{"objKey1":"Obj item A|", "objKey2":"Obj item B", "objKey3":"Obj item C"}
		,"4_empty_item_multi_sel"	:	[ "", "List with empty item|",	"Foo selected", "Bar"]
		,"5_nothing_selected"	:	[ "1 nothing selected",	"2", "3"]}


;global	$test_items :=	{"4_empty_item_multi_sel"	:	[ "", "List with empty item|",	"Foo selected|", "Bar"]}

/** Checked items values
  Each item is checked value for data in $test_items

*/
global	$checked_items := [ "String C", 3, "objKey3", 4, "" ]

/** Run test for item types controls

*/
class _ItemTypesTest {
	
	
	
	/**
	*/
	runTestOfType($ctr_type, $GroupBox:=""){

		For $type, $data in $test_items {
			if($GroupBox)
				$GuiTest.Controls.GroupBox().layout("row").add($ctr_type " " RegExReplace( $type, "i)_", " " ) )

			$GuiTest.Controls.get($ctr_type)
					.items($data)
					.add($ctr_type " " $type)
			
			
			;if(RegExMatch( $ctr_type, "i)radio" ) && A_Index<$test_items.GetCapacity()) ; new section after NON last item
				;$GuiTest.Controls.section()
		}
	}
	/**
	*/
	runTestOfTypeChecked($ctr_type, $GroupBox:=""){

		For $type, $data in $test_items {
			if($GroupBox)
				$GuiTest.Controls.GroupBox().layout("row").add("Checked - " $checked_items[A_Index])

			$GuiTest.Controls.get($ctr_type).items($data).checked($checked_items[A_Index]).add("Checked " $checked)
			;if(RegExMatch( $ctr_type, "i)radio" ) && A_Index<$test_items.GetCapacity()) ; new section after NON last item
				;$GuiTest.Controls.section()
		}
	}


}



;"arr_item_selected"	:	[ "Item selected|",	"Foo value", "Bar value"]
;"arr_nothing_selected"	:	[ "Nothing selected",	"Foo value", "Bar value"]