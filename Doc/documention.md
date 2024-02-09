# DOCUMENTATION DE LA BIBLIOTHÈQUE JAVASCRIPT DESKFRAME

v1.0 cette version est encore en cours de développement 

la bibliothèque procède une fonction qui initialise et génère un objet sur la quelle vous pouvez appeler des fonction deskframe.

## classe | fonction deskframe

initialisé : let desk = Deskframe()

`desk.version`

- retourne la version action du framework

### FRAME

`desk.frame.Maximize()`

- maximiser la taille de la fenêtre

`desk.frame.Minimize()`

- minimiser la fenêtre dans la bar des taches windows.

`desk.frame.Restore()`

- restor la taille de la fenêtre s'il est maiximizer il redévient normal.

`desk.frame.Toggle()`

- jongler avec la taille de la fenêtre max ou normal.

`desk.frame.Close()`

- fermer la fenêtre.

`desk.frame.HideTitlebar()`

- cache la bar de titre de la fenêtre et fait passer l'application en mode "frameless".

`desk.frame.ShowTitlebar()`

- réaffiche la bar de titre de la fenêtre.

`desk.frame.ShowTitlebarToggle()`

- jongle entre les deux état de la fenêtre.

`desk.frame.Mover(className)`

- className : est le nom de la classe qui aura le pouvoir de deplacer la fenetre.
- cette méthode doit être appelé depuis vote page html -> script et une seul fois.
- la balise qui portera cette Class sera sensible au double clic et grace a ce la il pour deplacer la fenetre avec votre souris.

### SYSTEM

desk.system.ExitApp()

- femer l'application. équivaut de desk.frame.Close() mais a la diferance que lui force la fermeture de l'application.

`desk.system.TrayTip(title, text, seconds, option)`

- cree une bulle de notification windows dans le coin bas droit de l'écran.
- title : le titre de la bulle.
- text : text ou message du corps de la bulle.
- seconds : la duré de visibilité de la bulle.
- type : le type de la bulle a afficher. 1: info, 2: warning, 3: error

`desk.system.Shutdown(flag)`

- flag : mode de mise sous tension ⚡  que vous voulez utiliser 
0 = Logoff
1 = Shutdown
2 = Reboot
4 = Force
8 = Power down
- mise sous tension de la machine (ordinateur).

`desk.system.Run(cmd)`

- cmd : la commande a exécuter sur le système shell de la machine.
- exécuter de programmes ou des commandes systeme
- ex: dir c:\

### DRIVE

`desk.drive.List()`

- retourner la liste de tout les lecteurs disponibles sur la machine. (C, D, F, H, ...)

`desk.drive.Capacity(path)`

- path : chemin vers le lecteur ou le répertoire dont vous voulez avoir la taille en MB (mega byts)

`desk.drive.Label(drive)`

- drive : le nom du lecteur. la quelle vous voulez avoir le label.
- retourne le nom labelise du lecteur.

`desk.drive.GetFreeSpace(path)`

- path : le chemin ou le nom du lecteur dont vous voulez avoir la taille restante en MB (mega byts)

### FILE

- en développement. ca vient bientôt

### DIRECTORY

- en développement. ca vient bientôt

### DATABASE

- en développement. ca vient bientôt.
- il offre un systeme de base des données basé sur le NoSQL. les données seront stocker sur le disque en petit morceaux formaté en JSON.
