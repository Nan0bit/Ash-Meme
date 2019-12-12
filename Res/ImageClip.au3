#include-once
#include <ClipBoard.au3>
#include <GDIPlus.au3>
#include <WinAPI.au3>

;===============================================================================
;
; Function Name:   _ImageToClip
; Description::    Copies all Image Files to ClipBoard
; Parameter(s):    $Path -> Path of image
; Requirement(s):  GDIPlus.au3
; Return Value(s): Success: 1
;                  Error: 0 and @error:
;                          1 -> Error in FileOpen
;                          2 -> Error when setting to Clipboard
; Author(s):
;
;===============================================================================
;
Func _ImageToClip($Path)
	_GDIPlus_Startup()
	Local $hImg = _GDIPlus_ImageLoadFromFile($Path)
	If $hImg = 0 Then Return SetError(1,0,0)
	Local $hBitmap = _GDIPlus_ImageCreateGDICompatibleHBITMAP($hImg)
	_GDIPlus_ImageDispose($hImg)
	_GDIPlus_Shutdown()
	Local $ret = _ClipBoard_SetHBITMAP($hBitmap)
	Return 1
EndFunc

;===============================================================================
;
; Function Name:   _ClipBoard_SetHBITMAP
; Description::    Sets a HBITAMP as ClipBoardData
; Parameter(s):    $hBitmap -> Handle to HBITAMP from GDI32, NOT GDIPlus
; Requirement(s):  ClipBoard.au3
; Return Value(s): Success: 1 ; Error: 0 And @error = 1
; Author(s):       Prog@ndy
; Notes:           To use Images from GDIplus, convert them with _GDIPlus_ImageCreateGDICompatibleHBITMAP
;
;===============================================================================
;
Func _ClipBoard_SetHBITMAP($hBitmap,$Empty = 1)
	_ClipBoard_Open(_AutoItWinGetHandle())
	If $Empty Then _ClipBoard_Empty()
	_ClipBoard_SetDataEx( $hBitmap, $CF_BITMAP)
	_ClipBoard_Close()
	If Not _ClipBoard_IsFormatAvailable($CF_BITMAP)  Then
		Return SetError(1,0,0)
	EndIf
EndFunc

;===============================================================================
;
; Function Name:   _GDIPlus_ImageCreateGDICompatibleHBITMAP
; Description::    Converts a GDIPlus-Image to GDI-combatible HBITMAP
; Parameter(s):    $hImg -> GDIplus Image object
; Requirement(s):  GDIPlus.au3
; Return Value(s): HBITMAP, compatible with ClipBoard
; Author(s):       Prog@ndy
;
;===============================================================================
;

Func _GDIPlus_ImageCreateGDICompatibleHBITMAP($hImg)
	Local $hBitmap2 = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImg)
	Local $hBitmap = _WinAPI_CopyImage($hBitmap2,0,0,0,$LR_COPYDELETEORG+$LR_COPYRETURNORG)
	_WinAPI_DeleteObject($hBitmap2)
	Return $hBitmap
EndFunc

;===============================================================================
;
; Function Name:   _AutoItWinGetHandle
; Description::    Returns the Windowhandle of AutoIT-Window
; Parameter(s):    --
; Requirement(s):  --
; Return Value(s): Autoitwindow Handle
; Author(s):       Prog@ndy
;
;===============================================================================

Func _AutoItWinGetHandle()
	Local $oldTitle = AutoItWinGetTitle()
	Local $x = Random(1248578,1249780)
	AutoItWinSetTitle("qwrzu"&$x)
	Local $y = WinGetHandle("qwrzu"&$x)
	AutoItWinSetTitle($oldTitle)
	Return $y
EndFunc

; #####################################################################
; #####################################################################