# Gui size  
## Methods  
| __size__( [$width], [$height] )	|Set size of gui	|  
|:---	|:---	|  
|`@param int|string` $width	|absolute or relative size e.g.: 512 OR "+128"	|  
|`@param int|string` $height	|absolute or relative size	|  

##  

| __autosize__()	|Resize gui by content	|  
|:---	|:---	|  
>Respect size(), minSize(), maxSize()  

##  

| __resizeable__( [$toggle] )	|Make gui resizeable	|  
|:---	|:---	|  
|`@param boolean` [ $toggle=true ]	|	|  
>Default is unresizable gui  

##  

| __minSize__( [$width], [$height] )	|Set fixed with of gui	|  
|:---	|:---	|  
|`@param int` $width	|	|  
|`@param string` $height	|	|  

##  

| __maxSize__( [$width], [$height] )	|max Size	|  
|:---	|:---	|  
|`@param string` $width	|	|  
|`@param string` $height	|	|  

##  

| __fixedWidth__( [$width] )	|fixed Width	|  
|:---	|:---	|  
|`@param boolean` [ $width=true ]	|	|  
>Fix to current size without $width  

##  
## Examples  [include:\gui-size.ahk]  