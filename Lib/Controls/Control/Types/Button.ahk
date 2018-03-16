/** Class Button_vgui
*/
Class Button_vgui extends Control_vgui{

	/** add submit button
	*/
	submit($name:="Submit"){
		this.name($name)
		this._bindDefaultCallback( &this.Base() ".submit")
		return % this.Controls().add(this)
	}
	/** Destroy gui button
	*/
	close($name:="Close"){
		this._bindDefaultCallback( &this.Base() ".close")
		return % this.add($name)
	}
	/** Exit
	*/
	exit($name:="Exit"){
		this._bindDefaultCallback( &this.Base() ".exit")
		return % this.add($name)
	}

}
