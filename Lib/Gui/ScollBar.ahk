/*-----------------------------------------
	SCROLL FUNCTIONS
-----------------------------------------
*/

 /** Scroll Gui Window
  *		https://autohotkey.com/board/topic/84209-scrollbars-in-a-gui/
  *		
  *		NOTES: 0xFFFF must be added to positions to get correct values
  *		
  */
OnScroll(wParam, lParam, msg, hwnd)
{
	;if( wParam==0 || wParam==1 )
		;MsgBox,262144,, %wParam%,1
	
    static SIF_ALL=0x17, SCROLL_STEP=30
    bar := msg=0x115 ; SB_HORZ=0, SB_VERT=1

    VarSetCapacity(si, 28, 0)
    NumPut(28, si) ; cbSize
    NumPut(SIF_ALL, si, 4) ; fMask
    if !DllCall("GetScrollInfo", "uint", hwnd, "int", bar, "uint", &si)
        return

    VarSetCapacity(rect, 16)
    DllCall("GetClientRect", "uint", hwnd, "uint", &rect)

    new_pos := NumGet(si, 20) & 0xFFFF ; nPos

    action := wParam & 0xFFFF
		
    if action = 0 ; SB_LINEUP
        new_pos -= SCROLL_STEP
    else if action = 1 ; SB_LINEDOWN
        new_pos += SCROLL_STEP
    else if action = 2 ; SB_PAGEUP
        new_pos -= NumGet(rect, 12, "int") - SCROLL_STEP
    else if action = 3 ; SB_PAGEDOWN
        new_pos += NumGet(rect, 12, "int") - SCROLL_STEP
    else if (action = 5 || action = 4) ; SB_THUMBTRACK || SB_THUMBPOSITION
        new_pos := wParam>>16
    else if action = 6 ; SB_TOP
        new_pos := NumGet(si, 8, "int") ; nMin
    else if action = 7 ; SB_BOTTOM
        new_pos := NumGet(si, 12, "int") ; nMax
    else
        return

    old_pos := NumGet(si, 20, "int") ; nPos

    min := NumGet(si, 8, "int") ; nMin
    max := NumGet(si, 12, "int") - ( NumGet(si, 16) & 0xFFFF )
		
    new_pos := new_pos > max ? max : new_pos
    new_pos := new_pos < min ? min : new_pos
	
	;MsgBox,262144,, %  "$dbg_pos:	" $dbg_pos "`nmin:	" min "`nmax:	" max  "`nold_pos:	" old_pos "`nnew_pos:	" new_pos "`ny:	" y
		
    x := y := 0
    if bar = 0 ; SB_HORZ
        x := old_pos-new_pos
    else
        y := old_pos-new_pos

    ; Scroll contents of window and invalidate uncovered area.
    DllCall("ScrollWindow", "uint", hwnd, "int", x, "int", y, "uint", 0, "uint", 0)

    ; Update scroll bar.
    NumPut(new_pos, si, 20, "int") ; nPos
    DllCall("SetScrollInfo", "uint", hwnd, "int", bar, "uint", &si, "int", 1)
	
	
}
/** Add or remove scrollbar
  */
UpdateScrollBars(GuiNum, GuiWidth, GuiHeight){

    static SIF_RANGE=0x1, SIF_PAGE=0x2, SIF_DISABLENOSCROLL=0x8, SB_HORZ=0, SB_VERT=1

    Gui, %GuiNum%:Default
    Gui, +LastFound

    ; Calculate scrolling area.
    $Left	:= $Top	:= 9999
    $Right	:= $Bottom	:= 0
    ;WinGet, $ControlList, ControlList
    WinGet, $ControlList, ControlList	
    Loop, Parse, $ControlList, `n
    {
        GuiControlGet, c, Pos, %A_LoopField%
        if (cX < $Left)
            $Left := cX
        if (cY < $Top)
            $Top := cY
        if (cX + cW > $Right)
            $Right := cX + cW
        if (cY + cH > $Bottom)
            $Bottom := cY + cH
    }

    $Left	-= 8
    $Top	-= 8
    $Right	+= 8
    $Bottom	+= 8
    ScrollWidth	:= $Right-$Left
    ScrollHeight	:= $Bottom-$Top  ; + $_GUI_margin.ui.y()*2 ; + $_GUI_margin.container.y()

    ; Initialize SCROLLINFO.
    VarSetCapacity(si, 28, 0)
    NumPut(28, si) ; cbSize
    NumPut(SIF_RANGE | SIF_PAGE, si, 4) ; fMask

    ;; Update horizontal scroll bar.
    ;NumPut(ScrollWidth, si, 12) ; nMax
    ;NumPut(GuiWidth, si, 16) ; nPage
    ;DllCall("SetScrollInfo", "uint", WinExist(), "uint", SB_HORZ, "uint", &si, "int", 1)

    ; Update vertical scroll bar.
	; NumPut(SIF_RANGE | SIF_PAGE | SIF_DISABLENOSCROLL, si, 4) ; fMask
    NumPut(ScrollHeight, si, 12) ; nMax
    NumPut(GuiHeight, si, 16) ; nPage
    DllCall("SetScrollInfo", "uint", WinExist(), "uint", SB_VERT, "uint", &si, "int", 1)


    if ($Left < 0 && $Right < GuiWidth)
        x := Abs($Left) > GuiWidth-$Right ? GuiWidth-$Right : Abs($Left)
    if ($Top < 0 && $Bottom < GuiHeight)
        y := Abs($Top) > GuiHeight-$Bottom ? GuiHeight-$Bottom : Abs($Top)
    if (x || y)
        DllCall("ScrollWindow", "uint", WinExist(), "int", x, "int", y, "uint", 0, "uint", 0)
	
		

}
