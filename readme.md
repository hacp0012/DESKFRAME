# DESKFRAME

![Logo](/icon.ico)

## Documentation

[CSS used in framework](Doc/css-doc.md)

[Misc doc used in framework](Doc/documention.md)

est un framework qui vous permet de transformer votre application web en application native windows que vous pouvez partager avec votre antourage ou vos clients.
il est fait dans un cadre simpliste et facile à utiliser pour tout les mondes et même pour ceux qui ne sont pas trop pointu dans la programmation native.
il ne vous suffit que d'Une minute pour tout arranger et distribuer. il générée des applications léger et flexible car pour sont fonctionnement il nécessite le Navigateur google Chrome installer sur le système et même pour tous vos applications généré par lui.

la plate-forme est une produit de Congo Cloud Computer. <https://3c-numeric.com>

## OS supporté

Malheureusement deskframe est seulement disponible sur le système d'exploitation Windows seulement.
nous travaillons pour le rendre disponible sur tout les plate-forme LUNIX & MAC OS.

## IMPORTANT

vous devez savoir que la plate-forme est encore en cours de développement. la version actuelle n'est pas encore stable.

## QUELQUES PRÉ-REQUIS

Certains fichiers .ahk doivent être compiler avec le compilateur [AutoHotKey](https://www.autohotkey.com) vers .exe

- Unistall.ahp
- install.ahk
- app.ahk
- Compil2Exe.ahk

## DIRECTORY

- www : c'est ici où doivent être placés vos fichiers html|css|js|...
- Le fichier icon doit être ici en format .ico
- src : contient des fichiers HTML
- Libs : contient  des librairies pour le bon fonctionnement du système
- Database : les fichiers et répertoires de la base des données NoSql
- manifest.json : le configurations nécessaire sans oublier de point vers le fichier html pricipale par défaut le fichier principal est nommé : index.html

### WEB FILE

 ces fichiers doivent être copier dans la le répertoire Webfiles vers le respertoir src là ou est situe vos fichiers html.
 ou vous pouvez le placer n'import où dans le dossier "src"

### css

 pour ceux qui veulent quelque class de la bibliothèque deskframe. il peuvent importé la bibliothèque css
 `<link rel="stylesheet" type="text/css" href="./deskframe.css" />`

### javascript

 si vous voulez utiliser le fichier JS qui offre des fonctionnalités supplémentaires à votre appréciation dans votre fichier HTML
 il vous faut l'importer avec "script".
 Ex: `<script src="./deskframe.js"></script>`

 Mais dans des framework Quasar, Nuxt ou autres vous pouvez juste l'importer comme suit : import deskframe from "./deskframe".
 pour que cella soit possible vous devez ajouter "export default" devant la fonction "Deskframe()" dans le fichier "deskframe.js".

 ce bibliothèque Javascript de Deskframe vous permettra de communiquer avec le système et d'exécuter des fonctions directement liées au système d'exploitation windows.

## CONFIGS du fichier manifest.json

```json
{
  "frame": {
    "srcUrl": "", // (string) l'url à utilisé à la place du fichier fourni dans "srcFile". il n'est pas obligatoire mais si il est fourni il doit commencer par le protocole http que vous préférez utiliser. http:// ou https://
    "port": 0, // (Number)* cette valeur est obligatoire. 0 : veut dire ne pas utiliser un port particulier, le système va utilisé le port par défaut (9918)
    "srcFile": "index.html", // (string)* obligatoir si "srcUrl" n'est pas fourni et il doit pointé vers votre fichier HTML (index.html)
    "wHeight": 487, // (Number)* obligatoire. Hauteur en pixel.
    "wWidth": 736, // (Number)* obligatoire. Larguer en pixel. ces deux veleurs sont utilisés par l'application au démarrages car il font la résolution en taille que l'application ce lancera avec.
    "titleBar": 1, // (Number)* obligatoir. 1 : la bar de titre est visble. 0 : la bar de titre est cacher de lors votre application prend le mode frameless (sans cadre). *vous devez préparer le modes control dans votre application pour controler le frame. (utiliser framedesk.js pour des fonctions de control de la frame).
    "forceLightTitlebar": 1 // (Number)* obligatoir. 1 : forcer l'application de d'utiliser un cadre systeme et peut etre claire. Note bien car pour rendre votre application Frameless vous devez définir cette option à 1. 0 : l'application utilise un cadre par défaut du système établi par Chrome.
  },
  "app": {
    "name": "Desk Frame App", // (string)* obligatoir. le nom de votre application.
    "package_name": "My_Deskframe_Apps", // (string)* cette valeur est obligatoire et ne doit pas contenir des espaces ou des caractères spécieux. c'est le package name de votre application.
    "description": "Yaur small DeskFrame app description", // (string) un bref description de votre application
    "version": "1.0", // (string|float|int) la version de votre application.
    "icon": "icon.png", // (string)* cetta valeur est obligatoir si vous obliez de la préciser l'installeur de votre application ne viendra pass avec votre logo.
    "siteweb": "monsiteweb.com" // (String) votre site web. cette valeur affichera sur l'interface d'installation de votre application.
  },

  "install_dir": "C:\\Program Files\\DESKFRAME", // le répertoire d'installation que portera vos programmes compiler. il ne pas aussi conseiller de le modifier mais rien ne vous empeche de le faire. apres installation votre software créera un sous répertoire dans ce répertoire et le répertoire portera le nom du package que vous avez donner à votre appréciation.
  "compilator": {} // Vous ne devez pas y toucher à moins que vous sachiez ce que vous faite.
}

```

## COMPILATION

 pour rendre vôtre projet disponible et public il vous faut la distribuer sous format EXE (exécutable) et pour ce faire rien de plus simple.
 il vous suffit de mettre tout vos codes html dans "src" et de lancer le programme "Compiler.exe". après vous pouvez retrouver
 votre application dans le répertoire "Release" de votre projet. ce répertoire se cré automatiquement apres compilation s'il n'existe pas.

*configurations*
 tout les configuration pour le compilateur se trouvent dans le fichier manifeste "manifest.json" mais il est recommandé de ne pas modifier les valeurs dédie à la compilation a moin que vous sachiez ce que vous fait. (mis à part les curieux )

*INSTALLATION*
Deskframe est une framework conçu pour vous rendre la vie facile.
il est léger et à la fois souple. il génère des fichiers exécutable sur tout les plate-forme windows depuis windows 7+
par conséquent il ne nécessite pas trop des pour l'utiliser car vous ne devez meme pas l'installé, il vous suffit juste de le décompresser dans une répertoire de votre choix et le boulot est fait.

*deskframe supporte* :
 SPA (Single Page Application), PWA (Progressive Web App) & le Static Web Page (html, css, js)

- si vous utiliser un framework comme quasar et que vous vouler généré des resources static puis que quasar ne suporte pas la generation des fichiers static. vous pouver utiliser son extension SSG :  "$ quasar ext add ssg"

- les autres framework comme Nuxt eux supporte la generation des ressources web static.
- choses requise:
 Deskframe requiert Google Chrome  pour fonctionner. donc tout vos software généré par le framework ne fonctionneront pas si
 le support ne possède pas Google Chrome.
 Donc vous devez vous rassurer avent que Chrome est installer avent tout.
- 🚩 attention :
 N'executer pas le fichier "uninstaler.exe" dans le meme répertoire du projet. si non vous risquez de perdre tout vos données.😁

## 😎 DEV

Le framework à était ecrite en AHK et il requiert Google Chrome pour être fonctionnel.
si vou avez les source de l'application vous devez savoir le langage de programmation AHK (Autohotkey).

- pour compiler le fichier source setup.ahk en executable. vous devez verifier la version du compilateur qui est inscrite dans
 le fichier lui meme.
 la compilation simple via le menu contextuel echoue. vous devez compiler avec CMD dans le répertoire actuel

 > Compiler\Ahk2Exe.exe /in setup.ahk
 le compilateur inscrite est de 32bit. car il peut arriver que à l'execution le programme ne lance pas le serveur par ce que le
 type du compilateur est de bit diferent.

## DESINSTALLION

pour desinstaller les applications compiler par deskframe. vous devez partir retrouver de programe de désinstallation dans le Menu démarrer de windows. car le programme ne sont pas encor visible dans le gestionnaire des applications installer de windows.
il vous suffit just d'écrire le nom de votre application dans la bar de recherche de wondows et vous verrez un application qui commence par "uninstall nom de votre application".
