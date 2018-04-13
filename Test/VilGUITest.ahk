#SingleInstance force
#Include %A_LineFile%\..\..\VilGUI.ahk

#Include %A_LineFile%\..\Gui\GuiEventsTest.ahk
#Include %A_LineFile%\..\Gui\MarginTest.ahk

#Include %A_LineFile%\..\Menu\MenuTest.ahk

#Include %A_LineFile%\..\Controls\ControlsTest.ahk
#Include %A_LineFile%\..\Controls\ControlsEventTest.ahk

#Include %A_LineFile%\..\Controls\CheckboxTest.ahk
#Include %A_LineFile%\..\Controls\TabsTest.ahk
#Include %A_LineFile%\..\Controls\PathTest.ahk
;#Include %A_LineFile%\..\Controls\LabelTest.ahk
#Include %A_LineFile%\..\Controls\ButtonsTest.ahk

#Include %A_LineFile%\..\Controls\ItemTypes\_ItemTypesTest.ahk
#Include %A_LineFile%\..\Controls\ItemTypes\RadioTest.ahk
#Include %A_LineFile%\..\Controls\ItemTypes\DropdownTest.ahk
#Include %A_LineFile%\..\Controls\ItemTypes\ListBoxTest.ahk
#Include %A_LineFile%\..\Controls\ItemTypes\ListBoxViewTest.ahk


#Include %A_LineFile%\..\Controls\ListViewTest.ahk

#Include %A_LineFile%\..\Controls\ListViewInTabsTest.ahk

#Include %A_LineFile%\..\Controls\Colors\ColorsTest.ahk

#Include %A_LineFile%\..\Controls\use-case\control-delete.ahk

global $GuiTest
global $GuiTest2

/** Class VilGUITest
*/
Class VilGUITest{

	__New(){
		setWorkingDir, %A_LineFile%\..\..\
	}
	/**
		COMMENT IN\OUT ITEMS OF CONTROL TO ON\OFF TEST
	*/
	_Tests	:=	[ new MarginTest()
					 
			;,new MenuTest()
			;,new GuiEventsTest()
			;
			,new ControlsTest()
			;,new ControlsEventTest()
			,new ColorsTest()						
			
			
			;,new CheckboxTest()
			;,new RadioTest()
			;,new DropdownTest()
			;,new ListBoxTest()
			;,new ListBoxViewTest()
			;
			;,new PathTest()
			;,new LabelTest()
			,new TabsTest()
			
			;,new ListViewTest()
			;,new ListViewInTabsTest()
			
			;,new controlDelete()]			
			
			;,new ButtonsTest()
			,""]


	/** GuiTestTest
	*/
	TEST()
	{
		this.setupGui()
		this.MenusTest.runMainTest()

		For $c, $test in this._Tests 
			$test.runMainTest()

		
		;this.showDefault()
		 ;this.showFixedHeight()
		 this.showResizable()

		;Dump($GuiTest, "GuiTest", 0)
	}

	/** setupGui
	*/
	setupGui(){
		$GuiTest	:= new VilGUI("Gui Test")
		;$GuiTest2	:= new VilGUI("Gui Test 2")

		;$GuiTest.Controls
			;.layout("column")
			;.layout("row")
	}
	/*---------------------------------------
		SHOW SETUPS
	-----------------------------------------
	*/
	/** GUI SETUP EXAMPLE 1
	*/
	showDefault()
	{
		$GuiTest.create()
				; .alwaysOnTop()
			 ;.autosize()
		; $GuiTest2.controls.button().add()
		; $GuiTest2.show()
		
	}
	/** GUI SETUP EXAMPLE 2
	*/
	showFixedHeight()
	{
		$GuiTest
			.alwaysOnTop()
			;.resizeable()
			;.minSize("500", "500" )
			;.maxSize("1000", "1000" )
			.resizeable(false)
			.create()

		}
	/** GUI SETUP EXAMPLE 3
	 * Resizable gui with INIT and MAX height
	 */
	showResizable()
	{
		$GuiTest
			.resizeable()
			.size("", 320 )
			.fixedWidth()
			.minSize("", 128 )
			.maxSize("", 512 )						
			.create()

	}
	/*---------------------------------------
		PRIVATE METHODS
	-----------------------------------------
	*/
	/** _newSectionNeeded
	*/
	_newSectionNeeded($A_Index){
		; return
		$groupbox_count := $GuiTest.Controls._Layout.ContainerMain.Sections[1].Controls.MaxIndex()
		return % $groupbox_count > 3 && floor($groupbox_count/2)+1==$A_Index
	}

}


/*---------------------------------------
	RUN TEST
-----------------------------------------
*/
new VilGUITest().TEST()
