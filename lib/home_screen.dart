import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
            tooltip: "Logout",
          ),
        ],
      ),
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
            SizedBox(height: 30),
            Divider(),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text("View User Profile (API)"),
              onPressed: () => Navigator.pushNamed(context, '/userProfile'),
            ),
            ElevatedButton(
              child: Text("View Remote Tasks (API)"),
              onPressed: () => Navigator.pushNamed(context, '/remoteTasks'),
            ),
            SizedBox(height: 30),
            Divider(),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/myAccount');
              },
              child: Text("My Account"),
            ),
          ],
        ),
      ),
    );
  }
}
