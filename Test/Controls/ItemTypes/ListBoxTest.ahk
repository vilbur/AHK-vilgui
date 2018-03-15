/** Class ListBoxTest
*/
Class ListBoxTest extends _ItemTypesTest{

	runMainTest(){

		$GuiTest.Controls.GroupBox().layout("row").add("ListBox Test")
		this.runTestOfType("ListBox")

		; $GuiTest.Controls.GroupBox().layout("row").add("ListBox Checked")
		; this.runTestOfTypeChecked("ListBox")

	}

}
