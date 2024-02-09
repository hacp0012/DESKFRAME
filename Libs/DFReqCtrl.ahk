
#Include, %A_ScriptDir%\Libs\DeskLib.ahk

; * @return json value
dfHTTPRequestHandler(QUERIES) {
  ; ? --> {CMD: 'frame.maximize', PARAMS: '{}'}
  ; ? <-- {status:OK|NO, response:{}, message:""}

  Response := {}
  CMD     := QUERIES.CMD
  PARAMS  := QUERIES.PARAMS

  Switch CMD
  {
    Case "frame.maximize": {
      frame_ := new Frame()
      statut := frame_.Maximize()
      Response := _dfResponser("OK", statut)
    }
    Case "frame.minimize": {
      frame_ := new Frame()
      statut := frame_.Minimize()
      Response := _dfResponser("OK", statut)
    }
    Case "frame.restore": {
      frame_ := new Frame()
      statut := frame_.Restore()
      Response := _dfResponser("OK", statut)
    }
    Case "frame.toggle": {
      frame_ := new Frame()
      statut := frame_.Toggle()
      Response := _dfResponser("OK", statut)
    }
    Case "frame.close": {
      frame_ := new Frame()
      statut := frame_.Close()
      Response := _dfResponser("OK", statut)
    }
    Case "frame.hidetitlebar": {
      frame_ := new Frame()
      statut := frame_.hideTitlebar()
      Response := _dfResponser("OK", statut)
    }
    Case "frame.showtitlebar": {
      frame_ := new Frame()
      statut := frame_.showTitlebar()
      Response := _dfResponser("OK", statut)
    }
    Case "frame.showtitlebartoggle": {
      frame_ := new Frame()
      statut := frame_.showTitlebarToggle()
      Response := _dfResponser("OK", statut)
    }
    Case "frame.move": {
      frame_ := new Frame()
      statut := frame_.move()
      Response := _dfResponser("OK", statut)
    }

    ; SYSTEM
    Case "system.traytip": {
      sys_ := new System()
      statut := sys_.TrayTip(PARAMS)
      Response := _dfResponser("OK", statut)
    }
    Case "system.exitapp": {
      sys_ := new System()
      statut := sys_.ExitApp(PARAMS)
      Response := _dfResponser("OK", statut)
    }
    Case "system.shutdown": {
      sys_ := new System()
      statut := sys_.Shutdown(PARAMS)
      Response := _dfResponser("OK", statut)
    }
    Case "system.run": {
      sys_ := new System()
      statut := sys_.Run(PARAMS)
      Response := _dfResponser("OK", statut)
    }
    
    ; DRIVE
    Case "drive.list": {
      drive_ := new Drive()
      statut := drive_.List()
      Response := _dfResponser("OK", statut)
    }
    Case "drive.capacity": {
      drive_ := new Drive()
      statut := drive_.Capacity(PARAMS)
      Response := _dfResponser("OK", statut)
    }
    Case "drive.getfreespace": {
      drive_ := new Drive()
      statut := drive_.GetFreeSpace(PARAMS)
      Response := _dfResponser("OK", statut)
    }
    Case "drive.label": {
      drive_ := new Drive()
      statut := drive_.Label(PARAMS)
      Response := _dfResponser("OK", statut)
    }

    Default: ; return DESKFRAME VERSION
        Response := _dfResponser("NO",, "1.0")
  }

  return Response
}

; HANDLE RESPONSE TO CORRECT JSON
_dfResponser(Status_, Response_ = "", Message_ = "") {
  return chrome.jxon_Dump({status: Status_, response: Response_, message: Message_})
}
