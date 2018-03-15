/** Class CheckboxTest
*/
Class CheckboxTest{

	runMainTest(){
		$GuiTest.Controls
			.GroupBox().layout("row").add("GUI_Checkbox")
				.Checkbox().add("Checkbox Name")
				.Checkbox().value("Checkbox Value").checked(false).add("Checkbox")
				.Checkbox().value("Checkbox Checked").checked().add()
	}

}
