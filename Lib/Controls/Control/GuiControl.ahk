/** Class GuiControl_vgui
*/
Class GuiControl_vgui extends ControlEvents_vgui{


	/** size
	*/
	size($w:="",$h:=""){
		GuiControlGet, $pos, Pos, % this.hwnd
		GuiControl, % this._guihwnd ":Move", % this.hwnd, % "w" ($w=="" ? $posW : $w) " h" ($h=="" ? $posH : $h)
	}
	/** move
	*/
	move($x:="",$y:=""){
		;MsgBox,262144,, move,2
		;Dump(this, "this.", 1)
		GuiControlGet, $pos, Pos, % this.hwnd
		GuiControl, % this._guihwnd ":Move", % this.hwnd, % "x" ($x=="" ? $posX : $x) " y" ($y=="" ? $posY : $y)
	}
	/** pos
	*/
	pos(){
		GuiControlGet, $pos, Pos, % this.hwnd
		return % {"x": $posX, "y": $posY}
	}

	/** Edit value of control in GUI
	*/
	edit($value){
		GuiControl,, % this.hwnd, %$value%
		return this
	}
	/** GuiControl of current control
	*/
	GuiControl($align:=""){
		GuiControl, % this._guihwnd ":" $align, % this.hwnd
	}


}
