# GitHub Tracker
> Examen Flutter 2022-2023
This Tracker is of course a way to track your activity on GitHub, and also activity of wanted user.
You can also track a specific repository to have all news about it.

## 🗂️|Répartition des Dossiers du Repository
- **Documentation** : Rassemble toutes les informations relatives a la documentation utilisé pour le projet (consigne, lien vers d'autres documentations...).
- **Mockup**: Rassemble tout ce qui est en rapport avec les différentes maquettes de l'applications.
- **Source**: Je vous laisse devinez...

## 📜|Description de l'Application
N'avez vous jamais été curieux d'en connaître un peux plus sur votre activité github ? Ou celle d'un Repository ? voir même d'un autre utilisateur ? Le tout depuis votre smartphone, sur un feed communs ? Si c'est votre cas, alors cette application est faite pour vous.

**Premièrement**, l'application aura comme fonctionnalité le fait de **traqué** toute l'**activité** de votre profil **Github** dans un seul **feed**, Ce dernier traquera vos *commits*, *Merges*, *issues*, *pull request*... fait sur tout les repository que vous utilisé (Votre ou non). Il permettra également de traqué l'**activité** d'une **liste** de **repository publics** dont vous souhaitez gardé la trace. Une dernière fonctionnalité permettra de **traqué** toute l'**activité publique** d'un ou plusieurs **utilisateur** que vous sélectionnerer.

Le feed une fois remplis pourra être **filtré** à votre souhait. En effet vous pourrez choisir de n'afficher que les "commits", les "Code Review", les "issues", les "pull request", Une autre option lui permettra de choisir quel utilisateur (sois même ou un dans la liste des tracks), ainsi qu'un Repository (un créer par nous mêmes, ou un dans la liste des tracks) traqué.

Une **Liste noire** permettra de mettre en **"sourdine"** vos **repository** que vous ne voulez plus traqué.
Par défaut lors de la première connexion sur l'application, les repository "Starred" seront ajouter a la liste des repository traqué. De même pour les utilisateurs que vous suivez.



## 📱|Application Existante
Bien entendus GitHub lui même propose déjà quelques choses de similaire sur sa propre Mainpage. Cependant il n'y a quasiment aucun moyen de filtré se feed pour retrouver des informations. De plus il ne ce concentre que sur certains repository, les votres, les starred, les "watched" ou les personnes que vous suivez. Mais peut être que vous ne voulez pas nécessairement être vus par les personnes que vous traqué, dans notre cas cela permet de rester relativement anonyme a ce niveau.

![Image montrant le feed de Github](https://raw.githubusercontent.com/bastin-thomas/GitHubTracker/main/MockUp/FeedsImage.png?token=GHSAT0AAAAAACHX2GCVGMCEEHKG7IR327BKZKWPBQQ)

L'autre triste nouvelle est que l'application Github officiel ne permet pas de traqué des activités sur un seul feed principal. Il existe une fonctionnalité "Explore" Censé vous présenter de nouveau repository, mais nous sommes loin d'un équivalent a notre application.



## ✨|Fonctionnalitée:
- *En tant qu'utilisateur* *je veux* pouvoir me connecter en utilisant la connexion GitHub *afin d'utiliser* l'application et si c'est la première fois, importer mes starred repository ainsi que mes abonnements a d'autres utilisateurs.

- *En tant qu'utilisateur* je peux décider de resynchroniser mes track en fonction des starred repo et abonnements dans les paramètres (Suppression des choix customs fait sur l'application). 

- *En tant qu'utilisateur* je peux ajouté ou supprimer des repository externe dans une liste afin de les traqués dans mon feed ou non.
- *En tant qu'utilisateur* je peux ajouté ou supprimer d'autres membres de GitHub dans une liste afin de les traqués dans mon feed ou non.

- *En tant qu'utilisateur* je peux sélectionner un ou plusieurs utilisateurs (dont moi même) afin de filtré temporairement mon feed en ne voyant que ceux souhaités.
- *En tant qu'utilisateur* je peux sélectionner un ou plusieurs Repository (dont les miens) afin de filtré temporairement mon feed en ne voyant que ceux souhaités.
- *En tant qu'utilisateur* je peux sélectionner un ou plusieurs Type de message du feed (pull request, issues,  starred, commits...) afin de filtré temporairement mon feed en ne voyant que ceux souhaités.

- *En tant qu'utilisateur* je peux sélectionner un thème claire ou un thème foncé afin d'ajusté au mieux mes envies du moment.
- *En tant qu'utilisateur* je peux navigué jusqu'a une page d'information donnant plus de contexte a la création de l'application.

## 💻|Mockup:
![Image montrant les mockups.](https://media.discordapp.net/attachments/431911532675465241/1052160423023095828/ToUpload.png)

## ♻️|Etat d'Avancement

✅ Création du ReadMe

✅ Création de l'arborescence du Repository

✅ Conception du Mockup / Maquette

✅ Creation UI Page Login

✅ Creation Logique Page Login

✅ Creation Menu Navigation

✅ Creation des routes Flutters

☐ Creation de la page Principal (Feed)

✅ Creation des Widgets représentant les différents Messages du Feed

☐ Creation de la page d'option

☐ Ajout de la liste des personnes a traqué

☐ Ajout de la liste des repository a traqué

☐ Ajout de la liste noire des repository personnels a ne pas traqué

☐ Creation de la logique de Filtre du Feed

☐ Creation de la page "Information"
