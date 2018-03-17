### Items controls  
  
* Dropdown  
* Radio  
* ListBox  
  
  
## Methods  
 __add__( [string __$id__] ) // @return object __Control__  
	// add control to gui with given id, $id is used as value if value is not defined  
  
__items__( string|array|object __$items__ )  
    // items in control  
    // selected item in array & object is marked with pipe "|" on end of item E.G: __"A|B||C"__  
    // selected item in string is maked with doublepipe "||"  E.G: __["A", "B|", "C"]__  
  
__callback__( $string __$fnName__, __$params__* )  
    // callback fn for control, any number of parameters  
  
__options__( string __$options__ )  
    // string of options [options](https://autohotkey.com/docs/commands/Gui.htm#Controls_Uncommon_Styles_and_Options)  
    // E.G: "w256 h64 x+16 y+32 border"  
  
## Examples  
  
  
  
  
``` php  
  
```  
![alt text](https://github.com/vilbur/ahk-vilgui/blob/master/Documentation/controls/controls-basic/controls-items.jpeg?raw=true)  
  