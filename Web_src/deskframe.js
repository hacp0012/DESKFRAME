/**
 * DESKFRAME COM OBJECT
 * For modular usage add : "export default" at the biging of
 * deskframe function.
 * @param {integer} PORT
 * @returns Deskframe object
 */
function Deskframe(PORT = 9018) {
  const comId = "DFHandler838j98389K98738uTuy3x7yndi7y3784";
  const comPort = location.port ? location.port : PORT;
  const xhr = function (Cmd, Params = {}) {
    Params = JSON.stringify(Params);

    let response = {};

    const xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function () {
      if (xhttp.readyState == 4 && xhttp.status == 200) {
        try {
          response = JSON.parse(xhttp.responseText);
        } catch (error) {
          response = xhttp.responseText;
        }
      }
    };
    xhttp.open(
      "GET",
      `http://localhost:${comPort}/${comId}?CMD=${Cmd}&PARAMS=${Params}`,
      false
    );
    xhttp.send();

    return response;
  };

  return {
    Version: "1.0",
    Drive: {
      /**
       * Get all drive list
       * @returns list of drivers
       */
      List() {
        const response = xhr("drive.list");
        return response.response;
      },
      /**
       * Get the total capacity of a dir or drive in MG
       * @param {String} path
       * @returns
       */
      Capacity(path) {
        const response = xhr("drive.capacity", { path });
        return response.response;
      },
      /**
       * Get the name label of a drive
       * @param {String} drive drive letter or path
       * @returns
       */
      Label(drive = "C:\\") {
        const response = xhr("drive.label", { path: drive });
        return response.response;
      },
      /**
       * get the free space in MB
       * @param {String} path
       * @returns Integer in MB
       */
      GetFreeSpace(path = "C:\\") {
        const response = xhr("drive.getfreespace", { path });
        return response.response;
      },
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
      ExitApp() {
        const response = xhr("system.exitapp");
        return response.response;
      },
      /**
       * traytip bulb
       * @param {String} title
       * @param {String} text
       * @param {Number} seconds
       * @param {Number} option 1: info, 2: warning, 3: error
       * @returns
       */
      TrayTip(title, text, seconds = 1, type = 1) {
        const response = xhr("system.traytip", {
          title,
          text,
          seconds,
          option: type,
        });
        return response.response;
      },
      /** SHUTDOWN PC
       * •0 = Logoff
       * •1 = Shutdown
       * •2 = Reboot
       * •4 = Force
       * •8 = Power down
       * @param {Number} type
       */
      Shutdown(flag = 1) {
        const response = xhr("system.shutdown", { flag });
        return response.response;
      },
      Run(cmd) {
        const response = xhr("system.run", { cmd });
        return response.response;
      }, // Run une commande
    },
    frame: {
      Maximize() {
        const response = xhr("frame.maximize");
        return response.response;
      },
      Minimize() {
        const response = xhr("frame.minimize");
        return response.response;
      },
      Restore() {
        const response = xhr("frame.restore");
        return response.response;
      },
      Toggle() {
        const response = xhr("frame.toggle");
        return response.response;
      },
      Close() {
        window.close(); // Default std
        // const response = xhr("frame.close");
        // return response.response;
      },
      HideTitlebar() {
        const response = xhr("frame.hidetitlebar");
        return response.response;
      },
      ShowTitlebar() {
        const response = xhr("frame.showtitlebar");
        return response.response;
      },
      ShowTitlebarToggle() {
        const response = xhr("frame.showtitlebartoggle");
        return response.response;
      },
      Mover(className) {
        const el = document.getElementsByClassName(className);
        let time = 0;
        for (let key = 0; key < el.length; key++) {
          const element = el.item(key);
          element.addEventListener("mousedown", function (event) {
            if (time == 0) {
              // desk.frame.Move();
              time = 1;
              const response = xhr("frame.move");
              return response.response;
            }
            setTimeout(() => (time = 0), 500);
          });
        }
      },
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
