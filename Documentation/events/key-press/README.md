# Events  

## Key Events  




## Examples  

``` php
$Gui.Controls.layout("row")            $Gui.Events.Key    .onEscape("callbackGui", "onEscape param", "Custom")     .onEscape("close")        ;.onExit(false) ; remove callbacks/** callbackGui*/callbackGui($Event:="", $params*){    MsgBox,262144,callbackGui, % $params[1] "`n" $params[2] "`n" $params[3],5    $Event.message()}
```  