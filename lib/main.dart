import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'counter_screen.dart';
import 'todo_list_screen.dart';
import 'task_manager_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Internship Project',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/counter': (context) => CounterScreen(),
        '/todo': (context) => TodoListScreen(),
        '/taskManager': (context) => TaskManagerScreen(),
      },
    );
  }
}
