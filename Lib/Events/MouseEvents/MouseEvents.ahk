/** Class MouseEvents_vgui
   OnMose Messages : https://msdn.microsoft.com/en-us/library/windows/desktop/ms645607(v=vs.85).aspx
*/
Class MouseEvents_vgui extends EventBind_vgui
{

	/** Call function on mouse wheel event
		Allow scrolling
	*/
	bindWheel()
	{
		WM_MOUSEHWHEEL := 0x020A
		OnMessage(WM_MOUSEHWHEEL, "onWheelOrScrollMessage")
		return this
	}

	/** When user scroll with scrollbar
	*/
	bindScroll()
	{
		WM_VSCROLL := 0x0115
		OnMessage(WM_VSCROLL, "onWheelOrScrollMessage")
		return this
	}
	/* https://autohotkey.com/docs/misc/SendMessageList.htm
	   
		WM_MOUSEFIRST = 0x200
		WM_MOUSEMOVE = 0x200
		WM_LBUTTONDOWN = 0x201
		WM_LBUTTONUP = 0x202
		WM_LBUTTONDBLCLK = 0x203
		WM_RBUTTONDOWN = 0x204
		WM_RBUTTONUP = 0x205
		WM_RBUTTONDBLCLK = 0x206
		WM_MBUTTONDOWN = 0x207
		WM_MBUTTONUP = 0x208
		WM_MBUTTONDBLCLK = 0x209
		WM_MOUSEWHEEL = 0x20A
		WM_MOUSEHWHEEL = 0x20E	  
	  */
	bindEvent($event:="")
	{
		;MsgBox,262144,, Test,2 
		WM_MOUSEACTIVATE := 0x0201
		WM_RBUTTONDOWN = 0x204
		OnMessage(WM_RBUTTONDOWN , "onMouseMainCallback")
	
		return this
	}

}

/*-----------------------------------------
	CALLBACK
-----------------------------------------
*/

/** onWheelOrScrollMessage
*/
onMouseMainCallback(wParam, L, M, H)
{
	MsgBox,262144,, onMouseMainCallback,2 
}

/** onWheelOrScrollMessage
*/
onWheelOrScrollMessage(wParam, lParam, M, H)
{

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
	$_GUI[lParam].List.get(H, "hwnd" ).Event.mouse.call(wParam, L, M, H)

	;$_GUI[$winTitle].List.get(H, "hwnd" ).Event.callEventCallback("mouseTest")

}



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


