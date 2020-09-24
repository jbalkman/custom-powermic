; Custom PowerMic Buttons for KP Radiologists

; by Jason Balkman, leveraged from Phillip Cheng MD MS

; jason.d.balkman@kp.org
; phillip.cheng@med.usc.edu

; This script intercepts Powermic buttons.

; AHK Version 1.1

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

hkArr := [ "F13","F14","F15","F16","F17","F18"
            ,"F20","F21","F22","F23","F24","+^F9"
            ,"+^F10","^F1","^F2","^F3","^F4","^F5"
            ,"^F6","^F8","^F9","^F10","^F11","^F12"
            ,"+F21","+F22","!F1","!F2"]

;maxIdx := hkArr.MaxIndex()
;first := hkArr[1]
;MsgBox, Max Index - %maxIdx%
;MsgBox, First Element - %first%

hotkeylist = Pick 1|Pick 2|Pick 3|Pick 4|Pick 5|Pick 6
    |Sign Report|Delete|Undo That|Previous Field|Next Field|Go To Findings
    |Go To Impression|Insert History|Copy Summary|Patient eConsult|Ancillary Order|Number Paragraphs
    |impressionPlus|eConsult|eConsult History|Calc Volume|HC Expand|HC Fullscreen
    |Delete Previous Word|Delete Next Word|Snap To Pacs|Snap To Report|None/Other

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

FileInstall,cyborg.png, %A_Temp%\cyborg.png,1
FileInstall,bones.png, %A_Temp%\bones.png,1
FileInstall,pm_illustrated.png, %A_Temp%\pm_illustrated.png,1

myIniFile := "C:\Users\" . A_UserName . "\Documents\KP_CustomPowerMic.ini"

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

/*
GetKeyValue(hkArr, key)
{
    if (key == "F13") {        
        return 1
    } else if (key == "F14") {
        return 2
    } else if (key == "F15") { 
        return 3
    } else if (key == "F16") { 
        return 4
    } else if (key == "F17") { 
        return 5
    } else if (key == "F18") { 
        return 6
    } else if (key == "F20") { 
        return 7
    } else if (key == "F21") { 
        return 8
    } else if (key == "F22") { 
        return 9
    } else if (key == "F23") { 
        return 10
    } else if (key == "F24") { 
        return 11
    } else if (key == "^F1") { 
        return 12
    } else if (key == "^F2") { 
        return 13
    } else if (key == "^F3") { 
        return 14
    } else if (key == "^F4") { 
        return 15
    } else if (key == "^F5") { 
        return 16
    } else if (key == "^F6") { 
        return 17
    } else if (key == "^F8") { 
        return 18
    } else if (key == "^F9") { 
        return 19
    } else if (key == "^F10") { 
        return 20
    } else if (key == "^F11") { 
        return 21
    } else if (key == "^F12") { 
        return 22
    } else if (key == "+^F9") { 
        return 23
    } else if (key == "+^F10") { 
        return 24
    } else if (key == "+F21") { 
        return 25
    } else if (key == "+F22") { 
        return 26
    } else if (key == "!F1") { 
        return 27
    } else if (key == "!F2") { 
        return 28
    } else { 
        return 29 
    }
}
*/

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

Menu, Tray, NoStandard
Menu, Tray, Icon, %A_Temp%\cyborg.png
Menu, Tray, Tip, Custom PowerMic Buttons for KP Rads (active)

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

    Gui, Settings:New
    Gui, Settings:Default
    Gui, Add, Picture, w300 h400, %A_Temp%\pm_illustrated.png

    txsp := 10
    ddsp := 20

    /*
    Gui, Add, Text, x+5 y10, TRANSCRIBE
    Gui, Add, Text, xp y+%txsp%, TAB BACKWARD
    Gui, Add, Text, x315 y+%txsp%, TAB FORWARD
    Gui, Add, Text, xp y+%txsp%, DICTATE
    Gui, Add, Text, xp y+%txsp%, REWIND
    Gui, Add, Text, xp y+%txsp%, STOP/PLAY
    Gui, Add, Text, xp y+%txsp%, FAST FORWARD
    Gui, Add, Text, xp y+%txsp%, BUTTON A
    Gui, Add, Text, xp y+%txsp%, ENTER/SELECT
    Gui, Add, Text, xp y+%txsp%, BUTTON B
    Gui, Add, Text, xp y+%txsp%, LEFT MOUSE
    Gui, Add, Text, xp y+%txsp%, RIGHT MOUSE
    Gui, Add, Text, xp y+%txsp%, TRIGGER
    */
    
    temp := ObjIndexOf(hkArr, TRNS)
    Gui, Add, Text, x315 y10, TRANSCRIBE
    Gui, Add, DropDownList, x415 y10   Choose%temp%    altsubmit vTranscribe,       %hotkeylist%
    temp := ObjIndexOf(hkArr, TABB)
    Gui, Add, Text, x315 y+%txsp%, TAB BACKWARD
    Gui, Add, DropDownList, x415 yp Choose%temp%    altsubmit vTabBackward,      %hotkeylist%
    temp := ObjIndexOf(hkArr, TABF)
    Gui, Add, Text, x315 y+%txsp%, TAB FORWARD
    Gui, Add, DropDownList, x415 yp Choose%temp%    altsubmit vTabForward,       %hotkeylist%
    temp := ObjIndexOf(hkArr, DICT)
    Gui, Add, Text, x315 y+%txsp%, DICTATE
    Gui, Add, DropDownList, x415 yp Choose%temp%    altsubmit vDictate,          %hotkeylist%
    temp := ObjIndexOf(hkArr, RWND)
    Gui, Add, Text, x315 y+%txsp%, REWIND
    Gui, Add, DropDownList, x415 yp Choose%temp%    altsubmit vRewind,           %hotkeylist%
    temp := ObjIndexOf(hkArr, STPP)
    Gui, Add, Text, x315 y+%txsp%, STOP/PLAY
    Gui, Add, DropDownList, x415 yp Choose%temp%    altsubmit vStopPlay,         %hotkeylist%
    temp := ObjIndexOf(hkArr, FFWD)
    Gui, Add, Text, x315 y+%txsp%, FAST FORWARD
    Gui, Add, DropDownList, x415 yp Choose%temp%    altsubmit vFastForward,      %hotkeylist%
    temp := ObjIndexOf(hkArr, BUTA)
    Gui, Add, Text, x315 y+%txsp%, BUTTON A
    Gui, Add, DropDownList, x415 yp Choose%temp%    altsubmit vButtonA,          %hotkeylist%
    temp := ObjIndexOf(hkArr, ENTS)
    Gui, Add, Text, x315 y+%txsp%, ENTER/SELECT
    Gui, Add, DropDownList, x415 yp Choose%temp%    altsubmit vEnterSelect,      %hotkeylist%
    temp := ObjIndexOf(hkArr, BUTB)
    Gui, Add, Text, x315 y+%txsp%, BUTTON B
    Gui, Add, DropDownList, x415 yp Choose%temp%    altsubmit vButtonB,          %hotkeylist%
    temp := ObjIndexOf(hkArr, LMSB)
    Gui, Add, Text, x315 y+%txsp%, LEFT MOUSE
    Gui, Add, DropDownList, x415 yp Choose%temp%    altsubmit vLeftMouseButton,  %hotkeylist%
    temp := ObjIndexOf(hkArr, RMSB)
    Gui, Add, Text, x315 y+%txsp%, RIGHT MOUSE
    Gui, Add, DropDownList, x415 yp Choose%temp%    altsubmit vRightMouseButton, %hotkeylist%
    temp := ObjIndexOf(hkArr, TRGR)
    Gui, Add, Text, x315 y+%txsp%, TRIGGER
    Gui, Add, DropDownList, x415 yp Choose%temp%    altsubmit vTrigger,          %hotkeylist%

    Gui, Add, Button, xp y+20 gsave, Save and Close
    Gui, Add, Button, x+25 yp gcancel, Cancel
  
    Gui, Show,, Custom PowerMic Settings for KP Radiologists

    Return

;-------------------------------------------------------------------------------
save: ; disable the old hotkey before adding a new one
;-------------------------------------------------------------------------------
    
    GuiControlGet, Transcribe
    GuiControlGet, TabBackward
    GuiControlGet, TabForward
    GuiControlGet, Dictate
    GuiControlGet, Rewind
    GuiControlGet, StopPlay
    GuiControlGet, FastForward
    GuiControlGet, ButtonA
    GuiControlGet, EnterSelect
    GuiControlGet, ButtonB
    GuiControlGet, LeftMouseButton
    GuiControlGet, RightMouseButton
    GuiControlGet, Trigger

    temp := ObjItemOf(hkArr, Transcribe)
    IniWrite, %temp%, % myIniFile, HotKeys, TRANSCRIBE
    GetKeys(temp, HK1m, HK1)

    temp := ObjItemOf(hkArr, TabBackward)
    IniWrite, %temp%, % myIniFile, HotKeys, TAB_BACKWARD
    GetKeys(temp, HK2m, HK2)

    temp := ObjItemOf(hkArr ,TabForward)
    IniWrite, %temp%, % myIniFile, HotKeys, TAB_FORWARD
    GetKeys(temp, HK8m, HK8)

    temp := ObjItemOf(hkArr, Dictate)
    IniWrite, %temp%, % myIniFile, HotKeys, DICTATE
    GetKeys(temp, HK4m, HK4)

    temp := ObjItemOf(hkArr, Rewind)
    IniWrite, %temp%, % myIniFile, HotKeys, REWIND
    GetKeys(temp, HK10m, HK10)

    temp := ObjItemOf(hkArr, StopPlay)
    IniWrite, %temp%, % myIniFile, HotKeys, STOP_PLAY
    GetKeys(temp, HK40m, HK40)

    temp := ObjItemOf(hkArr, FastForward)
    IniWrite, %temp%, % myIniFile, HotKeys, FAST_FORWARD
    GetKeys(temp, HK20m, HK20)

    temp := ObjItemOf(hkArr, ButtonA)
    IniWrite, %temp%, % myIniFile, HotKeys, BUTTON_A
    GetKeys(temp, HK80m, HK80)

    temp := ObjItemOf(hkArr, EnterSelect)
    IniWrite, %temp%, % myIniFile, HotKeys, ENTER_SELECT
    GetKeys(temp, HK100m, HK100)

    temp := ObjItemOf(hkArr, ButtonB)
    IniWrite, %temp%, % myIniFile, HotKeys, BUTTON_B
    GetKeys(temp, HK200m, HK200)

    temp := ObjItemOf(hkArr, LeftMouseButton)
    IniWrite, %temp%, % myIniFile, HotKeys, LEFT_MOUSE_BUTTON
    GetKeys(temp, HK400m, HK400)

    temp := ObjItemOf(hkArr, RightMouseButton)
    IniWrite, %temp%, % myIniFile, HotKeys, RIGHT_MOUSE_BUTTON
    GetKeys(temp, HK800m, HK800)

    temp := ObjItemOf(hkArr, Trigger)
    IniWrite, %temp%, % myIniFile, HotKeys, TRIGGER
    GetKeys(temp, HK1000m, HK1000)
    /*
    GetKeys(Transcribe, HK1m, HK1)
    GetKeys(TabBackward, HK2m, HK2)
    GetKeys(Dictate, HK4m, HK4)
    GetKeys(TabForward, HK8m, HK8)
    GetKeys(Rewind, HK10m, HK10)
    GetKeys(FastForward, HK20m, HK20)
    GetKeys(StopPlay, HK40m, HK40)
    GetKeys(ButtonA, HK80m, HK80)
    GetKeys(EnterSelect, HK100m, HK100)
    GetKeys(ButtonB, HK200m, HK200)
    GetKeys(LeftMouseButton, HK400m, HK400)
    GetKeys(RightMouseButton, HK800m, HK800)
    GetKeys(Trigger, HK1000m, HK1000)
    */

    Gui Destroy

    Return

;-------------------------------------------------------------------------------
cancel: ; disable the old hotkey before adding a new one
;-------------------------------------------------------------------------------

    Gui Destroy

    Return


active:

    Menu, Tray, ToggleCheck, Active

    active:=!active

    if (active=1) {

        Menu, Tray, Icon, %A_Temp%\cyborg.png

        Menu, Tray, Tip, Custom PowerMic Buttons for KP Rads (active)

    } else {

        Menu, Tray, Icon, %A_Temp%\bones.png

        Menu, Tray, Tip, Custom PowerMic Buttons for KP Rads (disabled)

    }

    Return

about:

    Gui +OwnDialogs

    Msgbox,,Custom PowerMic Buttons for KP Radiologists,

(

Custom PowerMic Buttons for KP Radiologists

v. 1.2

by Jason D. Balkman

jason.d.balkman@kp.org

)

    Return

exit:

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

                ; ps360:= WinExist("PowerScribe 360 | Reporting")

                ; MsgBox, Data = %data%

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