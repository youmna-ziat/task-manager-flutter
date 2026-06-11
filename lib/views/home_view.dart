// View - Écran principal avec liste des tâches

import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';
import 'add_task_view.dart';
import 'edit_task_view.dart';
import 'stats_view.dart';
import 'login_view.dart';

class HomeView extends StatefulWidget {
  final String username;

  const HomeView({super.key, required this.username});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TaskController _controller = TaskController();
  bool _isLoading = true;
  String _filterCategory = 'Toutes';
  String _filterPriority = 'Toutes';
  bool _showCompleted = true;

  final List<String> _categories = [
    'Toutes',
    'General',
    'Travail',
    'Personnel',
    'Courses',
    'Santé',
  ];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    await _controller.loadTasks();
    if (mounted) setState(() => _isLoading = false);
  }

  List<Task> get _filteredTasks {
    return _controller.tasks.where((task) {
      final matchCategory =
          _filterCategory == 'Toutes' || task.category == _filterCategory;
      final matchPriority =
          _filterPriority == 'Toutes' || task.priority == _filterPriority;
      final matchCompleted = _showCompleted || !task.isCompleted;
      return matchCategory && matchPriority && matchCompleted;
    }).toList();
  }

  Future<void> _deleteTask(Task task) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Supprimer la tâche'),
        content:
            Text('Voulez-vous supprimer "${task.title}" ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Supprimer',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _controller.deleteTask(task.id!);
      setState(() {});
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tâche supprimée'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Color _priorityColor(String priority) {
    switch (priority) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _priorityLabel(String priority) {
    switch (priority) {
      case 'high':
        return 'Haute';
      case 'medium':
        return 'Moyenne';
      case 'low':
        return 'Faible';
      default:
        return priority;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filtered = _filteredTasks;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bonjour, ${widget.username} 👋',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            Text('${_controller.pendingTasks} tâche(s) en attente',
                style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSurface.withOpacity(0.6))),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart_rounded),
            tooltip: 'Statistiques',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      StatsView(controller: _controller)),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Déconnexion',
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginView()),
            ),
          ),
        ],
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // ─── Filtres ─────────────────────────────────────────
                Container(
                  color: theme.colorScheme.surface,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  child: Column(
                    children: [
                      // Filtre catégories
                      SizedBox(
                        height: 36,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _categories.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 8),
                          itemBuilder: (_, i) {
                            final cat = _categories[i];
                            final selected = _filterCategory == cat;
                            return FilterChip(
                              label: Text(cat,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: selected
                                          ? Colors.white
                                          : null)),
                              selected: selected,
                              onSelected: (_) => setState(
                                  () => _filterCategory = cat),
                              selectedColor: theme.colorScheme.primary,
                              checkmarkColor: Colors.white,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Options affichage
                      Row(
                        children: [
                          const Text('Afficher terminées :',
                              style: TextStyle(fontSize: 13)),
                          const SizedBox(width: 6),
                          Switch.adaptive(
                            value: _showCompleted,
                            onChanged: (v) =>
                                setState(() => _showCompleted = v),
                          ),
                          const Spacer(),
                          Text(
                            '${filtered.length} tâche(s)',
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.colorScheme.onSurface
                                  .withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ─── Liste des tâches ─────────────────────────────────
                Expanded(
                  child: filtered.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check_circle_outline,
                                  size: 72,
                                  color: theme.colorScheme.primary
                                      .withOpacity(0.3)),
                              const SizedBox(height: 16),
                              Text(
                                'Aucune tâche',
                                style: theme.textTheme.titleMedium
                                    ?.copyWith(
                                        color: theme.colorScheme.onSurface
                                            .withOpacity(0.5)),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Appuyez sur + pour en ajouter une',
                                style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.4)),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: _loadTasks,
                          child: ListView.builder(
                            padding: const EdgeInsets.fromLTRB(
                                16, 12, 16, 100),
                            itemCount: filtered.length,
                            itemBuilder: (_, i) {
                              final task = filtered[i];
                              return _TaskCard(
                                task: task,
                                priorityColor:
                                    _priorityColor(task.priority),
                                priorityLabel:
                                    _priorityLabel(task.priority),
                                onToggle: () async {
                                  await _controller.toggleTask(task);
                                  setState(() {});
                                },
                                onEdit: () async {
                                  final updated = await Navigator.push<bool>(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => EditTaskView(
                                        task: task,
                                        controller: _controller,
                                      ),
                                    ),
                                  );
                                  if (updated == true) {
                                    await _loadTasks();
                                  }
                                },
                                onDelete: () => _deleteTask(task),
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final added = await Navigator.push<bool>(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  AddTaskView(controller: _controller),
            ),
          );
          if (added == true) await _loadTasks();
        },
        icon: const Icon(Icons.add),
        label: const Text('Nouvelle tâche'),
      ),
    );
  }
}

// ─── Widget carte de tâche ────────────────────────────────────────────────────

class _TaskCard extends StatelessWidget {
  final Task task;
  final Color priorityColor;
  final String priorityLabel;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _TaskCard({
    required this.task,
    required this.priorityColor,
    required this.priorityLabel,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: task.isCompleted
            ? theme.colorScheme.surface.withOpacity(0.5)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(color: priorityColor, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (_) => onToggle(),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          activeColor: theme.colorScheme.primary,
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: task.isCompleted
                ? theme.colorScheme.onSurface.withOpacity(0.45)
                : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                task.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withOpacity(0.55),
                  fontSize: 13,
                ),
              ),
            ],
            const SizedBox(height: 6),
            Row(
              children: [
                _Chip(label: task.category, color: theme.colorScheme.primary),
                const SizedBox(width: 6),
                _Chip(label: priorityLabel, color: priorityColor),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit_outlined,
                  color: theme.colorScheme.primary, size: 20),
              onPressed: onEdit,
              tooltip: 'Modifier',
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline,
                  color: Colors.red, size: 20),
              onPressed: onDelete,
              tooltip: 'Supprimer',
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;

  const _Chip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}