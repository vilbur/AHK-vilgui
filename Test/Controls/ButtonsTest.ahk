/** Class ButtonsTest
*/
Class ButtonsTest{

	runMainTest(){
		$GuiTest.Controls
			.GroupBox().layout("row").add("ButtonsTest")
		this.submitButton()
		this.submitButtonToObjectMethod()
		this.defaultButtons()
	}
	/** GUI_form
	*/
	submitButton(){
		$GuiTest.Controls
			.Button()
			.callback("submitGuiCallbackTest", "EVENT", "BY", "BUTTON")
			.submit("Submit Button")
	}
	/** Submit Gui to object method
		!!! COTROL AS FIRST PARAMETER Is NOT BIND IF OBEJCT METHOD IS CALLED !!!
	*/
	submitButtonToObjectMethod(){
		global $SubmitCallbackObject := new SubmitCallbackObject()
		$GuiTest.Controls
			.Button().callback( &$SubmitCallbackObject ".submitMethod","Custom Parameter 1", "Custom Parameter 2" ).submit("Submit To Object")
	}
	/** DefaultButtons
	*/
	defaultButtons(){
		$GuiTest.Controls
			.Button().callback("buttonCallbackTest", "GUI Close").close("Close button")
			.Button().callback("buttonCallbackTest", "SCRIPT IS NOT EXITING,`NIF CUSTOM CALLBACK IS DEFINDED").exit("Exit button")
	}
}

/*-----------------------------------------
	CALLBACKS
-----------------------------------------
*/
/** buttonCallbackTest
*/
buttonCallbackTest($Event, $params*){
	$Event.message(100)
	MsgBox,262144,, % $params[1] "`n" $params[2] "`n" $params[3],5
}
/** SubmitCallbackObject
*/
Class SubmitCallbackObject{

	/** submitMethod
	*/
	submitMethod($Event, $params*){
		$Event.message()
	}
}

