; Custom Keys for KP Radiologists

; by Jason Balkman, with contributions from Phillip Cheng MD MS

; jason.d.balkman@kp.org

; uses AHKHID from https://github.com/jleb/AHKHID

#Include AHKHID.ahk

#SingleInstance, force

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

; GLOBALS
HK1m    := ""
HK1     := ""
HK2m    := ""
HK2     := ""
HK4m    := ""
HK4     := ""
HK8m    := ""
HK8     := ""
HK10m   := ""
HK10    := ""
HK20m   := ""
HK20    := ""
HK40m   := ""
HK40    := ""
HK80m   := ""
HK80    := ""
HK100m  := ""
HK100   := ""
HK200m  := ""
HK200   := ""
HK400m  := ""
HK400   := ""
HK800m  := ""
HK800   := ""
HK1000m := ""
HK1000  := ""

PDSK1    := ""
setPDSK1 := ""
;IDSK1    := ""
;setIDSK1 := ""
PDSK2    := ""
setPDSK2 := ""
;IDSK2    := ""
;setIDSK2 := ""
PDSK3    := ""
setPDSK3 := ""
;IDSK3    := ""
;setIDSK3 := ""

hkArr := [ "F13","F14","F15","F16","F17","F18"
            ,"F20","F21","F22","F23","F24","+^F9"
            ,"+^F10","^F1","^F2","^F3","^F4","^F5"
            ,"^F6","^F8","^F9","^F10","^F11","^F12"
            ,"+F21","+F22","!F1","!F2"]

hkArrLen := hkArr.MaxIndex()

hotkeylist = Pick 1|Pick 2|Pick 3|Pick 4|Pick 5|Pick 6
    |Sign Report|Delete|Undo That|Previous Field|Next Field|Go To Findings
    |Go To Impression|Insert History|Copy Summary|Patient eConsult|Ancillary Order|Number Paragraphs
    |impressionPlus|eConsult|eConsult History|Calc Volume|HC Expand|HC Fullscreen
    |Delete Previous Word|Delete Next Word|Snap To Pacs|Snap To Report|None/Custom

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

FileInstall,custom.png, %A_Temp%\custom.png,1
FileInstall,bones.png, %A_Temp%\bones.png,1
FileInstall,pm_illustrated.png, %A_Temp%\pm_illustrated.png,1

myIniFile := "C:\Users\" . A_UserName . "\Documents\KP_CustomKeys.ini"

if not (FileExist(myIniFile)) { ; creates the ini file if it does not exist
FileAppend,
(
[HotKeys]
), % myIniFile, utf-16 ; save your ini file asUTF-16LE
} else { ; read and initialize the global hotkey variables
    ReadAndInit()
}

GetKeys(searchStr, ByRef modifiers, ByRef keys) 
{
    needleRegEx := "([\^\!\+]*)(.*)"
    FoundPos := RegExMatch(searchStr, needleRegEx, match)
    modifiers := match1
    keys := match2
}

SetHotKey(dk, ByRef setdk, app, num)
{
    if (dk != "") {
        setdk := dk
        ;MsgBox setting hot key %setdk% for %app%_DisableKey%num%
        try {
            if (app = "PS360") {
                Hotkey, IfWinActive, PowerScribe
            } else {
                ;Hotkey, IfWinActive, Philips
            }
            Hotkey, %setdk%, DisableKey
            Hotkey, %setdk%, On
        }
    } else {
        if (setdk != "") {
            ;MsgBox disabling hot key %dk% from prior %setdk%
            try {
                if (app = "PS360") {
                    Hotkey, IfWinActive, PowerScribe
                } else {
                    ;Hotkey, IfWinActive, Philips
                }
                Hotkey, %setdk%, Off
            }
        }
    }
}

ReadAndInit()
{
    local TRNS, TABB, DICT, TABF, RWND, FFWD, STPP, BUTA, ENTS, BUTB, LMSB, RMSB, TRGR

    IniRead, TRNS, % myIniFile, HotKeys, TRANSCRIBE
    IniRead, TABB, % myIniFile, HotKeys, TAB_BACKWARD
    IniRead, DICT, % myIniFile, HotKeys, DICTATE
    IniRead, TABF, % myIniFile, HotKeys, TAB_FORWARD
    IniRead, RWND, % myIniFile, HotKeys, REWIND
    IniRead, FFWD, % myIniFile, HotKeys, FAST_FORWARD
    IniRead, STPP, % myIniFile, HotKeys, STOP_PLAY
    IniRead, BUTA, % myIniFile, HotKeys, BUTTON_A
    IniRead, ENTS, % myIniFile, HotKeys, ENTER_SELECT
    IniRead, BUTB, % myIniFile, HotKeys, BUTTON_B
    IniRead, LMSB, % myIniFile, HotKeys, LEFT_MOUSE_BUTTON
    IniRead, RMSB, % myIniFile, HotKeys, RIGHT_MOUSE_BUTTON
    IniRead, TRGR, % myIniFile, HotKeys, TRIGGER

    IniRead, PDSK1, % myIniFile, HotKeys, PS360_DISABLE_KEY1
    ;IniRead, IDSK1, % myIniFile, HotKeys, INTEL_DISABLE_KEY1
    IniRead, PDSK2, % myIniFile, HotKeys, PS360_DISABLE_KEY2
    ;IniRead, IDSK2, % myIniFile, HotKeys, INTEL_DISABLE_KEY2
    IniRead, PDSK3, % myIniFile, HotKeys, PS360_DISABLE_KEY3
    ;IniRead, IDSK3, % myIniFile, HotKeys, INTEL_DISABLE_KEY3

    SetHotKey(PDSK1, setPDSK1, "PS360", 1)
    ;SetHotKey(IDSK1, setIDSK1, "INTEL", 1)
    SetHotKey(PDSK2, setPDSK2, "PS360", 2)
    ;SetHotKey(IDSK2, setIDSK2, "INTEL", 2)
    SetHotKey(PDSK3, setPDSK3, "PS360", 3)
    ;SetHotKey(IDSK3, setIDSK3, "INTEL", 3)

    GetKeys(TRNS, HK1m, HK1)
    GetKeys(TABB, HK2m, HK2)
    GetKeys(DICT, HK4m, HK4)
    GetKeys(TABF, HK8m, HK8)
    GetKeys(RWND, HK10m, HK10)
    GetKeys(FFWD, HK20m, HK20)
    GetKeys(STPP, HK40m, HK40)
    GetKeys(BUTA, HK80m, HK80)
    GetKeys(ENTS, HK100m, HK100)
    GetKeys(BUTB, HK200m, HK200)
    GetKeys(LMSB, HK400m, HK400)
    GetKeys(RMSB, HK800m, HK800)
    GetKeys(TRGR, HK1000m, HK1000)
}

ObjIndexOf(obj, item, case_sensitive:=true)
{
	for i, val in obj {
		if (case_sensitive ? (val == item) : (val = item))
			return i
	}
    return i+1
}

ObjItemOf(obj, index) {

    if (index > obj.MaxIndex()) {
        return ""
    } else {
        return obj[index]
    }
}

SetHotKeyTextAndEnable(index, value, arr, ByRef text, ptr) {
    global hkArrLen
    
    if(index != hkArrLen + 1) {
        if (arr = False)
            text := ""
        else 
            text := ObjItemOf(arr, index)
        
        if (ptr != False) {
            GuiControl, Disable, %ptr%
        }
    } else {
        text := value
        
        if (ptr != False) {
            GuiControl, Enable, %ptr%
        }
    }
}

Menu, Tray, NoStandard
Menu, Tray, Icon, %A_Temp%\custom.png
Menu, Tray, Tip, Custom PS360/PM for KP Rads (active)

;-------------------------

Menu, Tray, Add, About, about
Menu, Tray, Add

;-------------------------

Menu, Tray, Add, Active, active
Menu, Tray, ToggleCheck, Active
Menu, Tray, Default, Active
active:=1

Menu, Tray, Add, Settings, settings
;-------------------------

Menu, Tray, Add
Menu, Tray, Add, Exit, exit

;-------------------------

Gui +hwndhwnd ; stores window handle in hwnd

AHKHID_Register(1,0,hwnd,RIDEV_PAGEONLY + RIDEV_INPUTSINK) 

    ; Usage Page 1, Usage 0

    ; RIDEV_PAGEONLY only devices with top level collection is usage page 1 (Powermic)

    ; RIDEV_INPUTSINK enables caller to receive input even when not in foreground

OnMessage(0x00FF, "InputMsg")  ; intercept WM_INPUT

Return

settings:

    IniRead, TRNS, % myIniFile, HotKeys, TRANSCRIBE
    IniRead, TABB, % myIniFile, HotKeys, TAB_BACKWARD
    IniRead, TABF, % myIniFile, HotKeys, TAB_FORWARD
    IniRead, DICT, % myIniFile, HotKeys, DICTATE
    IniRead, RWND, % myIniFile, HotKeys, REWIND
    IniRead, STPP, % myIniFile, HotKeys, STOP_PLAY
    IniRead, FFWD, % myIniFile, HotKeys, FAST_FORWARD
    IniRead, BUTA, % myIniFile, HotKeys, BUTTON_A
    IniRead, ENTS, % myIniFile, HotKeys, ENTER_SELECT
    IniRead, BUTB, % myIniFile, HotKeys, BUTTON_B
    IniRead, LMSB, % myIniFile, HotKeys, LEFT_MOUSE_BUTTON
    IniRead, RMSB, % myIniFile, HotKeys, RIGHT_MOUSE_BUTTON
    IniRead, TRGR, % myIniFile, HotKeys, TRIGGER

    IniRead, PDSK1, % myIniFile, HotKeys, PS360_DISABLE_KEY1
    ;IniRead, IDSK1, % myIniFile, HotKeys, INTEL_DISABLE_KEY1
    IniRead, PDSK2, % myIniFile, HotKeys, PS360_DISABLE_KEY2
    ;IniRead, IDSK2, % myIniFile, HotKeys, INTEL_DISABLE_KEY2
    IniRead, PDSK3, % myIniFile, HotKeys, PS360_DISABLE_KEY3
    ;IniRead, IDSK3, % myIniFile, HotKeys, INTEL_DISABLE_KEY3

    Gui, Settings:New
    Gui, Settings:Default
    Gui, Add, Picture, w300 h400, %A_Temp%\pm_illustrated.png

    txsp := 10
    ddsp := 20

    Gui, Add, Text, x425 y10, FIXED KEY
    Gui, Add, Text, x550 y10, CUSTOM KEY
    
    temp := ObjIndexOf(hkArr, TRNS)
    Gui, Add, Text, x315 y+%txsp%, TRANSCRIBE
    Gui, Add, DropDownList, x425 yp Choose%temp%    altsubmit vTranscribe gDDselect,    %hotkeylist%
    Gui, Add, Hotkey, x550 yp vcTRNS HwndcTRNSHwnd, %cTRNS%
    SetHotKeyTextAndEnable(temp, TRNS, hkArr, cTRNS, cTRNSHwnd)

    temp := ObjIndexOf(hkArr, TABB)
    Gui, Add, Text, x315 y+%txsp%, TAB BACKWARD
    Gui, Add, DropDownList, x425 yp Choose%temp%    altsubmit vTabBackward gDDselect,      %hotkeylist%
    Gui, Add, Hotkey, x550 yp vcTABB HwndcTABBHwnd, %cTABB%
    SetHotKeyTextAndEnable(temp, TABB, hkArr, cTABB, cTABBHwnd)

    temp := ObjIndexOf(hkArr, TABF)
    Gui, Add, Text, x315 y+%txsp%, TAB FORWARD
    Gui, Add, DropDownList, x425 yp Choose%temp%    altsubmit vTabForward gDDselect,       %hotkeylist%
   Gui, Add, Hotkey, x550 yp vcTABF HwndcTABFHwnd, %cTABF%
    SetHotKeyTextAndEnable(temp, TABF, hkArr, cTABF, cTABFHwnd)
   
    temp := ObjIndexOf(hkArr, DICT)
    Gui, Add, Text, x315 y+%txsp%, DICTATE
    Gui, Add, DropDownList, x425 yp Choose%temp%    altsubmit vDictate gDDselect,          %hotkeylist%
    Gui, Add, Hotkey, x550 yp vcDICT HwndcDICTHwnd, %cDICT%
    SetHotKeyTextAndEnable(temp, DICT, hkArr, cDICT, cDICTHwnd)
   
    temp := ObjIndexOf(hkArr, RWND)
    Gui, Add, Text, x315 y+%txsp%, REWIND
    Gui, Add, DropDownList, x425 yp Choose%temp%    altsubmit vRewind gDDselect,           %hotkeylist%
    Gui, Add, Hotkey, x550 yp vcRWND HwndcRWNDHwnd, %cRWND%
    SetHotKeyTextAndEnable(temp, RWND, hkArr, cRWND, cRWNDHwnd)
   
    temp := ObjIndexOf(hkArr, STPP)
    Gui, Add, Text, x315 y+%txsp%, STOP/PLAY
    Gui, Add, DropDownList, x425 yp Choose%temp%    altsubmit vStopPlay gDDselect,         %hotkeylist%
    Gui, Add, Hotkey, x550 yp vcSTPP HwndcSTPPHwnd, %cSTPP%
    SetHotKeyTextAndEnable(temp, STPP, hkArr, cSTPP, cSTPPHwnd)
   
    temp := ObjIndexOf(hkArr, FFWD)
    Gui, Add, Text, x315 y+%txsp%, FAST FORWARD
    Gui, Add, DropDownList, x425 yp Choose%temp%    altsubmit vFastForward gDDselect,      %hotkeylist%
    Gui, Add, Hotkey, x550 yp vcFFWD HwndcFFWDHwnd, %cFFWD%
    SetHotKeyTextAndEnable(temp, FFWD, hkArr, cFFWD, cFFWDHwnd)
   
    temp := ObjIndexOf(hkArr, BUTA)
    Gui, Add, Text, x315 y+%txsp%, BUTTON A
    Gui, Add, DropDownList, x425 yp Choose%temp%    altsubmit vButtonA gDDselect,          %hotkeylist%
    Gui, Add, Hotkey, x550 yp vcBUTA HwndcBUTAHwnd, %cBUTA%
    SetHotKeyTextAndEnable(temp, BUTA, hkArr, cBUTA, cBUTAHwnd)
   
    temp := ObjIndexOf(hkArr, ENTS)
    Gui, Add, Text, x315 y+%txsp%, ENTER/SELECT
    Gui, Add, DropDownList, x425 yp Choose%temp%    altsubmit vEnterSelect gDDselect,      %hotkeylist%
    Gui, Add, Hotkey, x550 yp vcENTS HwndcENTSHwnd, %cENTS%
    SetHotKeyTextAndEnable(temp, ENTS, hkArr, cENTS, cENTSHwnd)
   
    temp := ObjIndexOf(hkArr, BUTB)
    Gui, Add, Text, x315 y+%txsp%, BUTTON B
    Gui, Add, DropDownList, x425 yp Choose%temp%    altsubmit vButtonB gDDselect,          %hotkeylist%
    Gui, Add, Hotkey, x550 yp vcBUTB HwndcBUTBHwnd, %cBUTB%
    SetHotKeyTextAndEnable(temp, BUTB, hkArr, cBUTB, cBUTBHwnd)
   
    temp := ObjIndexOf(hkArr, LMSB)
    Gui, Add, Text, x315 y+%txsp%, LEFT MOUSE
    Gui, Add, DropDownList, x425 yp Choose%temp%    altsubmit vLeftMouseButton gDDselect,  %hotkeylist%
    Gui, Add, Hotkey, x550 yp vcLMSB HwndcLMSBHwnd, %cLMSB%
    SetHotKeyTextAndEnable(temp, LMSB, hkArr, cLMSB, cLMSBHwnd)
   
    temp := ObjIndexOf(hkArr, RMSB)
    Gui, Add, Text, x315 y+%txsp%, RIGHT MOUSE
    Gui, Add, DropDownList, x425 yp Choose%temp%    altsubmit vRightMouseButton gDDselect, %hotkeylist%
    Gui, Add, Hotkey, x550 yp vcRMSB HwndcRMSBHwnd, %cRMSB%
    SetHotKeyTextAndEnable(temp, RMSB, hkArr, cRMSB, cRMSBHwnd)
   
    temp := ObjIndexOf(hkArr, TRGR)
    Gui, Add, Text, x315 y+%txsp%, TRIGGER
    Gui, Add, DropDownList, x425 yp Choose%temp%    altsubmit vTrigger gDDselect,          %hotkeylist%
    Gui, Add, Hotkey, x550 yp vcTRGR HwndcTRGRHwnd, %cTRGR%
    SetHotKeyTextAndEnable(temp, TRGR, hkArr, cTRGR, cTRGRHwnd)

    /*
    Gui, Add, Text, x25 yp, PS360 DISABLE KEYS
    Gui, Add, Text, x150 yp, PACS DISABLE KEYS 

    Gui, Add, Hotkey, x25 y+%txsp% vPDSK1, %PDSK1%
    Gui, Add, Hotkey, x150 yp vIDSK1, %IDSK1%
    Gui, Add, Hotkey, x25 y+%txsp%  vPDSK2, %PDSK2%
    Gui, Add, Hotkey, x150 yp vIDSK2, %IDSK2%
    Gui, Add, Hotkey, x25 y+%txsp% vPDSK3, %PDSK3%
    Gui, Add, Hotkey, x150 yp vIDSK3, %IDSK3%
    */

    Gui, Add, Text, x100 yp+10, PS360 DISABLE KEYS
    Gui, Add, Hotkey, x100 y+%txsp% vPDSK1, %PDSK1%
    Gui, Add, Hotkey, x100 y+%txsp%  vPDSK2, %PDSK2%
    Gui, Add, Hotkey, x100 y+%txsp% vPDSK3, %PDSK3%
    
    Gui, Add, Button, x340 yp-40 w100 h40 gsave, Save and Close
    Gui, Add, Button, x+65 yp w100 h40 gcancel, Cancel

    Gui, Show,, Custom Keys for KP Radiologists

    Return

DDselect:    
    if (A_GuiControl = "Transcribe") {
        tempPtr := cTRNSHwnd
        GuiControlGet, Transcribe
        ctrlSet := Transcribe
    } else if (A_GuiControl = "TabBackward") {
        tempPtr := cTABBHwnd
        GuiControlGet, TabBackward
        ctrlSet := TabBackward
    } else if (A_GuiControl = "TabForward") {
        tempPtr := cTABFHwnd
        GuiControlGet, TabForward
        ctrlSet := TabForward
    } else if (A_GuiControl = "Dictate") {
        tempPtr := cDICTHwnd
        GuiControlGet, Dictate
        ctrlSet := Dictate
    } else if (A_GuiControl = "Rewind") {
        tempPtr := cRWNDHwnd
        GuiControlGet, Rewind
        ctrlSet := Rewind
    } else if (A_GuiControl = "StopPlay") {
        tempPtr := cSTPPHwnd
        GuiControlGet, StopPlay
        ctrlSet := StopPlay
    } else if (A_GuiControl = "FastForward") {
        tempPtr := cFFWDHwnd
        GuiControlGet, FastForward
        ctrlSet := FastForward
    } else if (A_GuiControl = "ButtonA") {
        tempPtr := cBUTAHwnd
        GuiControlGet, ButtonA
        ctrlSet := ButtonA
    } else if (A_GuiControl = "EnterSelect") {
        tempPtr := cENTSHwnd
        GuiControlGet, EnterSelect
        ctrlSet := EnterSelect
    } else if (A_GuiControl = "ButtonB") {
        tempPtr := cBUTBHwnd
        GuiControlGet, ButtonB
        ctrlSet := ButtonB
    } else if (A_GuiControl = "LeftMouseButton") {
        tempPtr := cLMSBHwnd
        GuiControlGet, LeftMouseButton
        ctrlSet := LeftMouseButton
    } else if (A_GuiControl = "RightMouseButton") {
        tempPtr := cRMSBHwnd
        GuiControlGet, RightMouseButton
        ctrlSet := RightMouseButton
    } else if (A_GuiControl = "Trigger") {
        tempPtr := cTRGRHwnd
        GuiControlGet, Trigger
        ctrlSet := Trigger
    }

    if (ctrlSet != hkArrLen+1) {
        GuiControl, Disable, %tempPtr%
        GuiControl,, %tempPtr%,
    } else {
        GuiControl, Enable, %tempPtr%
    }
    
    ;MsgBox A_GuiControl = %A_GuiControl%; cTRNSHwnd = %cTRNSHwnd% A_Gui = %A_Gui% ctrlSet = %ctrlSet% tempPtr = %tempPtr%

    Return

;-------------------------------------------------------------------------------
save: ; disable the old hotkey before adding a new one
;-------------------------------------------------------------------------------
    
    GuiControlGet, Transcribe
    GuiControlGet, cTRNS

    GuiControlGet, TabBackward
    GuiControlGet, cTABB

    GuiControlGet, TabForward
    GuiControlGet, cTABF

    GuiControlGet, Dictate
    GuiControlGet, cDICT

    GuiControlGet, Rewind
    GuiControlGet, cRWND

    GuiControlGet, StopPlay
    GuiControlGet, cSTPP

    GuiControlGet, FastForward
    GuiControlGet, cFFWD

    GuiControlGet, ButtonA
    GuiControlGet, cBUTA

    GuiControlGet, EnterSelect
    GuiControlGet, cENTS

    GuiControlGet, ButtonB
    GuiControlGet, cBUTB

    GuiControlGet, LeftMouseButton
    GuiControlGet, cLMSB

    GuiControlGet, RightMouseButton
    GuiControlGet, cRMSB

    GuiControlGet, Trigger
    GuiControlGet, cTRGR

    GuiControlGet, PDSK1
    GuiControlGet, IDSK1
    GuiControlGet, PDSK2
    GuiControlGet, IDSK2
    GuiControlGet, PDSK3
    GuiControlGet, IDSK3

    SetHotKeyTextAndEnable(Transcribe, cTRNS, hkArr, temp, False)
    IniWrite, %temp%, % myIniFile, HotKeys, TRANSCRIBE
    GetKeys(temp, HK1m, HK1)

    ;temp := ObjItemOf(hkArr, TabBackward)
    SetHotKeyTextAndEnable(TabBackward, cTABB, hkArr, temp, False)
    IniWrite, %temp%, % myIniFile, HotKeys, TAB_BACKWARD
    GetKeys(temp, HK2m, HK2)

    SetHotKeyTextAndEnable(TabForward, cTABF, hkArr, temp, False)
    IniWrite, %temp%, % myIniFile, HotKeys, TAB_FORWARD
    GetKeys(temp, HK8m, HK8)

    SetHotKeyTextAndEnable(Dictate, cDICT, hkArr, temp, False)
    IniWrite, %temp%, % myIniFile, HotKeys, DICTATE
    GetKeys(temp, HK4m, HK4)

    SetHotKeyTextAndEnable(Rewind, cRWND, hkArr, temp, False)
    IniWrite, %temp%, % myIniFile, HotKeys, REWIND
    GetKeys(temp, HK10m, HK10)

    SetHotKeyTextAndEnable(StopPlay, cSTPP, hkArr, temp, False)
    IniWrite, %temp%, % myIniFile, HotKeys, STOP_PLAY
    GetKeys(temp, HK40m, HK40)

    SetHotKeyTextAndEnable(FastForward, cFFWD, hkArr, temp, False)
    IniWrite, %temp%, % myIniFile, HotKeys, FAST_FORWARD
    GetKeys(temp, HK20m, HK20)

    SetHotKeyTextAndEnable(ButtonA, cBUTA, hkArr, temp, False)
    IniWrite, %temp%, % myIniFile, HotKeys, BUTTON_A
    GetKeys(temp, HK80m, HK80)

    SetHotKeyTextAndEnable(EnterSelect, cENTS, hkArr, temp, False)
    IniWrite, %temp%, % myIniFile, HotKeys, ENTER_SELECT
    GetKeys(temp, HK100m, HK100)

    SetHotKeyTextAndEnable(ButtonB, cBUTB, hkArr, temp, False)
    IniWrite, %temp%, % myIniFile, HotKeys, BUTTON_B
    GetKeys(temp, HK200m, HK200)

    SetHotKeyTextAndEnable(LeftMouseButton, cLMSB, hkArr, temp, False)
    IniWrite, %temp%, % myIniFile, HotKeys, LEFT_MOUSE_BUTTON
    GetKeys(temp, HK400m, HK400)

    SetHotKeyTextAndEnable(RightMouseButton, cRMSB, hkArr, temp, False)
    IniWrite, %temp%, % myIniFile, HotKeys, RIGHT_MOUSE_BUTTON
    GetKeys(temp, HK800m, HK800)

    SetHotKeyTextAndEnable(Trigger, cTRGR, hkArr, temp, False)
    IniWrite, %temp%, % myIniFile, HotKeys, TRIGGER
    GetKeys(temp, HK1000m, HK1000)

    IniWrite, %PDSK1%, % myIniFile, HotKeys, PS360_DISABLE_KEY1
    ;IniWrite, %IDSK1%, % myIniFile, HotKeys, INTEL_DISABLE_KEY1
    IniWrite, %PDSK2%, % myIniFile, HotKeys, PS360_DISABLE_KEY2
    ;IniWrite, %IDSK2%, % myIniFile, HotKeys, INTEL_DISABLE_KEY2
    IniWrite, %PDSK3%, % myIniFile, HotKeys, PS360_DISABLE_KEY3
    ;IniWrite, %IDSK3%, % myIniFile, HotKeys, INTEL_DISABLE_KEY3

    SetHotKey(PDSK1, setPDSK1, "PS360", 1)
    ;SetHotKey(IDSK1, setIDSK1, "INTEL", 1)
    SetHotKey(PDSK2, setPDSK2, "PS360", 2)
    ;SetHotKey(IDSK2, setIDSK2, "INTEL", 2)
    SetHotKey(PDSK3, setPDSK3, "PS360", 3)
    ;SetHotKey(IDSK3, setIDSK3, "INTEL", 3)

    Gui Destroy

    Return

;-------------------------------------------------------------------------------
cancel: ; disable the old hotkey before adding a new one
;-------------------------------------------------------------------------------

    Gui Destroy

    Return

;-------------------------------------------------------------------------------
active:
;-------------------------------------------------------------------------------

    Menu, Tray, ToggleCheck, Active

    active:=!active

    if (active=1) {

        Menu, Tray, Icon, %A_Temp%\custom.png

        Menu, Tray, Tip, Custom Keys for KP Rads (active)

    } else {

        Menu, Tray, Icon, %A_Temp%\bones.png

        Menu, Tray, Tip, Custom Keys for KP Rads (disabled)

    }

    Return

;-------------------------------------------------------------------------------
about:
;-------------------------------------------------------------------------------

    Gui +OwnDialogs

    ;Gui, About:New
    ;Gui, About:Default
    ;Gui, Add, Picture, w100 h100, %A_Temp%\cyborg.png
    ;Gui, Add, Text, ,Custom Keys for KP Radiologists
    ;Gui, Show,, About

    ;Return
    Msgbox,,Custom Keys for KP Radiologists,

    ;Gui, Add, Picture, w300 h400, %A_Temp%\cyborg.png

(

Custom Keys for KP Radiologists

v. 1.3

by Jason D. Balkman
jason.d.balkman@kp.org


)

    Return


;-------------------------------------------------------------------------------
exit:
;-------------------------------------------------------------------------------

    ExitApp

InputMsg(wParam, lParam) {

    Local r, h, vid, pid, uspg, us, data, ps360

    Critical    ;Or otherwise you could get ERROR_INVALID_HANDLE

    if (active = 1) {

        ;Get device type

        r := AHKHID_GetInputInfo(lParam, II_DEVTYPE) 

        If (r = RIM_TYPEHID) {

            h := AHKHID_GetInputInfo(lParam, II_DEVHANDLE)

            vid := AHKHID_GetDevInfo(h, DI_HID_VENDORID, True)   ; Vendor ID = 0x554 = 1364 for Dictaphone Corp.

            pid := AHKHID_GetDevInfo(h, DI_HID_PRODUCTID, True)  ; Product ID

            uspg := AHKHID_GetDevInfo(h, DI_HID_USAGEPAGE, True) ; Usage Page

            us := AHKHID_GetDevInfo(h, DI_HID_USAGE, True)       ; Usage
    

            if (vid = 1364) and (pid = 4097) and (uspg = 1) and (us = 0) {  ; we have a PowerMic!

                r := AHKHID_GetInputData(lParam, uData)

                data := NumGet(uData,2,"UShort")

                ;MsgBox, Data = %data%

                switch data

                {
                    case 0x1: ; button 1 - TRANSCRIBE

                        ;MsgBox, % HK1m . "{" . HK1 . "}"
                        send % HK1m . "{" . HK1 . "}"

                    case 0x2: ; button 2 - TAB BACKWARD

                        ;MsgBox, % HK2m . "{" . HK2 . "}"
                        send % HK2m . "{" . HK2 . "}"

                    case 0x4: ; button 4 - DICTATE

                        ;MsgBox, % HK4m . "{" . HK4 . "}"
                        send % HK4m . "{" . HK4 . "}"

                    case 0x8: ; button 8 - TAB FORWARD

                        ;MsgBox, % HK8m . "{" . HK8 . "}"
                        send % HK8m . "{" . HK8 . "}"

                    case 0x10: ; button 16 - REWIND (fixed in ps to fxn)

                        ;MsgBox, % HK10m . "{" . HK10 . "}"
                        send % HK10m . "{" . HK10 . "}"

                    case 0x20: ; button 32 - FAST FORWARD (fixed in ps to fxn)

                        ;MsgBox, % HK20m . "{" . HK20 . "}"
                        send % HK20m . "{" . HK20 . "}"

                    case 0x40: ; button 64 - STOP/PLAY (fixed in ps to fxn)

                        ;MsgBox, % HK40m . "{" . HK40 . "}"
                        send % HK40m . "{" . HK40 . "}"

                    case 0x80: ; button 128 - BUTTON A

                        ;MsgBox, % HK80m . "{" . HK80 . "}"
                        send % HK80m . "{" . HK80 . "}"

                    case 0x100: ; button 256 - ENTER/SELECT

                        ;MsgBox, % HK100m . "{" . HK100 . "}"
                        send % HK100m . "{" . HK100 . "}"

                    case 0x200: ; button 512 - BUTTON B

                        ;MsgBox, % HK200m . "{" . HK200 . "}"
                        send % HK200m . "{" . HK200 . "}"

                    case 0x400: ; button 1024 - LEFT MOUSE BUTTON

                        ;MsgBox, % HK400m . "{" . HK400 . "}"
                        send % HK400m . "{" . HK400 . "}"

                    case 0x800: ; button 2048 - RIGHT MOUSE BUTTON

                        ;MsgBox, % HK800m . "{" . HK800 . "}"
                        send % HK800m . "{" . HK800 . "}"

                    case 0x1000: ; button 4096 - TRIGGER

                        ;MsgBox, % HK1000m . "{" . HK1000 . "}"
                        send % HK1000m . "{" . HK1000 . "}"
                }
            }
        }
    }
}

;------------------------------------------------------------------
; CONTEXT-SENSITIVE HOT KEYS (Not related to Custom PowerMic)
;------------------------------------------------------------------
DisableKey:
    ;MsgBox You pressed a disabled key.
    Return