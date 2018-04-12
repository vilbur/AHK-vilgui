# Key press events  

__[List of key names](https://autohotkey.com/docs/KeyList.htm#General_keys)__  
## Examples  
``` php
$Gui.Events.Key    .onEscape("callbackKeyPress", "onEscape" )     .onEscape("close")        .onEnter("callbackKeyPress", "onEnter" )     .onEnter("close")    .on("Space", "callbackKeyPress", "on Space" )    .on("1", "callbackKeyPress", "Number 1" )    .on("1", "callbackKeyPress", "on Space" )         /** callbackKeyPress*/callbackKeyPress($Event:="", $params*){    MsgBox,262144,callbackKeyPress, % $params[1] "`n" $params[2] "`n" $params[3],5    $Event.message()}
```  