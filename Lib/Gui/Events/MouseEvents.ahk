/** Class MouseEvents_vgui
   OnMose Messages : https://msdn.microsoft.com/en-us/library/windows/desktop/ms645607(v=vs.85).aspx
*/
Class MouseEvents_vgui{

	/** Call function on mouse wheel event
		Allow scrolling
	*/
	bindWheel(){
		;WM_MOUSEHWHEEL := 0x020A
		OnMessage(WM_MOUSEHWHEEL, "MouseEventsMainCallback")
		return this
	}

	/** When user scroll with scrollbar
	*/
	bindScroll(){
		;WM_VSCROLL := 0x0115
		OnMessage(WM_VSCROLL, "MouseEventsMainCallback")
		return this
	}

	;bindEvent($event:=""){
	;	WM_MOUSEACTIVATE := 0x0201
	;	OnMessage(WM_MOUSEACTIVATE , "MouseEventsMainCallback")
	;
	;	return this
	;
	;}

}

/*-----------------------------------------
	CALLBACK
-----------------------------------------
*/

;/** Recive Mouse Wheel Message
;  */
;onMouseWheelMessage( wParam, lParam ){
;
;	MsgBox,262144,, onMouseWheelMessage,2
;
;	DetectHiddenWindows, On
;	hwnd := WinExist()
;	if(wParam==4287102976) ; mouse wheel down
;		OnScroll(1, lParam, 0x115, hwnd )
;	else if(wParam==7864320)  ; mouse wheel up
;		OnScroll(0, lParam, 0x115, hwnd )
;	;else
;	;	MsgBox,262144,, %wParam%,3
;}
;/** Recive Mouse Wheel Message
;*/
;onScrollMessage( wParam, lParam ){
;	DetectHiddenWindows, On
;	hwnd := WinExist()
;	;;if(wParam==4287102976) ; mouse wheel down
;		OnScroll(wParam,lParam, 0x115, hwnd )
;	;;else if(wParam==7864320)  ; mouse wheel up
;	;;	OnScroll(0, 0, 0x115, hwnd )
;	;;else
;		;MsgBox,262144,SCROLL, %lParam%,1
;}
/** MouseEventsMainCallback
*/
MouseEventsMainCallback(W, L, M, H){
	;MsgBox,262144,, MouseEventsMainCallback,2
	hwnd := WinExist()
	DetectHiddenWindows, On
	WinGetTitle, $winTitle, A

	if(wParam==4287102976) ; mouse wheel down
		OnScroll(1, lParam, 0x115, hwnd )
	else if(wParam==7864320)  ; mouse wheel up
		OnScroll(0, lParam, 0x115, hwnd )
	else if(wParam==4287102976) ; on scrollbar drag
		OnScroll(wParam,lParam, 0x115, hwnd )


	;;; call custom callback on control
	$GUI[$winTitle].List.get(H, "hwnd" ).Event.mouse.call(W, L, M, H)

	;$GUI[$winTitle].List.get(H, "hwnd" ).Event.callEventCallback("mouseTest")

}







