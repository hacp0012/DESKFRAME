#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

; ! NOT TOUCH BELOW COMMENTS
;@Ahk2Exe-UpdateManifest 1
;@Ahk2Exe-SetMainIcon Libs\Icons\compiler.ico
;@Ahk2Exe-Cont ...

;@Ahk2Exe-SetCompanyName Congo Cloud Computer
;@Ahk2Exe-SetCopyright 2023 3C-numeric
;@Ahk2Exe-SetDescription Compilateur DESKFRAME
;@Ahk2Exe-SetFileVersion 1
;@Ahk2Exe-SetInternalName CCLOUD-DESKFRAME
;@Ahk2Exe-SetLanguage languageCode_0436
;@Ahk2Exe-SetLegalTrademarks 3C-DEV
;@Ahk2Exe-SetName 3C-DEV
;@Ahk2Exe-SetVersion 1.0
; ! -------------------------

#Include, Libs\DFChrome

Compil() {
  FileRead, configs_, manifest.json
  CONFIGS := chrome.Jxon_Load(configs_)

  df_TxtAppName := CONFIGS.app.name
  df_installFilename = install.ahk
  df_Compile_tmpCache = Compile_tmpCache.ahk
  df_tempDirName = Temp_Deskfram_extract

  ; CONTROL REQUIRED FILES
  CompIgnore := CONFIGS.compilator.ignore
  ComRequiredFiles := CONFIGS.compilator.required
  ControlFiles(ComRequiredFiles)

  TotalFilesN := 0
  MicroTmpltFile =
  (
    FileInstall, {}, %A_Temp%\%df_tempDirName%\{}, 1
    GuiControl,, Txt1234100002, Fichiers {}
    
  )

  TotalDirsN := 0
  MicroTmpltFold = 
  (
    FileCreateDir, %A_Temp%\%df_tempDirName%\{}
    GuiControl,, Txt1234100002, Dossiers {}
    
  )
  
  Files := ""
  Folders := ""
  Loop, Files, .\*, DFR
  {
    isIgnored := 0
    for key, dirname in CompIgnore
    {
      if (subStr(StrReplace(A_LoopFilePath, ".\"), 1, StrLen(dirname)) = dirname) {
        isIgnored := 1
        Break
      }
    }

    if (isIgnored = 0) {
      if isIgnored
      isIgnored := 0
      if A_LoopFileAttrib = D
      {
        TotalDirsN += 1
        Folders := Folders "`r`n" Format(MicroTmpltFold, StrReplace(A_LoopFilePath, ".\"), TotalDirsN)
      }
      else {
        TotalFilesN += 1
        Files := Files "`r`n"Format(MicroTmpltFile, StrReplace(A_LoopFilePath, ".\"), StrReplace(A_LoopFilePath, ".\"), TotalFilesN)
      }
    }
  }

  ; SAVE FILE
  xT := Template(Folders, Files, A_Temp "\" df_tempDirName "\" df_installFilename, df_tempDirName)
  file := FileOpen(df_Compile_tmpCache, "w")
  file.Write(xT)
  file.Close()

  ; RUN COMPILATION
  TrayTip, Compilateur DESKFRAME, Encours de compilation.`r`nPatianter ..., 1, 1
  FileCreateDir, Release
  RunWait, Compiler\Ahk2Exe.exe /in %df_Compile_tmpCache% /out "Release\%df_TxtAppName%.exe"
  TrayTip, Compilation OK, Votre application est compiler avec succes.`r`nVotre Build est dans le repertoir : Release, 2, 1

  FileDelete, %df_Compile_tmpCache%
  ExitApp
}
Compil()

ControlFiles(ComRequiredFiles) {
  for key, file in ComRequiredFiles
  {
    if (!FileExist(file)) {
      MsgBox, 16, Fichier manquante, Le fichier ou repertoir "%file%" est manquante.`r`nLa compilation va s'arreter., 10000
      ExitApp
    }
  }
}

Template(Files, Folders, ExecFile, tmpDir) {
  Script = 
  (
  #NoEnv
  #SingleInstance, Force
  SendMode, Input
  SetBatchLines, -1
  SetWorkingDir, %A_ScriptDir%

  ; ! NOT TOUCH BELOW COMMENTS
  ;@Ahk2Exe-SetMainIcon icon.ico
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

  Menu Tray, Icon, shell32.dll, 315

  Gui Extractor: New, +LabelExtractor +hWndhMainWnd +Resize -MinimizeBox -MaximizeBox -SysMenu +AlwaysOnTop +ToolWindow -Caption
  Gui Font, s12
  Gui Add, Text, x72 y8 w181 h23 +0x200, Extraction de Fichers 📂 
  Gui Font
  Gui Font, s14
  Gui Add, Text, hWndhTxt1234100002 vTxt1234100002 x72 y32 w211 h23 +0x200, 0 / 0
  Gui Font
  Gui Font, s40
  Gui Add, Text, x8 y0 w63 h64 +0x200, E
  Gui Font

  Gui Show, w353 h68, DESKFRAME Extractor

  ; EXTRACT DATAS
  Extractor()

  Return

  ExtractorSize:
      If (A_EventInfo == 1) {
          Return
      }

  Return

  Extractor() {
    FileRemoveDir, %A_Temp%\{}, 1

    ; ? DIRECTORIES EXTRACTION ---------------------------------------
    {}

    ; ? FILES EXTRACTION ---------------------------------------------
    {}

    ; ? --------------------------------------------------------------

    ; LAUNCH INSTALLER
    Gui, Hide

    RunWait, {}

    FileRemoveDir, %A_Temp%\{}, 1

    goSub ExtractorClose
  }

  ExtractorEscape:
  ExtractorClose:
      ExitApp
  )

  return Format(Script, tmpDir, Files, Folders, ExecFile, tmpDir)
}