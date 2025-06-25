import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to the Home Screen!"),
            ElevatedButton(
              child: Text("Go to Counter"),
              onPressed: () => Navigator.pushNamed(context, '/counter'),
            ),
            ElevatedButton(
              child: Text("Go to To-Do List"),
              onPressed: () => Navigator.pushNamed(context, '/todo'),
            ),
            ElevatedButton(
              child: Text("Go to Task Manager"),
              onPressed: () => Navigator.pushNamed(context, '/taskManager'),
            ),
          ],
        ),
      ),
    );
  }
}
