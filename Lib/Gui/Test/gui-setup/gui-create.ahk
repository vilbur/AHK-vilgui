$Gui.Events.Gui.onClose("exit")

$Gui.resizeable()
	.minSize(256,64)
	.alwaysOnTop()
	.autosize()	; autoresize gui by content
	.create()