/** GuiMov
*/
Class GuiPosition_vgui
{
	_center	:= {x:true, y:false, window:false}
	_position	:= {x:0, y:0}
	
	/** set init position of gui
	 */
	position( $x, $y:="" )
	{
		this._position.x := $x

		if( $y )
			this._position.y := $y
	
		return this 
	}
	
	/** center gui on display
	  * @param string $xy	"x|y|window" // center x|y to screen, center to current window if "window" ( for multiple display setup  )
	  * @param boolean $toggle  
	*/
	center($xy, $toggle:=true)
	{
		this._center[$xy] := $toggle
		
		if( $xy=="window" )
			this._centerToWindow()
		
		else if(this._center[$xy])
			this.show($xy "Center")
					
		return this
	}
	/** Move window to postion
	 */
	move( $x:="", $y:="" )
	{
		WinMove, % this._gui(),, this._getPostionValue( "x", $x ), this._getPostionValue( "y", $y )
		
		return this
	}
	
	/*---------------------------------------
		PRIVATE METHODS
	-----------------------------------------
	*/
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
		WinGetPos, $x, $y,,, % this._name
		
		return % $value ? $value : ( $xy=="x" ? $x : $y )
	} 
	/**
	 */
	_saveLastWindowCentering()
	{
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
		
		$size_win	:= this._getGuiSize(this._last_active_window)
		$pos_win	:= this._getPostion(this._last_active_window)		
		
		$center_x	:= $pos_win.x + ($size_win.w - $size_gui.w)/2
		$center_y	:= $pos_win.y + ($size_win.h - $size_gui.h)/2	
		
		WinMove, % this.ahkId(),, %$center_x%, %$center_y%
	}
	
	
}










