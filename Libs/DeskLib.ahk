
; CONTAIN A CLASS OF FUNCTIONS TO HANDLE BEST WORK OF DESKFRAME
; #Include, %A_ScriptDir%\Libs\DFDatabase.ahk

class Drive {
  List() {
    DriveGet, OutputVar, List
    return OutputVar
  }
  Capacity(params_) {
    params  := chrome.Jxon_Load(params_)
    path    := params.path
    DriveGet, OutputVar, Capacity, %Path%
    return OutputVar
  }
  Label(params_) {
    params  := chrome.Jxon_Load(params_)
    path    := params.path
    DriveGet, OutputVar, Label, %path%
    return OutputVar
  }
  GetFreeSpace(params_) {
    params  := chrome.Jxon_Load(params_)
    path    := params.path
    DriveSpaceFree, OutputVar, %Path%
    return OutputVar
  }
}

class File {
  Append() {

  }
  Copy() {

  }
  Exist() {

  }
  Size() {

  }
  Move() {

  }
  Read() {

  }
  Recycle() {

  }
  Select() {

  }
  Time() {

  }
  Write() {

  }
  delete() {

  }
  EmptyRecycle() {

  }
  List() {

  }
}

class Directory {
  Copy() {

  }
  Creat() {

  }
  Move() {

  }
  Remove() {

  }
  Select() {

  }
  List() {

  }
  Exist() {

  }
}

class System {
  ExitApp() {
    chm_exit(chromeInst)
    ExitApp
    return 1
  }
  TrayTip(params_) {
    params  := chrome.Jxon_Load(params_)
    title   := params.title
    text    := params.text
    second  := params.seconds
    opt     := option
    TrayTip , %title%, %text%, %seconds%, %opt%
    return 1
  }
  Shutdown(params_) {
    params  := chrome.Jxon_Load(params_)
    flag    := params.flag
    Shutdown, %flag%
    return 1
  }
  Run(params_) {
    params          := chrome.Jxon_Load(params_)
    sCmd            := params.cmd
    callBackFuncObj := ""
    encoding        := "CP0"

    static HANDLE_FLAG_INHERIT := 0x00000001, flags := HANDLE_FLAG_INHERIT
          , STARTF_USESTDHANDLES := 0x100, CREATE_NO_WINDOW := 0x08000000
    
    DllCall("CreatePipe", "PtrP", hPipeRead, "PtrP", hPipeWrite, "Ptr", 0, "UInt", 0)
    DllCall("SetHandleInformation", "Ptr", hPipeWrite, "UInt", flags, "UInt", HANDLE_FLAG_INHERIT)
    
    VarSetCapacity(STARTUPINFO , siSize :=    A_PtrSize*4 + 4*8 + A_PtrSize*5, 0)
    NumPut(siSize              , STARTUPINFO)
    NumPut(STARTF_USESTDHANDLES, STARTUPINFO, A_PtrSize*4 + 4*7)
    NumPut(hPipeWrite          , STARTUPINFO, A_PtrSize*4 + 4*8 + A_PtrSize*3)
    NumPut(hPipeWrite          , STARTUPINFO, A_PtrSize*4 + 4*8 + A_PtrSize*4)
    
    VarSetCapacity(PROCESS_INFORMATION, A_PtrSize*2 + 4*2, 0)
  
    if !DllCall("CreateProcess", "Ptr", 0, "Str", sCmd, "Ptr", 0, "Ptr", 0, "UInt", true, "UInt", CREATE_NO_WINDOW
                                , "Ptr", 0, "Ptr", 0, "Ptr", &STARTUPINFO, "Ptr", &PROCESS_INFORMATION)
    {
        DllCall("CloseHandle", "Ptr", hPipeRead)
        DllCall("CloseHandle", "Ptr", hPipeWrite)
        throw Exception("CreateProcess is failed")
    }
    DllCall("CloseHandle", "Ptr", hPipeWrite)
    VarSetCapacity(sTemp, 4096), nSize := 0
    while DllCall("ReadFile", "Ptr", hPipeRead, "Ptr", &sTemp, "UInt", 4096, "UIntP", nSize, "UInt", 0) {
        sOutput .= stdOut := StrGet(&sTemp, nSize, encoding)
        ( callBackFuncObj && callBackFuncObj.Call(stdOut) )
    }
    DllCall("CloseHandle", "Ptr", NumGet(PROCESS_INFORMATION))
    DllCall("CloseHandle", "Ptr", NumGet(PROCESS_INFORMATION, A_PtrSize))
    DllCall("CloseHandle", "Ptr", hPipeRead)
  
    Return sOutput
  } ; Run a command
}

class Frame {
  Maximize() {
    WinMaximize, A
    return 1
  }
  Minimize() {
    WinMinimize, A
    return 1
  }
  Restore() {
    WinRestore, A
    return 1
  }
  Toggle() {
    WinGet, OutputVar, MinMax, A
    if (OutputVar = 0)
      WinMaximize, A
    else
      WinRestore, A

    return 1
  }
  Close() {
    WinKill, A
    ; chm_exit(chromeInst)
    ; ExitApp
  }
  hideTitlebar() {
    WinSet, Style, -0xC00000, A ; Force hide title bar
    WinSet, ExStyle, -0x80, A
  }
  showTitlebar() {
    WinSet, Style, +0xC00000, A ; Force show title bar
    ; WinSet, ExStyle, ^0x80, A
  }
  showTitlebarToggle() {
    WinSet, Style, ^0xC00000, A ; Force show title bar
    ; WinSet, ExStyle, ^0x80, A
  }
  move() {
    CoordMode, Mouse  ; Switch to screen/absolute coordinates.
    MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
    WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
    WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin%
    if EWD_WinState = 0  ; Only if the window isn't maximized
        SetTimer, EWD_WatchMouse, 3 ; Track the mouse as the user drags it.

    EWD_WatchMouse:
      GetKeyState, EWD_LButtonState, LButton, P
      if EWD_LButtonState = U  ; Button has been released, so drag is complete.
      {
        SetTimer, EWD_WatchMouse, off
        return
      }
      
      GetKeyState, EWD_EscapeState, Escape, P
      if EWD_EscapeState = D  ; Escape has been pressed, so drag is cancelled.
      {
        SetTimer, EWD_WatchMouse, off
        WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
        return
      }
      
      ; Otherwise, reposition the window to match the change in mouse coordinates
      ; caused by the user having dragged the mouse:
      CoordMode, Mouse
      MouseGetPos, EWD_MouseX, EWD_MouseY, EWD_MouseWin
      WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
      SetWinDelay, -1   ; Makes the below move faster/smoother.
      WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
      EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
      EWD_MouseStartY := EWD_MouseY
    return
    return 1
  }
}

class Database {
  init() {
    
  }
  Empty() {
    
  }
  
  class Collection {
    Create() {
      
    }
    Delete() {
      
    }
    Empty() {
      
    }
    List() {
      
    }
  }
  
  class Data {
    Get() {
      
    }
    Add() {
      
    }
    Update() {
      
    }
    Delete() {
      
    }
  }
}
