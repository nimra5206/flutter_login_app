import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskProvider() {
    loadTasks(); // Load from local storage on init
  }

  void addTask(String title) async {
    final task = Task(id: DateTime.now().toString(), title: title);
    _tasks.add(task);
    notifyListeners();
    _saveToLocal(); // Save after changes
  }

  void toggleTask(String id) {
    final task = _tasks.firstWhere((task) => task.id == id);
    task.isCompleted = !task.isCompleted;
    notifyListeners();
    _saveToLocal();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
    _saveToLocal();
  }

  Future<void> _saveToLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final taskStrings =
        _tasks
            .map((task) => '${task.id}|${task.title}|${task.isCompleted}')
            .toList();
    prefs.setStringList('tasks', taskStrings);
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskStrings = prefs.getStringList('tasks') ?? [];

    _tasks.clear();
    _tasks.addAll(
      taskStrings.map((str) {
        final parts = str.split('|');
        return Task(
          id: parts[0],
          title: parts[1],
          isCompleted: parts[2] == 'true',
        );
      }),
    );
    notifyListeners();
  }
}
