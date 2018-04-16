# Gui events  
* onSubmit  
* onEscape  
* onClose  
* onExit  
## Events methods  
| __onSubmit__( $callback, $params*, $params )    |Fired on gui is submitted.    |  
|:---    |:---    |  
|`@param string` $callback    |callback function "close\|exit\|false\|customCallback"    |  
|`@param string` $params*    |    |  
|`@param mixed` $params    |any number of parameters    |  
|`@return self`    |    |  
##  
| __onClose__( $callback, $params* )    |Fired on gui close with "X" button.    |  
|:---    |:---    |  
|`@param string` $callback    |    |  
|`@param string` $params*    |    |  
|`@return self`    |    |  
##  
| __onExit__( $callback, $params* )    |Fired on gui is exiting script.    |  
|:---    |:---    |  
|`@param string` $callback    |    |  
|`@param string` $params*    |    |  
|`@return self`    |    |  
##  

__@pram $callback__  
$callback := __"customFunction"__ // custom callback function  
$callback := __"close\|exit\|false\|callbackFn"__ // default callbacks, fired after custom callback  
$callback := __false__ // remove callbacks  
__@pram $params__  
Any number of parameters  
First parameter passed to callback is __[$Event](Documentation/events/event/)__ object  

## Examples  

``` php
$Gui.Events.Gui    .onSubmit("callbackGui", "onSubmit Custom")     .onSubmit("close")        .onClose("callbackGui", "onClose Custom")        .onClose("exit")        .onExit("confirmExit", "Exit script ?")        .onExit(false) ; remove callback /** callbackGui*/callbackGui($Event:="", $params*){    MsgBox,262144,callbackGui, % $params[1] "`n" $params[2] "`n" $params[3],5    $Event.message()}/** onExit callback must return true to exit script*/confirmExit($Event:="", $params*){    MsgBox, 262148,, % $params[1]    IfMsgBox, Yes        return true}
```  