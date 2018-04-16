/** Class Tab_vgui
*/
Class Tab_vgui
{
	
	Controls	:= {}
	tab_num	:= ""	
	_name	:= ""	
	
	__New($tab_num)
	{
		this.tab_num := $tab_num
	}
	
	/** Get\ Set name of tab
	  
		TODO: GETTING Should be done by SendMessage dynamically
	*/
	name($name:="~null")
	{
		if($name=="~null"){
			return % RegExReplace( this._name, "\|+", "" ) 
		}
		this._name := $name
		return this
	}

	/** setControls
	*/
	setControls($Tabs)
	{
		;MsgBox,262144,, % $Tabs.Controls().Parent(),2 
		this.Controls	:= new Controls_vgui().Base( $Tabs.Controls().Base() ).parent(this).guiName( $Tabs.Controls().guiName() )
		this.Controls._Layout.ContainerMain.control(&$Tabs)
		;Dump(this.Controls, "this.Controls", 0)
		return this
	}
	/** Set\Get Base class VilGUI
		@return VilGui
	*/
	Base($Base:="")
	{
		if($Base)
			this._Base	:= &$Base
			
		return % $Base ? this : Object(this._Base)
	}

}
