# Window events  


``` php
$Gui.Events.Window    .on("created", "onWindow", "On created")    .on("close",   "onWindow", "On close")        .on("focus",   "onWindow", "On focus")    .on("blur",    "onWindow", "On blur")        .on("size",       "onWindow", "On size")    .on("move",       "onWindow", "On move")            .on("sizedmoved", "onWindow", "On sizedmoved")        /** onWindow*/onWindow($Event:="", $params*){    $Event.message(1)}
```  