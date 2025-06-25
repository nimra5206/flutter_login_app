import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskManagerScreen extends StatefulWidget {
  @override
  _TaskManagerScreenState createState() => _TaskManagerScreenState();
}

class _TaskManagerScreenState extends State<TaskManagerScreen> {
  final _controller = TextEditingController();
  List<String> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks = prefs.getStringList('tasks') ?? [];
    });
  }

  _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('tasks', _tasks);
  }

  _addTask(String task) {
    setState(() {
      _tasks.add(task);
    });
    _saveTasks();
    _controller.clear();
  }

  _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
    _saveTasks();
  }

  _toggleComplete(int index) {
    setState(() {
      _tasks[index] =
          _tasks[index].startsWith("[x] ")
              ? _tasks[index].replaceFirst("[x] ", "")
              : "[x] ${_tasks[index]}";
    });
    _saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Manager"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (_) => AlertDialog(
                      title: Text("New Task"),
                      content: TextField(
                        controller: _controller,
                        decoration: InputDecoration(hintText: "Enter task"),
                        onSubmitted: _addTask,
                      ),
                      actions: [
                        TextButton(
                          child: Text("Add"),
                          onPressed: () {
                            _addTask(_controller.text);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder:
            (_, i) => ListTile(
              title: Text(_tasks[i]),
              leading: IconButton(
                icon: Icon(Icons.check),
                onPressed: () => _toggleComplete(i),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => _deleteTask(i),
              ),
            ),
      ),
    );
  }
}
