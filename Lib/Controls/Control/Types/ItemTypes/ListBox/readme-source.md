 # ListBox  

### Listbox use [LBEX](https://github.com/AHK-just-me/LBEX) library  

* All methods from LBEX library are accessible with Listbox control  
* All methods share same parameters __EXCEPT__ HLB parameter - hwnd of control is not needed  

## Methods  

| __Add__( ByRef $String, $String )	|Adds a string to a list box.	|  
|:---	|:---	|  
|`@param string` ByRef $String	|	|  
|`@param String` $String	|item for adding	|  
|`@return Control`	|	|  

##  

| __CalcIdealWidth__( [Content], [Delimiter], [FontOptions], [FontName] )	|Calculates the ideal width of a list box needed to display the current content.	|  
|:---	|:---	|  
|`@param string` Content	|	|  
|`@param string` [ Delimiter="|" ]	|	|  
|`@param string` FontOptions	|	|  
|`@param string` FontName	|	|  
|`@return string`	|	|  

##  


## Examples  
[include:\Test\ListBoxTest.ahk]  
  