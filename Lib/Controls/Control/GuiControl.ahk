/** Class GuiControl_vgui
*/
Class GuiControl_vgui extends ControlEvents_vgui{

	/** size
	 * @return object $Control
	 */
	size($width:="",$height:="")
	{
		GuiControlGet, $pos, Pos, % this.hwnd
		GuiControl, % this._guihwnd ":Move", % this.hwnd, % "w" ($width=="" ? $posW : $width) " h" ($height=="" ? $posH : $height)
		return this
	}
	/** set or get control position
	 * 
	 * @return object {x,y}|$Control 
	 */
	pos($x:="",$y:="")
	{
		if( $x!="" || $y!="" )
			return % this._move($x, $y)
		
		GuiControlGet, $pos, Pos, % this.hwnd
		return % {"x": $posX, "y": $posY}
	}
	/** Edit value of control in GUI
	 * @return object $Control
	 */
	edit($value)
	{
		GuiControl,, % this.hwnd, %$value%
		return this
	}
	/** guiControl of current control
	  * wrapper for https://autohotkey.com/docs/commands/GuiControl.htm
	*/
	guiControl($command, $value:="")
	{
		GuiControl, % this._guihwnd ":" $command, % this.hwnd, %$value%
		return this
	}
	/** _move control 
	 * @return object $Control
	 */
	_move($x:="",$y:="")
	{
		GuiControlGet, $pos, Pos, % this.hwnd
		GuiControl, % this._guihwnd ":Move", % this.hwnd, % "x" ($x=="" ? $posX : $x) " y" ($y=="" ? $posY : $y)
		return this
	}

}
