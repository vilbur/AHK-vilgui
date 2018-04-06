/** Class PathTest
*/
Class PathTest{

	runMainTest(){
		$GuiTest.Controls
			.GroupBox().value("Path Test").layout("row").add()
			
				.File().label(false)
						.options("w320")
						.root("C:\Program files")
						.filter("Audio (*.wav; *.mp2; *.mp3)")
						.selectOptions("M")
						.prompt("Find songs")
						.add()
			.section()
				.File().root("%temp%").add()
			.section()
				.Folder().label("Folder Label", "w64").root("%temp%").add()
			.section()
				.File().label("Label width is get by it``s length", "w154").add()
				

	}

}
