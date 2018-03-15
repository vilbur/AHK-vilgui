; ======================================================================================================================

; https://autohotkey.com/board/topic/80686-class-guilistviewex-added-functions-for-gui-listviews/

; Namespace: GuiListViewEx

; Function: Wrapper class to provide additional functions for GUI ListView controls.

; AHK version: 1.1.07.03

; Language: English

; Tested on: Win XPSP3 & VistaSP2 (x86/U32), 7 (x64/U64)

; Version: 1.0.00.00/2012-05-19/just me

; ======================================================================================================================

; This software is provided 'as-is', without any express or implied warranty.

; In no event will the authors be held liable for any damages arising from the use of this software.

; ======================================================================================================================

Class GuiListViewEx {

Static HDM_GETITEMCOUNT := 0x1200

Static LVM_APPROXIMATEVIEWRECT := 0x1040

Static LVM_FINDITEM := A_IsUnicode ? 0x1053 : 0x100D ; LVM_FINDITEMW : LVM_FINDITEMA

Static LVM_GETCOLUMNORDERARRAY := 0x103B

Static LVM_GETCOLUMNWIDTH := 0x101D

Static LVM_GETCOUNTPERPAGE := 0x1028

Static LVM_GETITEMRECT := 0x100E

Static LVM_GETHEADER := 0x101F

Static LVM_GETSUBITEMRECT := 0x1038

Static LVM_GETTOPINDEX := 0x1027

Static LVM_ISITEMVISIBLE := 0x10B6

Static LVM_SETBKIMAGE := A_IsUnicode ? 0x108A : 0x1044 ; LVM_SETBKIMAGEW : LVM_SETBKIMAGEA

Static LVM_SETCOLUMNORDERARRAY := 0x103A

Static LVM_SUBITEMHITTEST := 0x1039

Static OSVERSION := (V := DllCall("Kernel32.dll\GetVersion", "UInt") & 0xFF) . "." . ((V >> 8) & 0xFF)

; ===================================================================================================================

; PUBLIC METHOD CalcViewSize

; ===================================================================================================================

CalcViewSize(HLV, Items = 0) {

Result := False

SendMessage, This.LVM_APPROXIMATEVIEWRECT, Items - 1, 0, , % "ahk_id " . HLV

If (ErrorLevel <> "FAIL") {

Result := {}

Result.W := (ErrorLevel & 0xFFFF)

Result.H := (ErrorLevel >> 16) & 0xFFFF

}

Return Result

}

; ===================================================================================================================

; PUBLIC METHOD FindString

; ===================================================================================================================

FindString(HLV, Str, Start = 0, Partial = False) {

Static LVFI_PARTIAL := 0x0008

Static LVFI_STRING := 0x0002

Static LVFISize := 40

VarSetCapacity(LVFINDINFO, LVFISize, 0)

Flags := LVFI_STRING

If (Partial)

Flags |= LVFI_PARTIAL

NumPut(Flags, LVFINDINFO, 0, "UInt")

NumPut(&Str, LVFINDINFO, A_PtrSize, "Ptr")

SendMessage, This.LVM_FINDITEM, Start - 1, &LVFINDINFO, , ahk_id %HLV%

Return (ErrorLevel > 0x7FFFFFFF ? 0 : ErrorLevel + 1)

}

; ===================================================================================================================

; PUBLIC METHOD GetColumnOrder

; ===================================================================================================================

GetColumnOrder(HLV) {

Header := This.GetHeader(HLV)

SendMessage, This.HDM_GETITEMCOUNT, 0, 0, , ahk_id %Header%

Cols := ErrorLevel

VarSetCapacity(COA, Cols * 4, 0)

SendMessage, This.LVM_GETCOLUMNORDERARRAY, Cols, &COA, , % "ahk_id " . HLV

Result := ErrorLevel

ColArray := []

Loop, %Cols%

ColArray.Insert(NumGet(COA, 4 * (A_Index - 1), "Int") + 1)

Return (Result = "FAIL" ? False : ColArray)

}

; ===================================================================================================================

; PUBLIC METHOD GetColumnWidth

; ===================================================================================================================

GetColumnWidth(HLV, Column) {

SendMessage, This.LVM_GETCOLUMNWIDTH, Column - 1, 0, , % "ahk_id " . HLV

Result := ErrorLevel

Return (Result = "FAIL" ? -1 : Result)

}

; ===================================================================================================================

; PUBLIC METHOD GetCountPerPage

; ===================================================================================================================

GetCountPerPage(HLV) {

SendMessage, This.LVM_GETCOUNTPERPAGE, 0, 0, , % "ahk_id " . HLV

Return (ErrorLevel = "FAIL" ? False : ErrorLevel)

}

; ===================================================================================================================

; PUBLIC METHOD GetHeader

; ===================================================================================================================

GetHeader(HLV) {

SendMessage, This.LVM_GETHEADER, 0, 0, , % "ahk_id " . HLV

Return (ErrorLevel = "FAIL" ? False : ErrorLevel)

}

; ===================================================================================================================

; PUBLIC METHOD GetItemRect

; ===================================================================================================================

GetItemRect(HLV, Row = 1, LVIR = 0) {

Result := False

VarSetCapacity(RECT, 16, 0)

NumPut(LVIR, RECT, 0, "Int")

SendMessage, This.LVM_GETITEMRECT, Row - 1, &RECT, , % "ahk_id " . HLV

If (ErrorLevel <> "FAIL") {

Result := {}

Result.X := NumGet(RECT, 0, "Int")

Result.Y := NumGet(RECT, 4, "Int")

Result.R := NumGet(RECT, 8, "Int")

Result.B := NumGet(RECT, 12, "Int")

Result.W := Result.R - Result.X

Result.H := Result.B - Result.Y

}

Return Result

}

; ===================================================================================================================

; PUBLIC METHOD GetRowHeight

; ===================================================================================================================

GetRowHeight(HLV, Row = 1) {

If !IsObject(Result := This.GetItemRect(HLV, Row))

Return False

Return Result.H

}

; ===================================================================================================================

; PUBLIC METHOD GetSubItemRect

; ===================================================================================================================

GetSubItemRect(HLV, Row, Column, LVIR = 0) {

Result := False

VarSetCapacity(RECT, 16, 0)

NumPut(LVIR, RECT, 0, "Int")

NumPut(Column - 1, RECT, 4, "Int")

If (Column = 1) {

W := This.GetColumnWidth(HLV, 1)

}

SendMessage, This.LVM_GETSUBITEMRECT, Row - 1, &RECT, , % "ahk_id " . HLV

If (ErrorLevel <> "FAIL") {

Result := {}

Result.X := NumGet(RECT, 0, "Int")

Result.Y := NumGet(RECT, 4, "Int")

Result.R := Column = 1 ? Result.X + W : NumGet(RECT, 8, "Int")

Result.B := NumGet(RECT, 12, "Int")

Result.W := Column = 1 ? W : Result.R - Result.X

Result.H := Result.B - Result.Y

}

Return Result

}

; ===================================================================================================================

; PUBLIC METHOD GetTopIndex

; ===================================================================================================================

GetTopIndex(HLV) {

SendMessage, This.LVM_GETTOPINDEX,0, 0, , % "ahk_id " . HLV

Result := ErrorLevel

Return (Result = "FAIL" ? False : Result + 1)

}

; ===================================================================================================================

; PUBLIC METHOD IsRowVisible

; ===================================================================================================================

IsRowVisible(HLV, Row) {

SendMessage, This.LVM_ISITEMVISIBLE, Row - 1, 0, , % "ahk_id " . HLV

Result := ErrorLevel

Return (Result = "FAIL" ? False : Result)

}

; ===================================================================================================================

; PUBLIC METHOD SetColumnOrder

; ===================================================================================================================

SetColumnOrder(HLV, ColArray) {

Cols := ColArray.MaxIndex()

VarSetCapacity(COA, Cols * 4, 0)

For I, R In ColArray

NumPut(R - 1, COA, (A_Index - 1) * 4, "Int")

SendMessage, This.LVM_SETCOLUMNORDERARRAY, Cols, &COA, , % "ahk_id " . HLV

Result := ErrorLevel

Return (Result = "FAIL" ? False : Result)

}

; ===================================================================================================================

; PUBLIC METHOD SubitemHitTest

; ===================================================================================================================

SubitemHitTest(HLV, X = -1, Y = -1) {

VarSetCapacity(POINT, 8, 0)

If (X = -1) Or (Y = -1) {

DllCall("User32.dll\GetCursorPos", "Ptr", &POINT)

DllCall("User32.dll\ScreenToClient", "Ptr", HLV, "Ptr", &POINT)

VarSetCapacity(LVHITTESTINFO, 24, 0)

NumPut(NumGet(POINT, 0, "Int"), LVHITTESTINFO, 0, "Int")

NumPut(NumGet(POINT, 4, "Int"), LVHITTESTINFO, 4, "Int")

} Else {

NumPut(X, LVHITTESTINFO, 0, "Int")

NumPut(Y, LVHITTESTINFO, 4, "Int")

}

SendMessage, This.LVM_SUBITEMHITTEST, 0, &LVHITTESTINFO, , % "ahk_id " . HLV

If (ErrorLevel = -1)

Return 0

Return (NumGet(LVHITTESTINFO, 16, "Int") + 1)

}

; ===================================================================================================================

; PUBLIC METHOD SetBackgroundImage

; ===================================================================================================================

SetBackgroundImage(HLV, ImagePath, Width = "", Height = "") {

Static STM_GETIMAGE := 0x0173

Static LVBKIF_SOURCE_NONE := 0x00000000

Static LVBKIF_SOURCE_HBITMAP := 0x00000001

Static LVBKIF_SOURCE_URL := 0x00000002

Static LVBKIF_SOURCE_MASK := 0x00000003

Static LVBKIF_STYLE_NORMAL := 0x00000000

Static LVBKIF_STYLE_TILE := 0x00000010

Static LVBKIF_STYLE_MASK := 0x00000010

Static LVBKIF_FLAG_TILEOFFSET := 0x00000100

Static LVBKIF_TYPE_WATERMARK := 0x10000000

Static LVBKIF_FLAG_ALPHABLEND := 0x20000000

Static LVM_SETEXTENDEDLISTVIEWSTYLE := 0x1036

Static LVS_EX_DOUBLEBUFFER := 0x00010000

HBITMAP := 0

If (ImagePath) And FileExist(ImagePath) {

W := H := ""

If (Width = "") And (Height = "") {

Size := This.CalcViewSize(HLV, This.GetCountPerPage(HLV))

ControlGetPos, , , , HH, , % "ahk_id " . This.GetHeader(HLV)

W := "w" . Size.W

H := "h" . Size.H - HH

} Else {

If (Width != "")

W := "w" . Width

If (Height != "")

H := "h" . Height

}

Gui, GuiListViewExGui:Add, Pic, %W% %H% AltSubmit HwndHPic, %ImagePath%

SendMessage, STM_GETIMAGE, 0, 0, , ahk_id %HPic%

HBITMAP := ErrorLevel

If !(HBITMAP)

Return False

}

; Set extended style LVS_EX_DOUBLEBUFFER to avoid drawing issues

SendMessage, LVM_SETEXTENDEDLISTVIEWSTYLE, LVS_EX_DOUBLEBUFFER, LVS_EX_DOUBLEBUFFER, , % "ahk_id " . HLV

Flags := LVBKIF_TYPE_WATERMARK

If (This.OSVERSION >= 6) ; LVBKIF_FLAG_ALPHABLEND prevents to show the image on WinXP

Flags |= LVBKIF_FLAG_ALPHABLEND

Size := (!(A_PtrSize) || (A_PtrSize = 4)) ? 24 : 40

VarSetCapacity(LVBKIMAGE, Size, 0)

NumPut(Flags, LVBKIMAGE, 0, "UInt")

NumPut(HBITMAP, LVBKIMAGE, (Size = 24 ? 4 : 8))

SendMessage, This.LVM_SETBKIMAGE, 0, &LVBKIMAGE, , % "ahk_id " . HLV

Return (ErrorLevel = "FAIL" ? False : ErrorLevel)

}

}

; ======================================================================================================================