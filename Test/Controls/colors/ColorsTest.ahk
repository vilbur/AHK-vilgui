/**
  */
class ColorsTest
{
	controls_main	:= ["Button", "Edit", "Text", "Checkbox"]
	controls_items	:= ["Dropdown", "Radio", "listbox", "listbox"]

	/** runMainTest
	*/
	runMainTest()
	{
		$GuiTest.Style.Color
			.focus( 0x00FF00, 0xFF0080)
			.focus( "024FC0", "FFFFFF", "listbox")
			;.focus( 0x024FC0, 0xFFFFFF, "listbox")			
		
		$current_layout := $GuiTest.Controls.layout()
		 this._addControls()
		 this._addControlsItems()
		 this._addButtons()
		 
		;Dump($GuiTest.Controls, "GuiTest.Controls", 0)

	}

	/** add controls_main from objects
	*/
	_addControls()
	{
		$GroupBox := $GuiTest.Controls.GroupBox("Controls From Objects").layout("row")
	
		$GuiTest.Controls.add($GroupBox)
		
		For $control_type, $Control in this._getControlsObjects()
			$Control.value($control_type)
				.callback(&this ".changeColorCallback")
				.add()

	}
	/** _addControlsItems
	*/
	_addControlsItems()
	{
		$GuiTest.Controls.GroupBox()
		.layout("column")
		.add("Controls Items")
		
		For $c, $Control in this.controls_items
			$GuiTest.Controls.get($Control)
			.items("Item A||Item B|Item C")
			.callback(&this ".changeColorCallback")
			.add()

	}
	
	/**
	 */
	_addButtons()
	{
		$GuiTest.Controls.GroupBox("Test Colors").add()
			.Button()
			.callback( &this ".changeColorCallback", "ListBox1" )
			.add("Colorize ListBox1")			
	}

	/** _getControlsObjects
			Loop, % $controls_main.MaxIndex()
	*/
	_getControlsObjects()
	{
		$controls_by_type := {}
		For $c, $control_type in this.controls_main
			$controls_by_type[$control_type] := $GuiTest.Controls.get($control_type)
		
		return %$controls_by_type%
	}
	
		
	/*---------------------------------------
		CALLBACK
	-----------------------------------------
	*/
	/**
	 */
	changeColorCallback($Event, $control_name)
	{
		$GuiTest.Controls.get($control_name).color(0x00FF00, 0xFF0080)

	}
	

}



















