# Key press events  

__[List of key names](https://autohotkey.com/docs/KeyList.htm#General_keys)__  
## Examples  

``` php
$Gui.Events.Key    .onEscape("onKeyPress", "onEscape" )     .onEscape("close")        .onEnter("onKeyPress", "onEnter" )     .onEnter("close")        .on("number", "onKeyPress" )     ; // "number" is for numbers 0-9    .on("Space", "onKeyPress" )                       ; // modifiers are passed to $Event object    .on(["control", "shift", "space"], "onKeyPress" ) ; // fired only if modifier keys are pressed    .on(["control", "lwin",  "X"], "onKeyPress" )     /** onKeyPress*/onKeyPress($Event:="", $params*){    $Event.message()}
```  