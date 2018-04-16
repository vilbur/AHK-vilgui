/**
  */
class ControlsEventTest
{

	controls_main	:= ["Button", "Edit", "Checkbox"]
	; controls_main	:= ["Button", "Button", "Button", "Button"]
	; controls_main	:= ["Keypress"]
	controls_items	:= ["Dropdown", "Radio"]
	; controls_items	:= ["Radio"]

	/** runMainTest
	*/
	runMainTest()
	{
		$current_layout := $GuiTest.Controls.layout()
		this.creeateScanfold($GuiTest)
		; this.creeateControlsItems()
		
		$Tabs	:= $GuiTest.Tabs( "A|B" ).add("TabsTest")
		
		For $t, $Tab in $GuiTest.TabsTest.Tabs
			this.creeateScanfold($Tab)
				
	}
	
	/** creeateControlsMain
	*/
	creeateScanfold($ParentGui)
	{
		$layout := "column"

		$ParentGui.Controls.GroupBox().layout($layout).add("Controls Scanfold")
		
		For $c, $Control in this.controls_main
			this._addControl( $ParentGui.Controls.get($Control).clone() )
	}
	/**
	 */
	_addControl( $Control )
	{
		$Control.callback("callbackControls").add()
		this._breakSection()
	} 
	/**
	 */
	_breakSection()
	{
		if(A_Index<this.controls_main.MaxIndex()) ; dont add new section after last control
			$GuiTest.Controls.section()
	} 
	/** creeateControlsItems
	*/
	creeateControlsItems()
	{
		$GuiTest.Controls.GroupBox().add("Controls Items")
		For $c, $Control in this.controls_items
			$GuiTest.Controls.get($Control).items("Item A||Item B|Item C").add()
			;$GuiTest.Controls.get($Control).add()
	}
	/** _getControlsObjects
			Loop, % $controls_main.MaxIndex()
	*/
	_getControlsObjects()
	{
		$arr := []
		For $c, $Control in this.controls_main
			$arr[$c] := $GuiTest.Controls.get($Control)
		return %$arr%
	}

}

/** callbackGui
*/
callbackControls($Event:="", $params*){
	;MsgBox,262144,callbackGui, % $params[1] "`n" $params[2] "`n" $params[3],5
	$Event.message()
}