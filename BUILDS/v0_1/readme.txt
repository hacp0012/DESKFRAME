- Le fichier icon doit être ici en format .icos
- src : contient des fichiers HTML
- Libs : contient  des librairies pour le bon fonctionnement du système 
- Database : les fichiers et répertoires de la base des données NoSql
- configs.json : le configurations nécessaire sans oublier de point vers le fichier html pricipale
	par défaut le fichier principal est nommé : index.html

INSTALLER
- demander si le répertoire actuel ne doit pas etre supprimer apres installation.
- - cree raccourci sur le bureau qui point vers le répertoire actuel.
- - cree raccourci dans le menu démarrer.

UNINSTALLER
- retirer tout les raccourci cree
- demander à l'utilisateur s'il veut supprimé aussi le répertoire source.

DOCUMENTATION TEMPLATE
* DIRECTORY
- www : c'est ici où doivent être placés vos fichiers html|css|js|...
* WEB FILE
	ces fichiers doivent être copier dans la le répertoire Webfiles vers le respertoir src là ou est situe vos fichiers html.
	ou vous pouvez le placer n'import où dans le dossier "src"
- Css
- JS
	si vous voulez utiliser le fichier JS qui offre des fonctionnalités supplémentaires à votre appréciation dans votre fichier HTML
	il vous faut l'importer comme Module. sans oublie de speciefier le type dans la balise <script type="modules">. 
	Ex:
	<script type="module">
		import Deskframe from "./deskframe.js";

      		const desk = new Deskframe();
      		console.log("You use:", desk.Version, "version of DeskFrame framework.");
    	</script>
	
	Mais dans des framework Quasar, Nuxt ou autres vous pouvez juste l'importer comme suit : import deskframe from "./deskframe";

* CONFIGS
- {
  "frame": { // Context de la fenêtre 
    "srcUrl": "", // (string) URI a requêter a la place srcFile. si laissé vide srcFile est utiliser à la place. Non obligatoir (laisser vide)
    "srcFile": "index.html", // (string) Fichier pricipale a utiliser ou fichier source a lancer.
    "wHeight": 700, // (int) Hauteur de la fenêtre à l'ouverture de la fenêtre. il se mesure en Pixel
    "wWidth": 1000, // (int) Largeur de la fenêtre à l'ouverture de la fenêtre. il se mesure en Pixel
    "titleBar": 1, // (bool: 0|1) Afficher ou non la bar de titre.
    "forceLightTitlebar": 1 // (bool: 0|1) forcé la fenêtre à utiliser le style de la bar de titre de windows.
    "srcIcon": "", // (string) Le chemin vers le fichier icon a utilisé quand l'application est lancé. Non obligatoir (laisser vide)
  },
  "compiler": { // configuration du compulateur
    "imports": [],
    "icon": ""
  }
}


* COMPILATION
- Config
* INSTALLATION 
- il supporte : SPA (Single Page Application), PWA (Progressive Web App) & le Static Web Page (html, css, js)
	- si vous utiliser un framework comme quasar et que vous vouler généré des resources static puis que quasar ne suporte pas 
		la generation des fichiers static. vous pouver utiliser son extension SSG :  "$ quasar ext add ssg"
	- les autres framework comme Nuxt eux supporte la generation des ressources web static.