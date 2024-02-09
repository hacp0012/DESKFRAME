// import { PORT } from "./deskport";

function Deskframe(PORT = 9000) {
  const comId = "DFHandler838j98389K98738uTuy3x7yndi7y3784";
  const comPort = Location.port ? Location.port : PORT;
  const xhr = function () {
    // Send requests sequentially so as to not overload the server
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
      if (xhttp.readyState == 4 && xhttp.status == 200) {
        console.log(xhttp.responseText);
      }
    };
    xhttp.open("GET", `http://localhost:${comPort}/${comId}`, true);
    xhttp.send();
  };

  return {
    Version: "1.0",
    Drive: {
      List() {},
      Capacity() {},
      Label() {},
      GetFreeSpace() {},
    },
    File: {
      Append() {},
      Copy() {},
      Exist() {},
      Size() {},
      Move() {},
      Read() {},
      Recycle() {},
      Select() {},
      Time() {},
      Write() {},
      delete() {},
      EmptyRecycle() {},
      List() {},
    },
    Directory: {
      Copy() {},
      Creat() {},
      Move() {},
      Remove() {},
      Select() {},
      List() {},
      Exist() {},
    },
    system: {
      ExitApp() {},
      TrayTip() {},
      Shutdown(type = 1) {},
      Run() {}, // Run une commande
    },
    frame: {
      Maximize() {},
      Minimize() {},
      Restore() {},
      Toggle() {},
      Close() {},
      ToggleTitlebar() {},
    },
    Database() {
      const init = function () {};
      return {
        Empty() {},
        Collection: {
          Create() {},
          Delete() {},
          Empty() {},
          List() {},
        },
        Data: {
          Get() {},
          Add() {},
          Update() {},
          Delete() {},
        },
      };
    },
  };
}

export default Deskframe;
