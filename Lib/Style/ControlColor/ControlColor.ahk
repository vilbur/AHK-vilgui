/** ControlColor
 *
 */
Class ControlColor_vgui
{
	_hwnd	:= 0 ; gui hwnd
	_control_types	:= {"Combobox": "Dropdown"} ; convert class_nn to Vilgui control types
	_colors	:= {global:{"background":"", "foreground":""}}
	_ignore	:= {static:""} ; IGNORE text (class name==static)
	
	/** Set color of focused control
	  *
	  * @param string|hex $background color
	  * @param string|hex $foreground color
	  *
	  * @param string $control_type type of control to apply focus colors
	 */
	focus( $background:="", $foreground:="", $control_type:="" )
	{
		this._setActiveColor( "background", $background, $control_type )
		this._setActiveColor( "foreground", $foreground, $control_type )		
		
		return this
	}
	/**
	 */
	hwnd( $hwnd )
	{
		this._hwnd	:= $hwnd
		return this
	}
	/**
	 */
	setFocusColor($hwnd_ctrl)
	{
		;if( ! $hwnd_ctrl )
			;return
		
		$type_ctrl	:= this._getClassName($hwnd_ctrl)
		
		if( this._ignore.hasKey($type_ctrl) )
			return
		
		$colors	:= this._colors.hasKey($type_ctrl) ?  this._colors[$type_ctrl] : this._colors.global
		;MsgBox,262144,type_ctrl, %$type_ctrl%,2
		
		if( ! $colors.background && ! $colors.foreground )
			return
	
		this._resetControlsColors($hwnd_ctrl)
		
		CtlColors.Change($hwnd_ctrl, $colors.background, $colors.foreground  )		
	}

	/**
	 */
	_setActiveColor( $bg_fg, $color, $control_type )
	{
		if( ! $color )
			return 
		
		$type	:= this._getColorControlType($control_type)
		;$color	:= this._sanitizeColor( $color )
		
		this._setColorObject( $type )

		this._colors[$type][$bg_fg] := $color
	}
	/**
	 */
	_getColorControlType($control_type)
	{
		return % $control_type ? $control_type : "global"
	}
	/**
	 */
	_setColorObject( $type )
	{
		if( ! this._colors[$type] )
			this._colors[$type] := {}
	} 
	/** Reset foccus color on all controls except current color
	  *
	  * @param	int	$hwnd_ctrl_current	hwnd of current control
	 */
	_resetControlsColors($hwnd_ctrl_current)
	{
		WinGet, ActiveControlList, ControlListHwnd , A
			Loop, Parse, ActiveControlList, `n
				if( $hwnd_ctrl_current!=A_LoopField )
					CtlColors.Change( A_LoopField, "" )
	}
	/**
	 */
	_resetColor( $hwnd )
	{
		
	} 
	/**
	  * @return string  HWND's class name without its instance number, e.g. "Edit" or "SysListView32"
	 */
	_getClassName( $hwnd )
	{ 
	
		VarSetCapacity( buff, 256, 0 )
	
		DllCall("GetClassName", "uint", $hwnd, "str", buff, "int", 255 )
	
		return % this._control_types.hasKey(buff) ? this._control_types[buff] : buff
	}
	
}

/**
 */
ControlColor(Control, Window, bc="", tc="", redraw=1)
{
	; msgbox
	a := {}
	a["c"]  := Control
	a["g"]  := Window
	a["bc"] := (bc="")?"":(((bc&255)<<16)+(((bc>>8)&255)<<8)+(bc>>16))
	a["tc"] := (tc="")?"":((tc&255)<<16)+(((tc>>8)&255)<<8)+(tc>>16)
	WindowProc("Set", a, "", "")
	If redraw
	{
		SizeOfWINDOWINFO := 60
		VarSetCapacity(WINDOWINFO, SizeOfWINDOWINFO, 0)
		NumPut(SizeOfWINDOWINFO, WINDOWINFO, "UInt")
		DllCall("GetWindowInfo",  "Ptr", Control, "Ptr", &WINDOWINFO)
		DllCall("ScreenToClient", "Ptr", Window,  "Ptr", &WINDOWINFO+20) ; x1,y1 of Client area
		DllCall("ScreenToClient", "Ptr", Window,  "Ptr", &WINDOWINFO+28) ; x2,y2 of Client area
		DllCall("RedrawWindow"
		, "Ptr",  Window             ; A handle to the window to be redrawn. If this parameter is NULL, the desktop window is updated.
		, "UInt", &WINDOWINFO+20    ; A pointer to a RECT structure containing the coordinates, in device units, of the update rectangle. This parameter is ignored if the hrgnUpdate parameter identifies a region.
		, "UInt", 0                    ; A handle to the update region. If both the hrgnUpdate and lprcUpdate parameters are NULL, the entire client area is added to the update region.
		, "UInt", 0x101)            ; One or more redraw flags. This parameter can be used to invalidate or validate a window, control repainting, and control which windows are affected by RedrawWindow.
	}
	
}

/**
 */
WindowProc(hwnd, uMsg, wParam, lParam)
{
	Static Win := {}
	Critical
	If uMsg between 0x132 and 0x138
	If  Win[hwnd].HasKey(lparam)
	{
		If tc := Win[hwnd, lparam, "tc"]
		DllCall("SetTextColor", "UInt", wParam, "UInt", tc)
		If bc := Win[hwnd, lparam, "bc"]
		DllCall("SetBkColor",   "UInt", wParam, "UInt", bc)
		
		return Win[hwnd, lparam, "Brush"]  ; Return the HBRUSH to notify the OS that we altered the HDC.
	}
	If (hwnd = "Set")
	{
		a := uMsg
		Win[a.g, a.c] := a
		If (Win[a.g, a.c, "tc"] = "") and (Win[a.g, a.c, "bc"] = "")
			Win[a.g].Remove(a.c, "")
		If not Win[a.g, "WindowProcOld"]
			Win[a.g,"WindowProcOld"] := DllCall("SetWindowLong", "Ptr", a.g, "Int", -4, "Int", RegisterCallback("WindowProc", "", 4), "UInt")
		If Win[a.g, a.c, "Brush"]
			DllCall("DeleteObject", "Ptr", Brush)
		If (Win[a.g, a.c, "bc"] != "")
			Win[a.g, a.c, "Brush"] := DllCall("CreateSolidBrush", "UInt", a.bc)
		; array_list(a)
		return
	}
	return DllCall("CallWindowProcA", "UInt", Win[hwnd, "WindowProcOld"], "UInt", hwnd, "UInt", uMsg, "UInt", wParam, "UInt", lParam)
}
	