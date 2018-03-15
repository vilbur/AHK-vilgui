/** Class MarginTest
*/
Class MarginTest{

	runMainTest(){
		;MsgBox,262144,, MarginTest,2
		$GuiTest.Margin.x(10).y(10) ; set margin for all - UI, CONTAINERS & CONTROLS
		$GuiTest.Margin.ui.x( 30 ).y(20)	; set margin around window
		$GuiTest.Margin.container.x( 20 ).y(15)	; set margin between groupboxes
		$GuiTest.Margin.control.x( 10 ).y(5)	; set margin between controls

	}

}
