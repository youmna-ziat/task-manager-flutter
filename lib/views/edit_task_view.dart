import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';

class EditTaskView extends StatefulWidget {
  final Task task;
  final TaskController controller;

  const EditTaskView({
    super.key,
    required this.task,
    required this.controller,
  });

  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController descriptionController;

  late String category;
  late String priority;

  @override
  void initState() {
    super.initState();

    titleController =
        TextEditingController(text: widget.task.title);

    descriptionController =
        TextEditingController(text: widget.task.description);

    category = widget.task.category;
    priority = widget.task.priority;
  }

  Future<void> updateTask() async {
    if (!_formKey.currentState!.validate()) return;

    final error = await widget.controller.updateTask(
      widget.task,
      titleController.text,
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
      appBar: AppBar(title: const Text("Modifier la tâche")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                validator: (v) =>
                    v == null || v.isEmpty ? "Titre obligatoire" : null,
                decoration: const InputDecoration(
                  labelText: "Titre",
                ),
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

              DropdownButtonFormField<String>(
                initialValue: category,
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
                initialValue: priority,
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
                onPressed: updateTask,
                child: const Text("Modifier"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}