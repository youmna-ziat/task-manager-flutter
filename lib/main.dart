import 'package:flutter/material.dart';

import 'models/task.dart';
import 'controllers/task_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskPage(),
    );

  }
}

class TaskPage extends StatefulWidget {

  @override
  State<TaskPage> createState() => _TaskPageState();

}

class _TaskPageState extends State<TaskPage> {

  TextEditingController taskController = TextEditingController();

  TaskController controller = TaskController();

  @override
  void initState() {

    super.initState();

    loadTasks();

  }

  Future<void> loadTasks() async {

    await controller.loadTasks();

    setState(() {});

  }

  Future<void> addTask() async {

    if(taskController.text.isNotEmpty){

      await controller.addTask(taskController.text);

      taskController.clear();

      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(

  SnackBar(
    content: Text("Task added successfully"),
  ),

);
    }

  }

  Future<void> deleteTask(int id) async {

    await controller.deleteTask(id);

    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(

  SnackBar(
    content: Text("Task deleted"),
  ),

);
  }
  
  Future<void> confirmDelete(int id) async {

  showDialog(

    context: context,

    builder: (context) {

      return AlertDialog(

        title: Text("Delete Task"),

        content: Text(
          "Are you sure you want to delete this task ?",
        ),

        actions: [

          TextButton(

            onPressed: () {

              Navigator.pop(context);

            },

            child: Text("Cancel"),

          ),

          TextButton(

            onPressed: () async {

              await deleteTask(id);

              Navigator.pop(context);

            },

            child: Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),

          ),

        ],

      );

    },

  );

}


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Task Manager MVC"),
      ),

      body: Padding(

        padding: EdgeInsets.all(16),

        child: Column(

          children: [

            TextField(

              controller: taskController,

              decoration: InputDecoration(
                labelText: "Enter a task",
                border: OutlineInputBorder(),
              ),

            ),

            SizedBox(height: 15),

            ElevatedButton(

              onPressed: addTask,

              child: Text("Add Task"),

            ),

            SizedBox(height: 20),

            Expanded(

              child: ListView.builder(

                itemCount: controller.tasks.length,

                itemBuilder: (context, index) {

                  return Container(

                    margin: EdgeInsets.only(bottom: 15),

                    decoration: BoxDecoration(

                      color: Colors.deepPurple.shade50,

                      borderRadius: BorderRadius.circular(20),

                    ),

                    child: ListTile(

                      contentPadding: EdgeInsets.all(15),

                      onTap: () async {

                        final result = await Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (context) => DetailsPage(
                              task: controller.tasks[index],
                            ),

                          ),

                        );

                        if(result == true){

                          await loadTasks();

                        }

                      },

                      leading: Checkbox(

  value: controller.tasks[index].isCompleted,

  onChanged: (value) async {

    await controller.toggleTask(
      controller.tasks[index],
    );

    setState(() {});

  },

),

                      title: Text(

                        controller.tasks[index].title,

                        style: TextStyle(

  fontSize: 18,
  fontWeight: FontWeight.bold,

  decoration:

      controller.tasks[index].isCompleted

      ? TextDecoration.lineThrough

      : TextDecoration.none,

),
                      ),

                      trailing: IconButton(

  icon: Icon(
    Icons.delete,
    color: Colors.red,
  ),

  onPressed: () async {

    await confirmDelete(
      controller.tasks[index].id!,
    );

  },

),

                    ),

                  );

                },

              ),

            ),

          ],

        ),

      ),

    );

  }
}

class DetailsPage extends StatefulWidget {

  final Task task;

  DetailsPage({required this.task});

  @override
  State<DetailsPage> createState() => _DetailsPageState();

}

class _DetailsPageState extends State<DetailsPage> {

  TextEditingController editController = TextEditingController();

  TaskController controller = TaskController();

  @override
  void initState() {

    super.initState();

    editController.text = widget.task.title;

  }

  Future<void> updateTask() async {

  if(editController.text.isNotEmpty){

    widget.task.title = editController.text;

    await controller.updateTask(widget.task);

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(
        content: Text("Task updated"),
      ),

    );

    Navigator.pop(context, true);

  }

}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Edit Task"),
      ),

      body: Padding(

        padding: EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(

              controller: editController,

              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Edit task",
              ),

            ),

            SizedBox(height: 20),

            Container(

              width: double.infinity,

              height: 55,

              child: ElevatedButton(

                onPressed: updateTask,

                style: ElevatedButton.styleFrom(

                  backgroundColor: Colors.deepPurple,

                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(15),

                  ),

                ),

                child: Text(

                  "Update Task",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),

                ),

              ),

            ),

          ],

        ),

      ),

    );

  }
}