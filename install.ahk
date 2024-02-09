﻿; Generated by AutoGUI 2.6.2
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

; ! DO NOT TOUCH BELOW COMMENTS
;@Ahk2Exe-UpdateManifest 1
;@Ahk2Exe-SetMainIcon Libs\Icons\icon.ico
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

; ! RUN PROGRAMM AS ADMIN
;// RunAsAmin()

#Include, Libs\DFChrome

; ******** [ INTIALIZE ] *********

FileRead, configs_, manifest.json
CONFIGS := chrome.Jxon_Load(configs_)

df_setupName = app.ahk
df_installFile = install.ahk
df_unInstallFile = uninstall.ahk
df_copyright = @2023 Copyright Congo Cloud Computer

df_TxtVersion := CONFIGS.app.version
df_packageName := StrReplace(CONFIGS.app.package_name, " ")
df_installDir := CONFIGS.install_dir
df_installPath := CONFIGS.install_dir "\" df_packageName

df_Prg := 0
df_BtnInstaller = INSTALLER
df_BtnCancel = ANNULER
df_TxtDeskframeVersion := "DESKFRAME v1.0"
df_TxtAppName := CONFIGS.app.name
df_TxtDescription := CONFIGS.app.description
df_siteweb := CONFIGS.app.siteweb
df_Lnk = <a href="https://%df_siteweb%">%df_siteweb%</a>
df_TxtInstallDestination := df_installPath

; ? MAIN VARS
df_dbIsKeeped := false
df_anOtherExist := false

; ? START CHECKING IF ANOTHER INTALATION EXIST
if FileExist(df_installPath "\Database") = "D" {
    df_anOtherExist := true
    MsgBox, 262468, Alert : une autre existence , Une autre installation de la meme application existe déjà.`nVoulez-vous conserver la base des données de celui-ci ?
    IfMsgBox, Yes 
        df_dbIsKeeped := true
}

; ? VERIFY IF GOOGLE CHROME IS INSTALLED
if !FileExist("C:\Program Files\Google\Chrome\Application\chrome.exe") {
    df_anOtherExist := true
    MsgBox, 262420, Attention , Vous devez installer Google Chrome pour continuer l'installation de l'appilication %df_TxtAppName%.`n`nVoulez-vous installer Chrome, puis recommencer l'installation ?
    IfMsgBox, Yes 
    {
        Run, http://chrome.google.com
        Gosub, MainInstWinClose
    }
    Else
        Gosub, MainInstWinClose
}

; ******** [ START GUI ] *********

Menu Tray, Icon, shell32.dll, 322

Gui MainInstallWin: New, +LabelMainInstWin -MaximizeBox +AlwaysOnTop
Gui Color, White
Gui Add, Picture, x5 y3 w209 h189, icon.ico
Gui Add, Progress, hWndhPrg vPrg x578 y11 w27 h263 -Smooth +Vertical, 0
Gui Font, s11
Gui Add, Button, hWndhBtnLaunch vBtnLaunch gLaunchApp x256 y297 w113 h27, &Lancer
Gui Font
Gui Font, s11
Gui Add, Button, hWndhBtnInstaller vBtnInstaller gInstall x386 y297 w113 h27, &Installer
Gui Font
Gui Font, s11
Gui Add, Button, hWndhBtnCancel vBtnCancel gCancelInstall x516 y297 w90 h27, &Annuler 
Gui Font
Gui Font, s11
Gui Add, Text, x545 y12 w30 h23 +0x200, Fin
Gui Font
Gui Font, s11
Gui Add, Text, x522 y249 w49 h23 +0x200, Début
Gui Font
Gui Font, s11
Gui Add, Text, vTxtDeskframeVersion x18 y282 w111 h23 +0x200, DESKFRAME v1.0
Gui Font
Gui Font, s17 Bold
Gui Add, Text, x213 y33 w282 h51 +0x200, INSTALLER
Gui Font
Gui Font, s12
Gui Add, Text, hWndhTxtAppName vTxtAppName x213 y82 w354 h37 +0x200, App name
Gui Font
Gui Font, s11
Gui Add, Text, x214 y114 w80 h23 +0x200, Version :
Gui Font
Gui Font, s11
Gui Add, Text, x213 y136 w83 h23 +0x200, Description :
Gui Font
Gui Add, Text, vTxtDescription x298 y132 w266 h29 +0x200, desc loreme ipsum dolor res
Gui Add, Text, x18 y304 w224 h23 +0x200, %df_copyright%
Gui Font, s10
Gui Add, Link, vLnk x213 y180 w225 h23, <a href="https://3c-numeric.com">3c-numeric.com</a>
Gui Font
Gui Font, s11
Gui Add, Text, x213 y158 w87 h23 +0x200, Installer vers :
Gui Font
Gui Font, cTeal
Gui Add, Text, vTxtInstallDestination x299 y159 w278 h21 +0x200, c:\deskframe
Gui Font
Gui Font, s11
Gui Add, Text, vTxtVersion x297 y116 w49 h23 +0x200, 1.0
Gui Font

; ? INIT WINDOW CONTROL
; GuiControl,, BtnCancel , %df_BtnCancel%
; GuiControl,, BtnInstaller , %df_BtnInstaller%
GuiControl,, Prg , %df_Prg%
GuiControl,, Lnk , %df_Lnk%
GuiControl,, TxtAppName , %df_TxtAppName%
GuiControl,, TxtDescription , %df_TxtDescription%
GuiControl,, TxtDeskframeVersion , %df_TxtDeskframeVersion%
GuiControl,, TxtInstallDestination , %df_TxtInstallDestination%
GuiControl,, TxtVersion , %df_TxtVersion%
GuiControl, Hide, BtnLaunch

; ? SHOW WINDOW
Gui Show, w618 h332, INSTALLER
Return

; ********** [ FUNCTIONS ] ***********

Install(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    global df_installPath
    global df_TxtAppName
    global df_TxtDescription
    ; global BtnCancel
    ; global Prg
    
    GuiControl, Disable, BtnCancel
    GuiControl, Disable, BtnInstaller
    GuiControl,, Prg , 10

    if df_dbIsKeeped {
        ; Move database to temp folder
        FileCopyDir, %df_installPath%\Database, "%A_Temp%" , 1
        GuiControl,, Prg , 30
    }

    if df_anOtherExist {
        FileRemoveDir, %df_installPath%, 1
        FileCreateDir, %df_installPath%
        GuiControl,, Prg , 80
    } else {
        FileCreateDir, %df_installPath%
        GuiControl,, Prg , 80
    }

    ; Installation process
    ; FileCopy, %A_WorkingDir%, %df_installPath% , 1
    ErrorCount := CopyFilesAndFolders(A_WorkingDir "\*", df_installPath, 1)
    if (ErrorCount != 0) {
        GuiControl,, Prg , 0
        MsgBox, 262420, Erreur, Erreur : %ErrorCount%`n`nLe programme n'a pas pu etre Installer vers le respertoire des destion.
        GuiControl, Enable, BtnCancel
        GuiControl, Disable, BtnInstaller
    } else {
        GuiControl,, Prg , 90

        ; * Restore Old Database
        FileMoveDir, %A_Temp%\Database, %df_installPath%, 2
        GuiControl,, Prg , 95

        ; Finalize intallation
        InstallFinalization()
    }
}

CopyFilesAndFolders(SourcePattern, DestinationFolder, DoOverwrite = false) {
    ; First copy all the files (but not the folders):
    FileCopy, %SourcePattern%, %DestinationFolder%, %DoOverwrite%
    ErrorCount := ErrorLevel
    ; Now copy all the folders:
    Loop, %SourcePattern%, 2  ; 2 means "retrieve folders only".
    {
        FileCopyDir, %A_LoopFileFullPath%, %DestinationFolder%\%A_LoopFileName%, %DoOverwrite%
        ErrorCount += ErrorLevel
        if ErrorLevel  ; Report each problem folder by name.
            MsgBox, 262160, Erreur de copie, Ne peut pas compier %A_LoopFileFullPath% Dans %DestinationFolder%.
    }
    return ErrorCount
}

InstallFinalization() {
    global df_installPath
    global df_TxtAppName
    global df_TxtDescription
    global df_setupName
    global df_installFile
    global df_unInstallFile
    global df_packageName

    ; CREATE A SHORTCUT
    FileCreateShortcut, %df_installPath%\%df_setupName%, %A_Desktop%\%df_TxtAppName%.lnk, %df_installPath%,, %df_TxtDescription%, %df_installPath%\icon.ico
    ; PUT TO START MENU
    FileCreateDir, %A_Programs%\%df_TxtAppName%
    FileCreateShortcut, %df_installPath%\%df_setupName%, %A_Programs%\%df_TxtAppName%\%df_TxtAppName%.lnk, %df_installPath%,, %df_TxtDescription%, %df_installPath%\icon.ico
    FileCreateShortcut, %df_installPath%\%df_unInstallFile%, %A_Programs%\%df_TxtAppName%\Unintall %df_TxtAppName%.lnk, %df_installPath%,, %df_TxtDescription%, shell32.dll,, 102
    ; DELETE INSTALL FILE
    FileDelete, %df_installPath%\%df_installFile%
    FileDelete, %df_installPath%\readme.txt
    FileDelete, %df_installPath%\log.txt

    GuiControl,, Prg , 100

    installSuccess()
}

InstallSuccess() {
    global df_installPath
    global df_setupName

    GuiControl, Show, BtnLaunch
    GuiControl, Enable, BtnCancel
    GuiControl, Disable, BtnInstaller
    GuiControl,, BtnCancel, Fermer
}

LaunchApp() {
    global df_installPath
    global df_setupName
    
    Run, "%df_installPath%\%df_setupName%"
    Gosub, MainInstWinClose
}

RunAsAmin() {
    full_command_line := DllCall("GetCommandLine", "str")

    if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)")) {
        try
        {
            if A_IsCompiled
                Run *RunAs "%A_ScriptFullPath%" /restart
            else
                Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
        }
        Gosub, MainInstWinEscape
    }
}

CancelInstall(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    Gosub, MainInstWinClose
}

; ********** [ EXIT CONTROL ] *********

MainInstWinEscape:
MainInstWinClose:
    ExitApp
