/**
  */
class ControlsTest{

	controls_main	:= ["Button", "Edit", "Text", "Checkbox"]
	; controls_main	:= ["Button", "Button", "Button", "Button"]
	; controls_main	:= ["Keypress"]
	controls_items	:= ["Dropdown", "Radio"]
	; controls_items	:= ["Radio"]

	/** runMainTest
	*/
	runMainTest(){
		$current_layout := $GuiTest.Controls.layout()
		this.creeateScanfold()
		; this.createControlsFromObjects()
		; this.creeateControlsItems()

	}
	/** creeateControlsMain
	*/
	creeateScanfold(){
		$layout := "column"
		; $layout := "row"
		$GuiTest.Controls.GroupBox().layout($layout).add("Controls Scanfold")
		For $c, $Control in this.controls_main {
			$Control := $GuiTest.Controls.get($Control) ; get control via variable
; Dump($Control, "Control", 1)

			$Control.clone().add()
			$Control.clone().add("Add Name")
			$Control.clone().value("Value`nSecondLine").add()
			$Control.clone().value("Value And Name").add("Add Name")

			if(A_Index<this.controls_main.MaxIndex()) ; dont add new section after last control
				$GuiTest.Controls.section()
		}
	}
	/** create controls_main from objects
	*/
	createControlsFromObjects(){
		$GroupBox := $GuiTest.Controls.GroupBox("Controls From Objects").layout("row")
		Loop, 2 {
			$GuiTest.Controls.add($GroupBox)
			For $c, $Control in this._getControlsObjects()
				;Dump($Control, $Control._type, 0)
				$Control.add()
		}
	}
	/** creeateControlsItems
	*/
	creeateControlsItems(){
		$GuiTest.Controls.GroupBox().add("Controls Items")
		For $c, $Control in this.controls_items
			$GuiTest.Controls.get($Control).items("Item A||Item B|Item C").add()
			;$GuiTest.Controls.get($Control).add()
	}
	/** _getControlsObjects
			Loop, % $controls_main.MaxIndex()
	*/
	_getControlsObjects(){
		$arr := []
		For $c, $Control in this.controls_main
			$arr[$c] := $GuiTest.Controls.get($Control)
		return %$arr%
	}

}
