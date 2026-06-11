// Controller - gestion des tâches

import '../database/database_helper.dart';
import '../models/task.dart';

class TaskController {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Task> tasks = [];

  // Charger toutes les tâches
  Future<void> loadTasks() async {
    final data = await _dbHelper.getTasks();
    tasks = data.map((map) => Task.fromMap(map)).toList();
  }

  // Valider les champs d'une tâche
  String? validateTask(String title) {
    if (title.trim().isEmpty) return 'Le titre est requis';
    if (title.trim().length < 2) return 'Le titre est trop court';
    if (title.trim().length > 100) return 'Le titre est trop long (max 100 caractères)';
    return null; // null = valide
  }

  // Ajouter une tâche
  Future<String?> addTask({
    required String title,
    String description = '',
    String category = 'General',
    String priority = 'medium',
  }) async {
    final error = validateTask(title);
    if (error != null) return error;

    final task = Task(
      title: title.trim(),
      description: description.trim(),
      category: category,
      priority: priority,
    );
    await _dbHelper.insertTask(task);
    await loadTasks();
    return null;
  }

  // Mettre à jour une tâche
  Future<String?> updateTask(Task task, String newTitle,
      {String? description, String? category, String? priority}) async {
    final error = validateTask(newTitle);
    if (error != null) return error;

    task.title = newTitle.trim();
    if (description != null) task.description = description.trim();
    if (category != null) task.category = category;
    if (priority != null) task.priority = priority;

    await _dbHelper.updateTask(task);
    await loadTasks();
    return null;
  }

  // Supprimer une tâche
  Future<void> deleteTask(int id) async {
    await _dbHelper.deleteTask(id);
    await loadTasks();
  }

  // Basculer l'état complété/non complété
  Future<void> toggleTask(Task task) async {
    task.isCompleted = !task.isCompleted;
    await _dbHelper.updateTask(task);
    await loadTasks();
  }

  // Statistiques
  int get totalTasks => tasks.length;
  int get completedTasks => tasks.where((t) => t.isCompleted).length;
  int get pendingTasks => tasks.where((t) => !t.isCompleted).length;

  List<Task> getByCategory(String category) =>
      tasks.where((t) => t.category == category).toList();

  List<Task> getByPriority(String priority) =>
      tasks.where((t) => t.priority == priority).toList();
}