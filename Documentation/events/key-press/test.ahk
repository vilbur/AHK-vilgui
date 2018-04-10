#SingleInstance force
Gui, Margin, 20, 20
Gui, Add, Text,, Pressed Key
Gui, Add, Edit, vMyEdit
Gui, Show, h100 w200

WM_KEYDOWN := 0x100
OnMessage(WM_KEYDOWN, "WM_KeyDown") 

WM_KeyDown(W, L, M, H) { 
		FileAppend, % W "`n" L "`n" M "`n" , test.txt

	;$key	:=  GetKeyName(Format("vk{:x}", W))
	;MsgBox,262144,key, %$key%,3
} 