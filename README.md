# 📋 Task Manager - Flutter MVC Application

## 📖 Présentation

Task Manager est une application mobile développée avec Flutter permettant aux utilisateurs de gérer efficacement leurs tâches quotidiennes.

Ce projet a été réalisé dans le cadre du mini-projet du module **Développement Mobile avec Flutter** (2ème année Cycle Ingénieur 2025/2026).

L'application respecte l'architecture **MVC (Model - View - Controller)** et intègre les principales fonctionnalités demandées dans le cahier des charges.

---

# 🎯 Objectifs du Projet

* Développer une application mobile complète avec Flutter
* Appliquer l'architecture MVC
* Mettre en œuvre l'authentification utilisateur
* Réaliser les opérations CRUD
* Utiliser une base de données locale SQLite
* Concevoir une interface moderne et responsive
* Respecter les bonnes pratiques de développement

---

# ✨ Fonctionnalités Réalisées

## 🔐 Authentification

* Création de compte utilisateur
* Connexion utilisateur
* Validation des champs
* Vérification des identifiants

## ✅ Gestion des Tâches

* Ajouter une tâche
* Modifier une tâche
* Supprimer une tâche
* Marquer une tâche comme terminée
* Gestion des priorités
* Gestion des catégories

## 📊 Statistiques

* Nombre total de tâches
* Nombre de tâches terminées
* Nombre de tâches en attente

## 💾 Stockage Local

* Sauvegarde des utilisateurs avec SQLite
* Sauvegarde des tâches avec SQLite
* Conservation des données après fermeture de l'application

## 🎨 Interface Utilisateur

* Interface moderne avec Material Design 3
* Navigation fluide entre les écrans
* Responsive Design
* Thème personnalisé
* Support du Dark Mode (si activé par le système)

---

# 🏗️ Architecture MVC

Le projet est organisé selon le modèle MVC.

## Model

Les modèles représentent les données manipulées par l'application.

* Task
* User

## View

Les vues représentent l'interface utilisateur.

* LoginView
* RegisterView
* HomeView
* AddTaskView
* EditTaskView
* StatsView

## Controller

Les contrôleurs contiennent la logique métier.

* AuthController
* TaskController

## Database

Gestion de la base de données locale SQLite.

* DatabaseHelper

---

# 📁 Structure du Projet

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

---

# 🛠️ Technologies Utilisées

| Technologie       | Utilisation              |
| ----------------- | ------------------------ |
| Flutter           | Développement mobile     |
| Dart              | Langage de programmation |
| SQLite            | Base de données locale   |
| Material Design 3 | Interface utilisateur    |
| MVC               | Architecture logicielle  |

---

# 🚀 Installation

## 1. Cloner le projet

```bash
git clone https://github.com/youmna-ziat/task-manager-flutter.git
```

## 2. Accéder au dossier

```bash
cd task-manager-flutter
```

## 3. Installer les dépendances

```bash
flutter pub get
```

## 4. Lancer l'application

```bash
flutter run
```

---

# 📱 Écrans Principaux

* Écran de connexion
* Écran d'inscription
* Liste des tâches
* Ajout d'une tâche
* Modification d'une tâche
* Tableau des statistiques

---

# 🎥 Démonstration

Une vidéo de démonstration présentant les principales fonctionnalités de l'application accompagne le rapport du projet.

Fonctionnalités démontrées :

* Création d'un compte
* Connexion
* Ajout de tâches
* Modification de tâches
* Suppression de tâches
* Gestion des statuts
* Consultation des statistiques

---

# 📌 Fonctionnalités du Cahier des Charges Respectées

* Authentification (Login / Register)
* Navigation entre plusieurs écrans
* CRUD complet
* Utilisation de formulaires
* Validation des champs
* Stockage local SQLite
* Interface moderne et responsive
* Architecture MVC
* Design personnalisé
* Statistiques des tâches

---

# 👨‍💻 Réalisé Par

ZIAT Youmna
RIAK Yasser

2ème Année Cycle Ingénieur

Année Universitaire 2025/2026

---
