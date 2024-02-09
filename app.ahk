#ErrorStdOut
SetBatchLines -1
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force
DetectHiddenWindows, On
SetTitleMatchMode, 2
SetKeyDelay, 10

; ! NOT TOUCH BELOW COMMENTS
;@Ahk2Exe-SetMainIcon icon.ico
;@Ahk2Exe-Bin  AutoHotkeyU32.exe
;@Ahk2Exe-Cont ...

;@Ahk2Exe-SetCompanyName Congo Cloud Computer
;@Ahk2Exe-SetCopyright 2023 3C-numeric
;@Ahk2Exe-SetDescription DESKFRAME Software
;@Ahk2Exe-SetFileVersion 1
;@Ahk2Exe-SetInternalName CCLOUD-DESKFRAME
;@Ahk2Exe-SetLanguage languageCode_0436
;@Ahk2Exe-SetLegalTrademarks 3C-DEV
;@Ahk2Exe-SetName 3C-DEV
;@Ahk2Exe-SetVersion 1.0
; ! -------------------------

#Include Libs\DFChrome
#include Libs\DFHttp
#include Libs\DFSocket
#Include Libs\DFReqCtrl.ahk

; ********************** [ CHROME INIT ] **************

Global chromeInst,pageInst,chromeExe,chromeProfile

/*
my chrome.ini contents

[Internal]
chromeExe=E:\Portables2\Chrome\App\Chrome-bin\chrome.exe
chromeProfile=C:\ahk\chromeProfile

*/

; ************ [ INIT CONFIGS ] **************

FileRead, configs_, manifest.json
CONFIGS := chrome.Jxon_Load(configs_)
; ? ---- frame ----
df_indexUrl := CONFIGS.frame.srcUrl
df_index := CONFIGS.frame.srcFile
df_port := CONFIGS.frame.port
; df_icon := CONFIGS.frame.icon
df_wHeight := CONFIGS.frame.wHeight
df_wWidth := CONFIGS.frame.wWidth
df_titleBar := CONFIGS.frame.titleBar
df_disableWinStyleTitlebar := CONFIGS.frame.forceLightTitlebar
; ? ---- app ----

;*************** [ HTTP SERVER ] **********************

; * CHECK WETHER THE MAIN FILE EXIST IN SRC BEFORE LAUNCH
{
    global df_index
    if (StrLen(Trim(df_indexUrl)) = 0) {
        FCheme := A_ScriptDir . "\www\" . df_index
        if (FileExist(FCheme) = "D"  || FileExist(FCheme) = "X" || FileExist(FCheme) = "" ) {
            MsgBox, 48, Alert on DESKFRAME, INDEX File "%df_index%" not found or have inapropriate attribut.`r`nFile: %FCheme%, 20
            ExitApp, 1
        }
    }
}

; ? CONTROL TITLE BAR VISIBILITY
DFTitlebarVisibility(show := true) {
    global df_disableWinStyleTitlebar
    if (show = false) {
        ; * title bar can't be disable if win Style is activate
        ; * disable win Style to0
        df_disableWinStyleTitlebar := 1

        WinGetTitle, currentWindow, A
        IfWinExist %currentWindow%
        {
            WinSet, Style, -0xC00000  ; hide title bar 
            ; WinSet, Style, -0xC00000, A ; Force hide title bar
            WinSet, ExStyle, -0x80, A
        }
    }
}

; ? START SERVING
DFHTTPSRV(PORT) {
    paths := {}
    paths["/"] := Func("dfHTTPRoot")
    paths["dfHandler"] := Func("dfHTTPHandler")
    paths["DFHandler838j98389K98738uTuy3x7yndi7y3784"] := Func("dfHTTPAction")
    paths["404"] := Func("dfHTTPNotFound")
    
    server := new HttpServer()
    server.LoadMimes("Libs\DFMimes.db")
    server.SetPaths(paths)
    server.Serve(PORT)
    return
}

; ? SERVE INDEX FILE
dfHTTPRoot(ByRef req, ByRef res, ByRef server) {
    global df_index
    FCheme := A_ScriptDir . "\www\" . df_index
    server.ServeFile(res, FCheme)
    res.status := 200
}

; ? WHEN REQUEST NOT FOUND
dfHTTPNotFound(ByRef req, ByRef res) {
    res.SetBodyText("Page not found - Page non retrouver")
}

; ? TO GET ALL UNKNOW FILES REQUEST
dfHTTPHandler(ByRef req, ByRef res, ByRef server) {
    server.ServeFile(res, A_ScriptDir . "\www" req.path)
    res.status := 200
}

; ? PORT GEN : FIND A FREE PORT
dfHTTPPort() {
    global df_port

	Port := 9018
    if df_port
        Port := df_port
    else {
        ; TODO: implement Auto-search-unused-port
        ; Port := 9000
        ; While, true
        ; {
        ;     status := DFTestPort("Libs\tcping.exe -n 2 localhost " Port)
        ;     if (status > 0) {
        ;         Port := Port + 1
        ;         ; msgbox % status
        ;     } 
        ;     else 
        ;         Break
        ; }
        if (Chromes := Chrome.FindInstances()).HasKey(Port)
        	Port := Chromes.MaxIndex() + 1
    
    }
    ; Template = 
    ; ( Ltrim`r`n
    ; export default {
    ;     PORT: {}
    ; }
    ; )
    ; file := FileOpen("Libs\deskport.js", "w")
	; file.Write(Format(Template , Port))
	; file.Close()

    return Port
}

; ? EXECUTE ACTIONS BETWEEN HTML AND CORE
dfHTTPAction(ByRef req, ByRef res, ByRef server) {
    ; TODO: implimante this function
    ; * req.queries : store all queries params on url
    response := dfHTTPRequestHandler(req.queries)
    res.headers["Content-Type"] = "application/json"
    res.SetBodyText(response)
    res.status := 200
}

DFTestPort(sCmd, txtToFind := "Port is open", callBackFuncObj := "", encoding := "CP0"){
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
 
    StringGetPos, OutputVar, sOutput, Port is open
    Return OutputVar
}

; * NOT START SERVER IF srvUrl IS GIVEN
if (StrLen(Trim(df_indexUrl)) = 0) {
    dfHTTPortDispo := dfHTTPPort()
    DFHTTPSRV(dfHTTPortDispo)
}

; **************** [ CHROME FINAL INIT ] **************

; MAIN LAUNCH
IniRead, chromeExe, Libs\chrome.ini, Internal, chromeExe, %A_Space%
IniRead, chromeProfile, Libs\chrome.ini, Internal, chromeProfile, C:\ahk\chromeProfile

IfNotExist, %chromeProfile%
	FileCreateDir, %chromeProfile%

; ? If URI is set. use URI ensted of index file

dfUri := "http://localhost:" dfHTTPortDispo
if (Trim(df_indexUrl) != "") 
    dfUri := df_indexUrl
df_RakjdeR := df_disableWinStyleTitlebar ? dfUri " --disable-windows10-custom-titlebar" : dfUri
Inst := chm_app(chromeExe, chromeProfile, df_RakjdeR, df_wWidth, df_wHeight)
; Inst := chm_app(chromeExe, chromeProfile,  A_ScriptDir "\www\" df_index, df_wWidth, df_wHeight)

; * set title bar visibility
DFTitlebarVisibility(df_titleBar)

; Set up a timer to demonstrate making dynamic page updates every so often.
WinWait, NeutronC App

OnExit, cleanup
Return

cleanup:
	;delete profile folder on exit - not everyone might want to do that!
    ;rmDir is faster than FileRemoveDir, and also runs in background asynchronously
	Run, %comspec% /c echo y|rmDir /s "%chromeProfile%",, Hide

	chm_exit(chromeInst)
ExitApp
