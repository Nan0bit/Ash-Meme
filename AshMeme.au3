#Region --- Start ---
#include <Res\ImageClip.au3>
#RequireAdmin
Global $Paused
Global $pToggle = False
Global $rAsh = 0
HotKeySet("^v", "Ash")
HotKeySet("{END}", "ToasterBath")
HotKeySet("{PAUSE}", "Pause")


Func ToasterBath()
	Sleep(100)
	Exit 0
EndFunc   ;==>Terminate

Func Pause()
	$Paused = Not $Paused
	If $pToggle == False Then
		Send("{SCROLLLOCK ON}")
		$pToggle = True
	Else
		Send("{SCROLLLOCK OFF}")
		$pToggle = False
	EndIf
	While $Paused
		Sleep(100)
	WEnd
EndFunc   ;==>TogglePause

While 1
	Sleep(50)
WEnd

Func rAsh()
	$rAsh = Random(1, 10, 1)
EndFunc

Func Ash()
	rAsh()
	Local $Path = @ScriptDir & "\Res\" & $rAsh & ".jpg"
	_ImageToClip($Path)
	Send("+{INS}")
EndFunc   ;==>Ash
#EndRegion --- Start ---
