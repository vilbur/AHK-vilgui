/** Class Button_vgui
*/
Class Button_vgui extends Control_vgui{

	/** Makes submit button  
	*/
	submit($text:="Submit"){
		this.name($text)
		this._bindDefaultCallback( &this.Base() ".submit")
		return % this.Controls().add(this)
	}
	/** Makes close button  
	*/
	close($text:="Close"){
		this._bindDefaultCallback( &this.Base() ".close")
		return % this.add($text)
	}
	/** Makes exit button  
	*/
	exit($text:="Exit"){
		this._bindDefaultCallback( &this.Base() ".exit")
		return % this.add($text)
	}

}
