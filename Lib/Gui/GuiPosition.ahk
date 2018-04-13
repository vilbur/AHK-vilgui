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
		WinMove, % this._name,, this._getPostion( "x", $x ), this._getPostion( "y", $y )
		return this
	}
	
	/*---------------------------------------
		PRIVATE METHODS
	-----------------------------------------
	*/
	/** return value x|y if exists or current window position
	 */
	_getPostion( $xy, $value )
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
		WinGetPos, $X, $Y, $W, $H, % "ahk_id " this._last_active_window
		
		if WinExist( "ahk_id " this._last_active_window )
		{
			WinGetPos,,, $mW, $mH, % this._name				
			WinMove, % this._name,, ($W-$mW)/2 + $X, ($H-$mH)/2 + $Y
		}
	}
	
	
}
