/** Class ListBox_vgui
*/
Class ListBox_vgui extends ListBoxLBEX_vgui
{
	/** Add Cotrol to gui OR add item to listbox with LBEX function
	 *  
	 *  Both VilGui & LBEX has Add() method, THIS method adapt both - for keeping consistency with LBEX library
	 *  
	 *  @param	string	$param	name of control or item for adding
	 *  
	 *  @return	object	Controls when adding control OR self when adding item
	 */
	add($param:=""){

		if( ! this.hwnd )
		{
			this.name($param)
			return % this.Controls().add(this) ; clone added object if user insert one object multiple times
		}
		else
		{
			this.LBEX_Add( $param ) 
			return this	
		}
		
	}

}