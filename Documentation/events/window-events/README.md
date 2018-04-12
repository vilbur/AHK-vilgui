# Window events  

``` php
$Gui.Events.Window    .bind("created",    "callbackWindow", "On created")    .bind("close",    "callbackWindow", "On close")        .bind("change",    "callbackWindow", "On change")        .bind("focus",    "callbackWindow", "On focus")    .bind("blur",    "callbackWindow", "On blur")    /** callbackWindow*/callbackWindow($Event:="", $params*){    $Event.message()}
```  