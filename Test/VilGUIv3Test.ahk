#SingleInstance force
#Include %A_LineFile%\..\..\VilGUIv3.ahk

#Include %A_LineFile%\..\Gui\GuiEventsTest.ahk
#Include %A_LineFile%\..\Gui\MarginTest.ahk

#Include %A_LineFile%\..\Menu\MenuTest.ahk

#Include %A_LineFile%\..\Controls\ControlsTest.ahk

#Include %A_LineFile%\..\Controls\CheckboxTest.ahk
#Include %A_LineFile%\..\Controls\TabsTest.ahk
#Include %A_LineFile%\..\Controls\PathTest.ahk
#Include %A_LineFile%\..\Controls\LabelTest.ahk
#Include %A_LineFile%\..\Controls\ButtonsTest.ahk

#Include %A_LineFile%\..\Controls\ItemTypes\_ItemTypesTest.ahk
#Include %A_LineFile%\..\Controls\ItemTypes\RadioTest.ahk
#Include %A_LineFile%\..\Controls\ItemTypes\DropdownTest.ahk
#Include %A_LineFile%\..\Controls\ItemTypes\ListBoxTest.ahk
#Include %A_LineFile%\..\Controls\ItemTypes\ListBoxViewTest.ahk

#Include %A_LineFile%\..\Controls\ListViewTest.ahk

#Include %A_LineFile%\..\Controls\ListViewInTabsTest.ahk

global $GuiTest
global $GuiTest2

/** Class VilGUIv3Test
*/
Class VilGUIv3Test{

	__New(){
		setWorkingDir, %A_LineFile%\..\..\
	}
	/**
		COMMENT IN\OUT ITEMS OF CONTROL TO ON\OFF TEST
	*/
	Controls	:=	[ new MarginTest()
			,new MenuTest()
			,new GuiEventsTest()
			,new ControlsTest()
			,new CheckboxTest()

				;,new RadioTest()
				;,new DropdownTest()
				;,new ListBoxTest()
				;,new ListBoxViewTest()
				;,new PathTest()
				;,new LabelTest()
				;,new TabsTest()
				;;;,new TabsTest("new section")
				,new ListViewTest()
				,new ListViewInTabsTest()
				,new ButtonsTest()]


	/** GuiTestTest
	*/
	test(){
		this.setupGui()
		;this.MenusTest.runMainTest()

		For $c, $Control in this.Controls {
			/* SPLIT UI TO SECTIONS
			*/
			; if(this._newSectionNeeded(A_Index))
				; $GuiTest.Controls.section()

			$Control.runMainTest()
		}
		this.showSetup_1()
		; this.showSetup_2()
		; this.showSetup_3()
	}

	/** setupGui
	*/
	setupGui(){
		$GuiTest := new VilGUIv3("GuiTest")
		$GuiTest2 := new VilGUIv3("GuiTest2")

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
	showSetup_1(){
		$GuiTest.Gui.show()
				; .alwaysOnTop()
			; .resizeable(false)
			; .autosize()
		; $GuiTest2.controls.button().add()
		; $GuiTest2.Gui.show()
	}
	/** GUI SETUP EXAMPLE 2
	*/
	showSetup_2(){
		$GuiTest.Gui.show()
				.alwaysOnTop()
				.resizeable()
				.minSize("500", "500" )
				.maxSize("1000", "1000" )
				.size(720, 720)
				.resizeable(false)
				.center("x")
				.center("y")
		}
	/** GUI SETUP EXAMPLE 3
	*/
	showSetup_3(){
		$GuiTest.Gui.show()
			   .resizeable()
			   .autosize()
			   .fixedWidth()
			   .size("", "720" )
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
new VilGUIv3Test().test()
