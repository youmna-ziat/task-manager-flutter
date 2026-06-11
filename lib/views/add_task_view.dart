import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';

class AddTaskView extends StatefulWidget {
  final TaskController controller;

  const AddTaskView({
    super.key,
    required this.controller,
  });

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String category = "General";
  String priority = "medium";

  Future<void> saveTask() async {
    if (!_formKey.currentState!.validate()) return;

    final error = await widget.controller.addTask(
      title: titleController.text,
      description: descriptionController.text,
      category: category,
      priority: priority,
    );

    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
      return;
    }

    if (!mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nouvelle tâche")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Titre",
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? "Titre obligatoire" : null,
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Description",
                ),
              ),

              const SizedBox(height: 16),

              // APRÈS
DropdownButtonFormField<String>(
  value: category,
  decoration: const InputDecoration(
    labelText: "Catégorie",
  ),
                items: const [
                  DropdownMenuItem(
                    value: "General",
                    child: Text("General"),
                  ),
                  DropdownMenuItem(
                    value: "Travail",
                    child: Text("Travail"),
                  ),
                  DropdownMenuItem(
                    value: "Personnel",
                    child: Text("Personnel"),
                  ),
                  DropdownMenuItem(
                    value: "Courses",
                    child: Text("Courses"),
                  ),
                  DropdownMenuItem(
                    value: "Santé",
                    child: Text("Santé"),
                  ),
                ],
                onChanged: (v) => setState(() => category = v!),
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: priority,
                decoration: const InputDecoration(
                  labelText: "Priorité",
                ),
                items: const [
                  DropdownMenuItem(
                    value: "high",
                    child: Text("Haute"),
                  ),
                  DropdownMenuItem(
                    value: "medium",
                    child: Text("Moyenne"),
                  ),
                  DropdownMenuItem(
                    value: "low",
                    child: Text("Faible"),
                  ),
                ],
                onChanged: (v) => setState(() => priority = v!),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: saveTask,
                child: const Text("Ajouter"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}