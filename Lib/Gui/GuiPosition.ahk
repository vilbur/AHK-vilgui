/** GuiMov
*/
Class GuiPosition_vgui
{
	_center	:= {x:true, y:true, window:false}
	_position	:= {x:0, y:0} ; store position for init
	
	
	/** set gui init
	 */
	position( $x:="", $y:="" )
	{
		if( $x )
			this._position.x := $x
			
		if( $y )
			this._position.y := $y

		return this
	}
	/** center gui on display
	 * @param string $xy	"x|y|window" // center "x|y" to screen, "window" center gui to CURRENT WINDOW
	 * @param boolean $toggle  
	 */
	center($xy:="", $toggle:=true)
	{
		if( $xy )
			this._center[$xy] := $toggle
		
		if( this._hwnd )
		{
			if( ! this._center.window )
			{
				this._centerGui("x", "Center")
				this._centerGui("y", "Center")
			} else
				this._centerToWindow()
		}
		return this
	}
	/** Move window to postion
	 */
	move( $x:="", $y:="" )
	{
		WinMove, % this.ahkId(),, this._getPostionValue( "x", $x ), this._getPostionValue( "y", $y )
		
		return this
	}
	/*---------------------------------------
		PRIVATE METHODS
	-----------------------------------------
	*/
	/**
	 */
	_centerGui( $xy, $toggle )
	{
		if($toggle)
			this.show( $xy "Center")
	} 
	/** Get position of Gui or given window
	 */
	_getPostion($hwnd:="")
	{
		WinGetPos, $x, $y,,, % this.ahkId($hwnd)
		
		return  { "x": $x, "y": $y }
	}
	
	/** return GIVEN value x|y if exists or CURRENT window position
	 */
	_getPostionValue( $xy, $value )
	{
		;WinGetPos, $x, $y,,, % this._name
		return % $value ? $value : ( $xy=="x" ? this._getPostion().x : this._getPostion().y )
	} 
	/**
	 */
	_saveLastWindowCentering()
	{
		;MsgBox,262144,, _saveLastWindowCentering
		this._last_active_window := WinExist("A")
	} 
	/** Center Gui window to active window
	 */
	_centerToWindow()
	{
		if ! WinExist( this.ahkId(this._last_active_window) )
			return this
		;MsgBox,262144,, % this._hwnd "`n" this._last_active_window 
		$size_gui	:= this._getGuiSize()
		;MsgBox,262144,size_gui, %$size_gui%,3
		;MsgBox,262144,_hwnd, % this._hwnd,2
		WinGetPos, $x, $y,$w,$h, % this.ahkId()
		$size_gui	:= { w:$w, h:$h }
		
		;MsgBox,262144,size_gui, % $size_gui.x,3
		
		
		$size_win	:= this._getGuiSize(this._last_active_window)
		$pos_win	:= this._getPostion(this._last_active_window)		
		
		$center_x	:= $pos_win.x + ($size_win.w - $size_gui.w)/2
		$center_y	:= $pos_win.y + ($size_win.h - $size_gui.h)/2	
		
		WinMove, % this.ahkId(),, %$center_x%, %$center_y%
	}
	
	
}










