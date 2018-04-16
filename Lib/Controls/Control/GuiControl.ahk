/** Class GuiControl_vgui
*/
Class GuiControl_vgui extends ControlEvents_vgui
{

	/** Focus to control
		wrapper for: https://autohotkey.com/docs/commands/ControlFocus.htm
	 */
	focus( )
	{
		ControlFocus,, % "ahk_id " this.hwnd
		
		this._setFocusColor()

		return this
	}
	/** size
	 * @return object $Control
	 */
	size($width:="",$height:="")
	{
		GuiControlGet, $pos, Pos, % this.hwnd
		GuiControl, % this.guiName() ":Move", % this.hwnd, % "w" ($width=="" ? $posW : $width) " h" ($height=="" ? $posH : $height)
		return this
	}
	/** set or get control position
	 * 
	 * @return object {x,y}|$Control 
	 */
	pos($x:="",$y:="")
	{
		if( $x!="" && $y!="" )
			return % this._move($x, $y)
		
		return % this._getPostion()
	}
	/** Edit value of control in GUI
	 * @return object $Control
	 */
	edit($value:="")
	{
		this._setValue($value)
		
		GuiControl,, % this.hwnd, % this._getValueOrItems()
		
		return this
	}
	/** guiControl of current control
	  * wrapper for https://autohotkey.com/docs/commands/GuiControl.htm
	*/
	guiControl($command, $value:="")
	{
		GuiControl, % this.guiName() ":" $command, % this.hwnd, %$value%
		return this
	}
	/**
	 */
	color( $background:="", $foreground:="")
	{
		CtlColors.change(this.hwnd, $background, $foreground )
	}
	/** _move control 
	 * @return object $Control
	 */
	_move($x:="",$y:="")
	{
		$pos := this._getPostion()
		
		GuiControl, % this.guiName() ":Move", % this.hwnd, % "x" ($x=="" ? $pos.X : $x) " y" ($y=="" ? $pos.Y : $y)
		
		return this
	}
	/**
	 */
	_getPostion()
	{
		GuiControlGet, $pos, Pos, % this.hwnd
		
		return % {"x": $posX ,"y": $posY}
	}
	/* Set focus color
	*/
	_setFocusColor()
	{
		this.controls().Base().Style.Color.setFocusColor(this.hwnd)		
	} 
	

}
