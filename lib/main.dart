import 'package:flutter/material.dart';
import 'views/login_view.dart';

void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      themeMode: ThemeMode.system,
theme: ThemeData(
  colorSchemeSeed: Colors.deepPurple,
  useMaterial3: true,
),
darkTheme: ThemeData.dark(useMaterial3: true),
      home: const LoginView(),
    );
  }
}