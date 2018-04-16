# Gui methods  
## Show  

| __gui__( $command, [$param1], [$param2], [$param3] )	|Wrapper for [Gui, command](https://autohotkey.com/docs/commands/Gui.htm)	|  
|:---	|:---	|  
|`@param string` $command	|command from documentation	|  
|`@param string` $param1	|param from documentation	|  
|`@param string` $param2	|param from documentation	|  
|`@param string` $param3	|param from documentation	|  
|`@return self`	|	|  

##  

| __show__( [$options] )	|Wrapper for [Gui, Show](https://autohotkey.com/docs/commands/Gui.htm#Show)	|  
|:---	|:---	|  
|`@param string` $options	|options from documentation	|  
|`@return self`	|	|  

##  

| __options__( [$options] )	|Wrapper for [Gui +/- option](https://autohotkey.com/docs/commands/Gui.htm#Options)	|  
|:---	|:---	|  
|`@param string` $options	|options from documentation	|  
|`@return self`	|	|  

##  

| __alwaysOnTop__( [$toggle] )	|Set window always on top	|  
|:---	|:---	|  
|`@param boolean` [ $toggle=true ]	|	|  
|`@return self`	|	|  

##  Hide & restore  

| __hide__()	|Hide gui to tray	|  
|:---	|:---	|  

##  

| __restore__()	|Restore gui from tray	|  
|:---	|:---	|  


##  Submit, close & exit methods  

| __submit__()	|Submit gui	|  
|:---	|:---	|  
|`@return {control_name:value}`	|	|  

##  

| __close__()	|Close window	|  
|:---	|:---	|  

##  

| __exit__()	|Exit script	|  
|:---	|:---	|  
## Examples  [include:\gui-methods.ahk]  










  