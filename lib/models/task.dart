// Model - représente une tâche

class Task {
  int? id;
  String title;
  String description;
  String category;
  String priority; // 'high', 'medium', 'low'
  bool isCompleted;
  DateTime createdAt;

  Task({
    this.id,
    required this.title,
    this.description = '',
    this.category = 'General',
    this.priority = 'medium',
    this.isCompleted = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'priority': priority,
      'isCompleted': isCompleted ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'] ?? '',
      category: map['category'] ?? 'General',
      priority: map['priority'] ?? 'medium',
      isCompleted: map['isCompleted'] == 1,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
    );
  }
}