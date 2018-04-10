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
	$GUI := $_GUI[$winTitle]
	
	if($GUI)
	{
		$Events := $GUI.Events.Gui
		
		if( W==27) ; on escape pressed
			$Events.call("escape")
		else if( W==13) ; on enter pressed
			$Events.call("enter")
		
	}else {
		;$control := $GUI.List.get(H, "hwnd" )
		$GUI.List.get(H, "hwnd" ).Event.callEventCallback("keyPress", {"key": GetKeyName(Format("vk{:x}", W))})
		;Dump($control, "control", 1)
	}

}
