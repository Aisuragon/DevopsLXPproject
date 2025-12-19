⢀⡴⠑⡄⠀⠀⠀⠀⠀⠀⠀⣀⣀⣤⣤⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
⠸⡇⠀⠿⡀⠀⠀⠀⣀⡴⢿⣿⣿⣿⣿⣿⣿⣿⣷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
⠀⠀⠀⠀⠑⢄⣠⠾⠁⣀⣄⡈⠙⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀ 
⠀⠀⠀⠀⢀⡀⠁⠀⠀⠈⠙⠛⠂⠈⣿⣿⣿⣿⣿⠿⡿⢿⣆⠀⠀⠀⠀⠀⠀⠀ 
⠀⠀⠀⢀⡾⣁⣀⠀⠴⠂⠙⣗⡀⠀⢻⣿⣿⠭⢤⣴⣦⣤⣹⠀⠀⠀⢀⢴⣶⣆ 
⠀⠀⢀⣾⣿⣿⣿⣷⣮⣽⣾⣿⣥⣴⣿⣿⡿⢂⠔⢚⡿⢿⣿⣦⣴⣾⠁⠸⣼⡿ 
⠀⢀⡞⠁⠙⠻⠿⠟⠉⠀⠛⢹⣿⣿⣿⣿⣿⣌⢤⣼⣿⣾⣿⡟⠉⠀⠀⠀⠀⠀ 
⠀⣾⣷⣶⠇⠀⠀⣤⣄⣀⡀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀ 
⠀⠉⠈⠉⠀⠀⢦⡈⢻⣿⣿⣿⣶⣶⣶⣶⣤⣽⡹⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀ 
⠀⠀⠀⠀⠀⠀⠀⠉⠲⣽⡻⢿⣿⣿⣿⣿⣿⣿⣷⣜⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀ 
⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣷⣶⣮⣭⣽⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀ 
⠀⠀⠀⠀⠀⠀⣀⣀⣈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀ 
⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀ 
⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀ 
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠻⠿⠿⠿⠿⠛⠉
-------------------------------------
DevopsLXP – Projet CI/CD Web
Ce projet montre la mise en place d’une chaîne CI/CD complète pour une application web statique servie par Nginx dans un conteneur Docker.
Le code est hébergé sur GitHub, la CI/CD est gérée par GitHub Actions et le déploiement se fait sur une VM Ubuntu via un runner self‑hosted.

1. Objectifs du projet
Mettre en place l’intégration continue : lancer automatiquement des vérifications/tests à chaque push.

Mettre en place le déploiement continu : déploiement automatique sur une VM après validation.

Conteneuriser l’application web avec Docker et la lancer via docker compose puis via une image poussée sur un registre.

Vérifier qu’un bug introduit dans le code fait bien échouer la pipeline.

2. Architecture
Application : page statique index.nginx-debian.html.

Conteneurisation :

Dockerfile : image Nginx personnalisée qui sert la page.

docker-compose.yml : définition du service web exposé sur le port 8080 (8080→80).

CI/CD :

GitHub Actions : fichier .github/workflows/ci-cd.yml.

Runner self-hosted installé sur la VM.

3. Lancement local
Prérequis : Docker Engine et docker compose installés.

Cloner le dépôt :

bash
git clone git@github.com:<TON_LOGIN>/DevopsLXPproject.git
cd DevopsLXPproject
Lancer l’application (mode compose) :

bash
docker compose up -d --build
Accéder au site :

http://<IP_VM>:8080

Arrêter les conteneurs :

bash
docker compose down
4. Pipeline CI/CD
Le pipeline GitHub Actions se trouve dans .github/workflows/ci-cd.yml.

Phase 1 – CI (vérifications/tests)
Déclenché sur chaque push / pull_request vers main.

Récupère le code.

Vérifie que le fichier index.nginx-debian.html existe.

Vérifie la configuration docker-compose.yml.

(Optionnel) exécute un script de test simple.

Si une vérification échoue, le job passe en rouge et la suite de la pipeline est bloquée.

Phase 2 – Déploiement automatique sur la VM (runner self‑hosted)
Un runner self‑hosted GitHub Actions tourne sur la VM Ubuntu.

À chaque push sur main :

Le job deploy_vm s’exécute sur runs-on: self-hosted.

Le code du dépôt est récupéré sur la VM.

docker compose up -d --build est lancé pour (re)construire l’image et redémarrer le conteneur.

Résultat : à chaque merge/push sur main, la VM met automatiquement à jour la version de l’application web.

Phase 3 – Build et déploiement d’image Docker
Job docker_build_push (hébergé GitHub) :

Se connecte à un registre Docker (Docker Hub).

Construit l’image depuis le Dockerfile.

Push l’image avec deux tags :

<user>/devopslxp:<SHA_DU_COMMIT>

<user>/devopslxp:latest

Job deploy_docker (runner self‑hosted) :

Fait un docker pull de l’image taggée avec le SHA du commit.

Stoppe et supprime l’ancien conteneur devopslxp-web.

Lance un nouveau conteneur devopslxp-web sur le port 8080 avec l’image fraîchement poussée.

Cette phase illustre un vrai scénario “build dans la CI, pull en prod” au lieu de builder directement sur la VM.

5. Runner self‑hosted sur la VM
Sur la VM :

Installer Docker + docker compose.

Créer un utilisateur (ex. enzo) et l’ajouter au groupe docker pour utiliser Docker sans sudo.

Télécharger et configurer le runner GitHub dans ~/actions-runner.

Lancer le runner (ou l’installer comme service) pour qu’il prenne en charge les jobs runs-on: self-hosted.

Le job de déploiement n’utilise pas de SSH entrant : tout s’exécute localement sur la VM via le runner.

6. Démonstration / Scénario type
Un membre de l’équipe modifie index.nginx-debian.html.

git add, git commit, git push sur main.

La pipeline CI/CD s’exécute :

Phase 1 : vérifications.

Phase 2 : déploiement via docker compose (ou Phase 3 : build/push + docker run).

La nouvelle version est accessible sur http://<IP_VM>:8080.

7. Améliorations possibles
Ajouter de vrais tests unitaires ou d’intégration.

Mettre en place une branche de staging avec un deuxième environnement.

Ajouter des checks de qualité (lint, format, etc.).

Gérer plusieurs services (API, BDD) dans le docker-compose.yml.
