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
	center($center:="", $toggle:=true)
	{
		if( this._hwnd )
		{
			if( InStr( $center, "xy" ) )
				Loop, Parse, $center
					this._centerXY(A_LoopField)				

			else if( $center == "window" )
				this._centerToWindow()
		}
		else
			this._setCenter( $center, $toggle  )
		
		return this
	}

	/*---------------------------------------
		PRIVATE METHODS
	-----------------------------------------
	*/
	/** Set values to this._center
	 */
	_setCenter( $center, $toggle )
	{
		if( InStr( $center, "xy" ) )
			Loop, Parse, $center
				this._center[A_LoopField] := $toggle
				
		else if( $center == "window" )
			this._center.window := true
	}  
	/** Move window to postion
	 */
	_move( $x, $y )
	{
		WinMove, % this.ahkId(),, %$x%, %$y%
		
		return this
	}
	/**
	 */
	_centerXY( $xy )
	{
		this.show( $xy "Center")
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
		this._last_active_window := WinActive("A")
	} 
	/** Center Gui window to active window
	 */
	_centerToWindow()
	{
		if ! WinExist( this.ahkId(this._last_active_window) )
			return this

		$center_position := this._getCenterToWindowPositions()
		
		WinMove, % this.ahkId(),, % $center_position.x, % $center_position.y
	}
	/**
	 */
	_getCenterToWindowPositions()
	{
		$size_gui	:= this._getGuiSize()

		$size_win	:= this._getGuiSize(this._last_active_window)
		$pos_win	:= this._getPostion(this._last_active_window)		
		
		$center_x	:= $pos_win.x + ($size_win.w - $size_gui.w)/2
		$center_y	:= $pos_win.y + ($size_win.h - $size_gui.h)/2	
		
		return { x: Round($center_x), y:Round($center_y) }	
	}  
	
	
	
}










