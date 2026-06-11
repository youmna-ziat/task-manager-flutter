import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';

class StatsView extends StatelessWidget {
  final TaskController controller;

  const StatsView({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Statistiques"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.list),
                title: const Text("Total des tâches"),
                trailing: Text(
                  controller.totalTasks.toString(),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.check_circle),
                title: const Text("Tâches terminées"),
                trailing: Text(
                  controller.completedTasks.toString(),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.pending_actions),
                title: const Text("Tâches en attente"),
                trailing: Text(
                  controller.pendingTasks.toString(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}