/** Count bounding box
	add only higher values
*/
Class Bbox_vgui
{
	x := 0
	y := 0

	/** set
	*/
	set($pos)
	{
		this.x := $pos.x!="" ?  $pos.x : 0
		this.y := $pos.y!="" ?  $pos.y : 0
	}

	/** set position for start of next section
	*/
	add($pos)
	{
		this._addToBoundingBox("x", $pos.x)
		this._addToBoundingBox("y", $pos.y)
		return this
	}
	/** remove
	*/
	remove($pos)
	{
		For $xy, $value in $pos
			if($value)
				this[$xy] := this[$xy] - $value
		return this
	}
	;/** _set
	;*/
	;_set($xy, $value){
	;	if($value!="")
	;		this[$xy] := $value
	;}

	/** Add value to this._bbox if value is greater then current value
		Add absolute position, or add relative value to current size

		@param "x|y"	$xy
		@param int	$pos_xy absolute|relative position E.G: "256|+32"
	*/
	_addToBoundingBox($xy, $pos_xy)
	{
		if($pos_xy=="")
			return 
		if(RegExMatch( $pos_xy, "i)\+|\-"))
			$pos_xy :=  this[$xy] + $pos_xy ; add if relative value
		if($pos_xy > this[$xy] )
			this[$xy] := $pos_xy
	}


}
