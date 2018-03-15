/** Class KeyEvents_vgui
*/
Class KeyEvents_vgui{
	/** Call function on keypress
	*/
	bindEvents(){
		if(!this.allready_bind){
			WM_KEYDOWN := 0x100
			OnMessage(WM_KEYDOWN, "onKeyDownMessage")
			this.allready_bind	:= true
		}
	}

}


/** Recive Key Down Message
	https://autohotkey.com/board/topic/88725-detecting-keypress-in-edit-control/
  */
onKeyDownMessage(W, L, M, H) {
	WinGetTitle, $winTitle, A
	if($GUI[$winTitle] && W==27) ; if escape pressed
		$GUI[$winTitle].Events.Gui.call("escape")
	else {
		;$control := $GUI[$winTitle].List.get(H, "hwnd" )
		$GUI[$winTitle].List.get(H, "hwnd" ).Event.callEventCallback("keyPress", {"key": GetKeyName(Format("vk{:x}", W))})
		;Dump($control, "control", 1)
	}



}
