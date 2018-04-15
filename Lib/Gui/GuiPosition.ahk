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
		$x := this._getRelativePosition( "x", $x )
		$y := this._getRelativePosition( "y", $y )		
			
		if( ! this._hwnd )
			this._position := {x: $x, y: $y} 

		else
			this._move( $x, $y )

		return this
	}
	

	/** center gui on display
	 *	@param string  $xy	"x|y|window" // center("xy") center to screen, center("x") center only x, center("window") to current window
	 */
	center($xy:="")
	{
		if( this._hwnd )
		{
			if( $xy != "window" )
				Loop, Parse, $xy
					this._centerGui(A_LoopField)				

			 else
				this._centerToWindow()
		}
		return this
	}

	/*---------------------------------------
		PRIVATE METHODS
	-----------------------------------------
	*/
	/** Move window to postion
	 */
	_move( $x, $y )
	{
		WinMove, % this.ahkId(),, %$x%, %$y%
		
		return this
	}
	/**
	 */
	_centerGui( $xy )
	{
		this.show( $xy "Center")
		;this._center[$xy] := $toggle
	}
	/** if $value is relative
	 */
	_getRelativePosition( $xy, $value )
	{
		if( ! RegExMatch( $value, "^[\+\-]" )) 
			return $value
		
		$pos := this._getPostion()
		
		return % ($xy=="x" ? $pos.x : $pos.y) + $value
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










