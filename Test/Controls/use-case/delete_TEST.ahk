#SingleInstance force


Gui, Add, Text, w300, Use Window Spy && hover over each button, see Button1 2 && 3, press Delete Me, then hover again...Delete Me was really deleted.
Gui, Add, Button, section, Test
Gui, Add, Button, ys, Delete Me
Gui, Add, Button, ys, Keep Me
Gui, Show ;, w300 h100 ;, AutoSize

WM_CLOSE=0x10
return

ButtonDeleteMe:
PostMessage, %WM_CLOSE%, , , Delete Me
return

GuiClose:
ExitApp