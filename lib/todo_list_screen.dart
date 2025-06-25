import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
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
      _tasks = prefs.getStringList('todo_tasks') ?? [];
    });
  }

  _addTask(String task) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks.add(task);
    });
    prefs.setStringList('todo_tasks', _tasks);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To-Do List")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter Task'),
              onSubmitted: _addTask,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (_, i) => ListTile(title: Text(_tasks[i])),
            ),
          ),
        ],
      ),
    );
  }
}
