# Task Manager - Flutter MVC Application

## Description

Task Manager est une application mobile développée avec Flutter permettant aux utilisateurs de gérer efficacement leurs tâches quotidiennes.

L'application a été réalisée dans le cadre du mini-projet du module Flutter. Elle respecte l'architecture MVC (Model - View - Controller) et intègre les principales fonctionnalités d'une application mobile moderne.

---

## Fonctionnalités

### Authentification

* Inscription utilisateur
* Connexion utilisateur
* Validation des informations saisies

### Gestion des tâches

* Ajouter une tâche
* Modifier une tâche
* Supprimer une tâche
* Marquer une tâche comme terminée
* Filtrer les tâches

### Statistiques

* Nombre total de tâches
* Nombre de tâches terminées
* Nombre de tâches en attente

### Stockage local

* Sauvegarde des utilisateurs avec SQLite
* Sauvegarde des tâches avec SQLite
* Conservation des données après fermeture de l'application

### Interface utilisateur

* Interface moderne et responsive
* Design Material 3
* Navigation fluide entre les écrans
* Thème personnalisé

---

## Architecture MVC

Le projet suit l'architecture MVC :

### Model

Contient les modèles de données :

* Task
* User

### View

Contient les interfaces graphiques :

* LoginView
* RegisterView
* HomeView
* AddTaskView
* EditTaskView
* StatsView

### Controller

Contient la logique métier :

* AuthController
* TaskController

### Database

Gestion de la base SQLite :

* DatabaseHelper

---

## Technologies Utilisées

* Flutter
* Dart
* SQLite
* Material Design 3
* Architecture MVC

---

## Structure du Projet

```text
lib/
│
├── controllers/
│   ├── auth_controller.dart
│   └── task_controller.dart
│
├── database/
│   └── database_helper.dart
│
├── models/
│   ├── task.dart
│   └── user.dart
│
├── views/
│   ├── login_view.dart
│   ├── register_view.dart
│   ├── home_view.dart
│   ├── add_task_view.dart
│   ├── edit_task_view.dart
│   └── stats_view.dart
│
└── main.dart
```




## Réalisé par

ZIAT Youmna
RIAK Yasser

2ème année Cycle Ingénieur

Projet Flutter 2025/2026
