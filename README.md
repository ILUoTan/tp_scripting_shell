<<<<<<< HEAD
# tp_scripting_shell
A shell script project to analyze log files
=======
# TP - Scripting Shell

Ce projet consiste en un script Shell developpe pour analyser des fichiers de logs. Il permet d'aggreguer les logs par niveau de log (trace, debug, info, warn, error, fatal) et d'effectuer une analyse temporelle (jour le plus actif, heure la plus>

## Prerequis

- **Systeme d'exploitation** : Le script a ete teste sous Linux (distribution Ubuntu).
- **Bash version 5.2.21** :
  - La version de Bash utilisee est la suivante :
    ```bash
    GNU bash, version 5.2.21(1)-release (x86_64-pc-linux-gnu)
    ```
- **Outils necessaires** :
  - `grep`
  - `awk`
  - `sort`
  - `uniq`
  - `sed`
  Ces utilitaires sont necessaires pour le traitement des fichiers de logs.

## Fonctionnalites

## 1. Aggregation des logs
Le script agrege les logs en comptant les occurrences de chaque niveau de log (`trace`, `debug`, `info`, `warn`, `error`, `fatal`) et identifie les messages les plus frequents et les moins frequents.

## 2. Analyse temporelle
Il effectue une analyse temporelle des logs pour determiner :
- Le jour le plus actif.
- L'heure la plus active.
- L'heure la plus sujette aux erreurs (`error` ou `fatal`).

## 3. Affichage colore
Le script utilise des couleurs pour rendre les resultats plus lisibles :
- **Rouge** pour les erreurs et les messages critiques.
- **Vert** pour les succes ou les informations importantes.
- **Jaune** pour attirer l'attention sur des informations secondaires.

## Installation

Aucune installation specifique n'est necessaire. Il suffit de telecharger ou cloner le fichier `log_analyzer.sh` et de rendre le script executable.

1. Clonez ce projet ou telechargez le fichier `log_analyzer.sh`.
2. Rendez le script executable avec la commande suivante :
   ```bash
   chmod +x log_analyzer.sh



1. Commande : 
   ./log_analyzer.sh aggregate <logfile>
   Description : Cette commande ex  cute l'agr  gation des logs. Il est n  cessaire de remplacer <logfile> par le nom d'un fichier de logs valide.
   
   Erreur possible : 
   - Si <logfile> n'est pas remplac   par un fichier valide, le script affichera une erreur d'argument manquant et l'aide du script.
   - Erreur typique : 
     Usage: ./log_analyzer.sh <command> <logfile>

---

2. Command:
   ./log_analyzer.sh temporal_analysis <logfile>
   Description : Cette commande effectue une analyse temporelle des logs. <logfile> doit   tre remplac   par un fichier valide contenant des logs.

   Erreur possible : 
   - Si <logfile> n'est pas remplac   par un fichier valide, le script affichera un message d'erreur similaire    celui de la commande pr  c  dente.
   - Erreur typique : 
     Usage: ./log_analyzer.sh <command> <logfile>

---

3. Command:
   ./log_analyzer.sh aggregate logfile.log
   Description : Cette commande effectue l'agr  gation des logs dans le fichier logfile.log. Elle calcule le nombre d'occurrences pour chaque niveau de log et identifie les messages les plus fr  quents et les moins fr  quents.

   Erreur possible : 
   - Fichier inexistant ou illisible : Si logfile.log n'existe pas ou n'est pas lisible, le script arr  tera l'ex  cution avec un message d'erreur.
   - Erreur typique : 
     Error: File 'logfile.log' is either not found or not readable!
   - Cause : Cela peut   tre d      une erreur de chemin d'acc  s, ou des permissions de fichier insuffisantes.

---

4. Command:
   ./log_analyzer.sh temporal_analysis logfile.log
   Description : Cette commande effectue l'analyse temporelle sur le fichier logfile.log. Elle identifie les jours et heures les plus actifs, ainsi que les heures avec le plus grand nombre d'erreurs (error et fatal).

   Erreur possible : 
   - Fichier inexistant ou illisible : Si le fichier logfile.log n'existe pas ou si ses permissions sont incorrectes, le script renverra une erreur similaire    celle mentionn  e ci-dessus.
   - Erreur typique : 
     Error: File 'logfile.log' is either not found or not readable!
   - Cause : Cela est d      une erreur dans le chemin d'acc  s du fichier ou    des restrictions de permissions.

---



5. Command:
   ./log_analyzer.sh aggregate <logfile>
   Description : Cette commande est une r  p  tition de la premi  re, mais cette fois avec une syntaxe correcte en rempla  ant <logfile> par un fichier r  el.

   Erreur possible : 
   - M  me erreur que pr  c  demment si <logfile> n'est pas remplac   par un fichier valide.
   - Erreur typique : 
     Error: File '<logfile>' is either not found or not readable!
   - Cause : L'utilisateur doit s'assurer que <logfile> soit remplac   par le nom r  el du fichier    analyser.

---

### R  sum   des erreurs possibles et de leurs causes :
1. Erreur d'argument manquant ou invalide : Cela se produit si les arguments fournis au script sont incomplets ou incorrects. Par exemple, ne pas sp  cifier le nom du fichier de log.
   - Exemple : 
     Usage: ./log_analyzer.sh <command> <logfile>

2. Fichier non trouv   ou illisible : Cela se produit si le fichier de log sp  cifi   n'existe pas dans le r  pertoire ou si le script n'a pas la permission de le lire.
   - Exemple :
     Error: File 'logfile.log' is either not found or not readable!

3. Fichier incorrect ou inexistant : L'utilisateur doit s'assurer que le fichier existe et qu'il peut   tre ouvert (permissions).
   - Exemple :
     Error: File '<logfile>' is either not found or not readable!

### Conclusion
Le script peut   chouer pour plusieurs raisons : arguments incorrects, fichiers manquants ou mal format  s, ou permissions insuffisantes. Il est essentiel de s'assurer que tous les arguments sont fournis correctement et que le fichier de log est >
>>>>>>> dcf5977 (Initial commit - adding tp_scripting_shell project)
