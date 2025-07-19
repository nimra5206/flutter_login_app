import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
// ignore: unused_import
import '../models/task.dart';

class TaskManagerScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text("New Task"),
            content: TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: "Enter task"),
              onSubmitted: (_) {
                _addTask(context);
                Navigator.pop(context);
              },
            ),
            actions: [
              TextButton(
                child: Text("Add"),
                onPressed: () {
                  _addTask(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
    );
  }

  void _addTask(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context, listen: false);
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      provider.addTask(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Manager (Provider)"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddTaskDialog(context),
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, _) {
          final tasks = taskProvider.tasks;

          if (tasks.isEmpty) {
            return Center(child: Text("No tasks yet."));
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (_, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(
                  task.title,
                  style: TextStyle(
                    decoration:
                        task.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                  ),
                ),
                leading: IconButton(
                  icon: Icon(
                    task.isCompleted
                        ? Icons.check_box
                        : Icons.check_box_outline_blank,
                    color: task.isCompleted ? Colors.green : null,
                  ),
                  onPressed: () => taskProvider.toggleTask(task.id),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => taskProvider.deleteTask(task.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
