import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RemoteTasksScreen extends StatefulWidget {
  @override
  _RemoteTasksScreenState createState() => _RemoteTasksScreenState();
}

class _RemoteTasksScreenState extends State<RemoteTasksScreen> {
  List<dynamic> tasks = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/todos');

    try {
      final response = await http.get(
        url,
        headers: {
          'x-api-key': 'reqres-free-v1', // 👈 Optional, depending on API used
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          tasks = data;
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load tasks");
      }
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return Center(child: CircularProgressIndicator());
    if (error != null) return Center(child: Text("Error: $error"));

    return Scaffold(
      appBar: AppBar(title: Text("Remote Tasks")),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return ListTile(
            title: Text(task['title']),
            trailing: Icon(
              task['completed']
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: task['completed'] ? Colors.green : Colors.grey,
            ),
          );
        },
      ),
    );
  }
}
