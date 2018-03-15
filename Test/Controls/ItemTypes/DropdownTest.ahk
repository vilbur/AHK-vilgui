/** Class DropdownTest
*/
Class DropdownTest extends _ItemTypesTest{

	runMainTest(){
		$GuiTest.Controls.GroupBox().layout("row").add("Dropdown Test")
		this.runTestOfType("Dropdown")

		; $GuiTest.Controls.GroupBox().layout("row").add("Dropdown Checked")
		; this.runTestOfTypeChecked("Dropdown")

	}

}
