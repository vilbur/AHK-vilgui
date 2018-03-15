/** Class MenuTest
*/
Class MenuTest{


	/** Test
	*/
	runMainTest(){
		this.bindCustomDefaultItem()
		this.addMainMenuItems()
		this.addTrayMenuItems()
		this.trayMenuIcon()
		this.addCustomMenu()

		return this
	}
	/*---------------------------------------
		MAIN MENU
	-----------------------------------------
	*/
	/** addMainMenuItems
	*/
	addMainMenuItems(){
		$GuiTest.Menus.Main
			.menu("&Main Menu A")
				.item("Menu A Item 1","MenuItemCallBack")
				.item()	; Separator
				.menu("&Sub Menu A 1")
					.item("Sub Item 1","MenuItemCallBack")
					.parent()
				.item("Menu A Item 2","MenuItemCallBack")
				.parent()
			.menu("&Defaults Menu")
				.item("&Reload")
				.item("&Exit")
				.item("&Custom")

		;Dump($GuiTest.Menus.Main, "$GuiTest.Menus.Main", 0)
	}
	/*---------------------------------------
		TRAY MENU
	-----------------------------------------
	*/
	/** addTrayMenuItems
	*/
	addTrayMenuItems(){
		$GuiTest.Menus.Tray
					.defaults(false)	; ON\OFF default items
					.tooltip("GuiTest Test")	; Custom tra icon tooltip
					.menu("Menu1")
						.item("Sub Item 1","MenuItemCallBack")
						.item("Sub Item 2","MenuItemCallBack")
						.parent()
					.item("Tray Item 1","MenuItemCallBack")
					.item()
					.item("&Reload")
					.item("&Exit")
					.item("&Custom")
	}
	/** trayMenuIcon
	*/
	trayMenuIcon(){
		$GuiTest.Menus.Tray
				;.icon("")	; try get script name default icon
				;.icon("C:\GoogleDrive\Programs\Core\AutoHotkey\Class\GuiTest\Icons\VilGUI.ico") ; Absolute path to icon
				;.icon("VilGUI.ico")	; Try get "A_WorkingDir\GuiTest.ico" AND ; Try get "A_WorkingDir\Icons\GuiTest.ico"
				.icon("\Icons\VilGUI.ico")	; file in working dir subdir
				.item("&Custom")

	}
	/*---------------------------------------
		CUSTOM MENU
	-----------------------------------------
	*/
	/** addCustomMenu
	*/
	addCustomMenu(){
		$GuiTest.Menus.menu("Custom")
					.item("Custom Item 1","MenuItemCallBack")
					.item("Custom Item 2","MenuItemCallBack")
					.menu("&Defaults Menu")
						.item("&Reload")
						;.item("&Exit")
	}
	/*---------------------------------------
		CUSTOM MENU ITEM
	-----------------------------------------
	*/
	/** bindCustomDefaultItem
	*/
	bindCustomDefaultItem(){
		$GuiTest.Menus.defaults("Custom",	&this ".customDefaultCallback")

	}
	/** customDefaultCallback
	*/
	customDefaultCallback(){
		MsgBox,262144,, Custom Default Item,3
	}
}
