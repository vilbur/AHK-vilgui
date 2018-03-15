/** Class LabelTest
*/
Class LabelTest{

	runMainTest(){
		$GuiTest.Controls
			.GroupBox().layout("row").add("Label Test")
				.options("Edit", "w", 192 ) ; change defaults
					.Edit("Changed defaults").label("Label test").add()
					.Edit().label("Label", "-border").add()
				.options("Label", "w", 128).options("Label", "border") ; change defaults
				.section()
					.Button().label("Changed defaults").add()
					.Dropdown().items([ "Item selected|", "Foo value", "Bar value"]).label("Dropdown label").add()

	}

}
