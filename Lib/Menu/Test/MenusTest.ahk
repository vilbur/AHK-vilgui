#SingleInstance force

#Include %A_LineFile%\..\Menus.ahk
setWorkingDir, %A_LineFile%\..\
/** Class Menu
*/
Class MenuTest {

	hwnd	:= "TestMenuGui"
	Menus	:= new Menus()

	/** Test
	*/
	Test(){

		this.bindCustomDefaultItem()
		this.addMainMenuItems()
		this.addTrayMenuItems()
		this.trayMenuIcon()
		this.addCustomMenu()

		this.Menus.Main.show(this.hwnd)
		this.Menus.Tray.show()
		;this.Menus._bindDefaultItemsMenu()
		;Dump(this.Menus, "this.Menus", 0)
		this.showGUI()
		return this
	}
	/** showGUI
	*/
	showGUI(){
		Gui, % this.hwnd ":Add", button, w256 gshowCustomMenu, Click for Custom menu
		Gui, % this.hwnd ":Show", AutoSize , % this.hwnd
	}

	/*---------------------------------------
		MAIN MENU
	-----------------------------------------
	*/
	/** addMainMenuItems
	*/
	addMainMenuItems(){
		this.Menus.Main
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

		;Dump(this.Menus.Main, "this.Menus.Main", 0)
	}
	/*---------------------------------------
		TRAY MENU
	-----------------------------------------
	*/
	/** addTrayMenuItems
	*/
	addTrayMenuItems(){
		this.Menus.Tray
					.defaults(false)	; ON\OFF default items
					.tooltip("MenuTest tooltip")	; Custom tra icon tooltip
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
		this.Menus.Tray
				.icon("")	; try get script name default icon
				.icon("C:\GoogleDrive\Programs\Core\AutoHotkey\Class\Menu\Icons\Menus.ico") ; Absolute path to icon
				.icon("Menus.ico")	; Try get "A_WorkingDir\Menus.ico" AND ; Try get "A_WorkingDir\Icons\Menus.ico"
				.icon("\Icons\Menus.ico")	; file in working dir subdir
				.item("&Custom")

	}
	/*---------------------------------------
		CUSTOM MENU
	-----------------------------------------
	*/

	/** addCustomMenu
	*/
	addCustomMenu(){
		this.Menus.menu("Custom")
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
		this.Menus.defaults("Custom",	&this ".customDefaultCallback")

	}
	/** customDefaultCallback
	*/
	customDefaultCallback(){
		MsgBox,262144,, Custom Default Item,3
	}
}

/*---------------------------------------
	CALLBACKS
-----------------------------------------
*/
/** trayMenuCallback
*/
trayMenuCallback($param1:="", $param2:="", $param3:=""){
	MsgBox,262144,,trayMenuCallback ,2
}

/** showCustomMenu
*/
showCustomMenu(){
	$MenuTest.Menus.Custom.show()
}



/*---------------------------------------
	RUN TEST
-----------------------------------------
*/
global $MenuTest := new MenuTest().test()
