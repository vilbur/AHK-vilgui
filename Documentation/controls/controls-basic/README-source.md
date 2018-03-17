# Controls

### Methods for every control
__add__( [string __$id__] ) // @return object __Control__  
	// add control to gui with given id, $id is used as value if value is not defined  

__callback__( $string __$fnName__, __$params__* )  
	// callback fn for control, any number of parameters  

__options__( string __$options__ )  
	// @param __$options__ strings of [options](https://autohotkey.com/docs/commands/Gui.htm#Controls_Uncommon_Styles_and_Options)  
	// E.G: "w256 h64 x+16 y+32 border"  

------------------------------------------------------------------------------------------------------------------------------------

## Basic controls

* Button
* Edit
* Text
* Checkbox

__value__( string __$value__ )  
// value of control  

[include:\controls-basic.ahk]  
![alt text](https://github.com/vilbur/ahk-vilgui/blob/master/Documentation/controls/controls-basic/controls-basic.jpeg?raw=true)  

------------------------------------------------------------------------------------------------------------------------------------

## Items controls

* Dropdown
* Radio
* ListBox

__items__( string|array|object __$items__ )  
    // items in control  
    // selected item in array & object is marked with pipe "|" on end of item E.G: __"A|B||C"__  
    // selected item in string is maked with doublepipe "||"  E.G: __["A", "B|", "C"]__  

__checked__( int|string __$key__ )  
    // key or index of seleted item  
    // overides items selection, in listbox add to selection  

## Examples

[include:\controls-items.ahk]  
![alt text](https://github.com/vilbur/ahk-vilgui/blob/master/Documentation/controls/controls-basic/controls-items.jpeg?raw=true)  


  