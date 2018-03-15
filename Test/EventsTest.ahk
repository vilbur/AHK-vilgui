#SingleInstance force
#Include %A_LineFile%\..\..\VilGUIv3.ahk


$GuiTest := new VilGUIv3("GuiTest")

;Dump($GuiTest, "GuiTest", 1)
;$GuiTest.create()


/**
  */
GuiContextMenu(GuiHwnd, CtrlHwnd, EventInfo, IsRightClick, X, Y){
	MsgBox,262144,, IsRightClick,2
}

GuiClose(GuiHwnd) {  ; Declaring this parameter is optional.
    MsgBox 4,, Are you sure you want to close the GUI?
    ifMsgBox No
        return true  ; true = 1

}



