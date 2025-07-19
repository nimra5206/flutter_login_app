import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart'; // ✅ Provider import

// Firebase options
import 'firebase_options.dart';

// Providers
import 'providers/task_provider.dart'; // ✅ Your TaskProvider

// Screens
import 'login_screen.dart';
import 'signup_screen.dart';
import 'home_screen.dart';
import 'counter_screen.dart';
import 'todo_list_screen.dart';
import 'task_manager_screen.dart';
import 'user_profile_screen.dart';
import 'remote_tasks_screen.dart';
import 'my_account_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()), // ✅ TaskProvider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Internship Project',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AuthWrapper(), // ✅ Auth routing logic
      routes: {
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/counter': (context) => CounterScreen(),
        '/todo': (context) => TodoListScreen(),
        '/taskManager': (context) => TaskManagerScreen(),
        '/userProfile': (context) => UserProfileScreen(),
        '/remoteTasks': (context) => RemoteTasksScreen(),
        '/myAccount': (context) => MyAccountScreen(),
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        print("Auth State Changed: ${snapshot.data}");

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasData) {
          print("✅ User is logged in: ${snapshot.data!.email}");
          return HomeScreen();
        } else {
          print("❌ User is not logged in");
          return LoginScreen();
        }
      },
    );
  }
}
