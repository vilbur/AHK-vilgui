/** Class WindowEvents_vgui
*/
Class WindowEvents_vgui{

	/** Call function on window event
	*/
	bindEvents(){
		Gui +LastFound
		hWnd := WinExist()
		DllCall( "RegisterShellHookWindow", UInt,Hwnd )
		MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
		OnMessage( MsgNum, "onWindowMessage" )
		;return this
	}

}



/** Recive Window Message
*/
onWindowMessage( wParam,lParam ){
	DetectHiddenWindows, On
	WinGetTitle, $winTitle, ahk_id %lParam%
	if($_GUI[$winTitle])
		if(wParam==2) ; if window is closed
			$_GUI[$winTitle].Events.Gui.call("close")
	;else
		;MsgBox,262144,wParam, %wParam%,3
}