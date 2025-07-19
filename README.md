# 📱 Flutter Task Management App

This is a multi-screen Flutter application developed over **six weeks**, covering essential Flutter concepts such as UI design, navigation, state management, persistent storage, API integration, and Firebase services.

---

## 📅 Project Timeline

| Week | Focus Area                      | Deliverables                                      |
|------|----------------------------------|---------------------------------------------------|
| 1    | Basic UI & Navigation           | Login and Home Screens                            |
| 2    | State Management & Persistence  | Counter App and To-Do List                        |
| 3    | CRUD & Task Manager App         | Full-featured Task Manager                        |
| 4    | API Integration                 | User list & remote data screen                    |
| 5    | Firebase Auth + Firestore       | Login, Signup, and My Account Info                |
| 6    | ✅ Provider State Management     | TaskProvider with app-wide task syncing           |

---

## ✅ Features by Week

### 📍 Week 1: Login and Navigation
- Email & password fields with validation
- Navigation to Home screen

### 🔁 Week 2: SharedPreferences & Counter/To-Do
- **Counter Screen**: persist count locally
- **To-Do List**: add tasks using SharedPreferences

### 🗃️ Week 3: Task Manager CRUD
- Add/delete tasks
- Mark tasks completed
- All saved in memory initially

### 🌐 Week 4: API Integration
- User profile and task data via REST API
- Error handling and async fetch

### 🔐 Week 5: Firebase Integration
- Firebase Auth: login/signup
- Firestore: save and retrieve user data
- My Account Screen

### 🧠 Week 6: Provider State Management
- Introduced `TaskProvider` using `ChangeNotifier`
- Converted:
  - ✅ `TaskManagerScreen` to use `Provider`
  - ✅ `TodoListScreen` to gradually move from `SharedPreferences` to `Provider`
- Provider is now responsible for:
  - Managing all task CRUD
  - Storing and retrieving from SharedPreferences
  - Notifying UI of task state changes

---

## 🔧 Firebase Setup

### ✅ Services Used
- Authentication (email/password)
- Cloud Firestore

### 🛠️ Firebase Initialization

1. Enable Auth & Firestore in Firebase Console
2. Install packages:

```bash
flutter pub add firebase_core firebase_auth cloud_firestore
dart run flutterfire_cli configure
```

3. Initialize in `main.dart`:

```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

4. Firestore Security Rules:

```js
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

---

## 📁 Project Structure

```bash
lib/
├── models/
│   └── task.dart                    # Task model
├── providers/
│   └── task_provider.dart           # App-wide state management
├── screens/
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   ├── home_screen.dart
│   ├── counter_screen.dart
│   ├── todo_list_screen.dart        # Now uses Provider gradually
│   ├── task_manager_screen.dart     # Fully powered by TaskProvider
│   ├── remote_tasks_screen.dart
│   ├── user_profile_screen.dart
│   └── logged_in_account_screen.dart
├── firebase_options.dart
└── main.dart
```

---

## 🧭 Navigation Routes

```dart
routes: {
  '/login': (context) => LoginScreen(),
  '/signup': (context) => SignUpScreen(),
  '/home': (context) => HomeScreen(),
  '/counter': (context) => CounterScreen(),
  '/todo': (context) => TodoListScreen(),
  '/taskManager': (context) => TaskManagerScreen(),
  '/remoteTasks': (context) => RemoteTasksScreen(),
  '/userProfile': (context) => UserProfileScreen(),
  '/loggedInAccount': (context) => LoggedInAccountScreen(),
}
```

---

## 📦 Dependencies

In `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2
  shared_preferences: ^2.2.2
  firebase_core: ^2.27.0
  firebase_auth: ^4.17.0
  cloud_firestore: ^4.17.0
  http: ^0.13.6
```

---

## ▶️ Getting Started

```bash
# 1. Clone the project
git clone https://github.com/your-username/flutter_task_manager.git
cd flutter_task_manager

# 2. Install dependencies
flutter pub get

# 3. Configure Firebase
dart run flutterfire_cli configure

# 4. Run the app
flutter run -d chrome        # for Web
flutter run -d android       # for Android
flutter run -d web-server    # for Web (manual browser)
flutter run -d ios           # for iOS (macOS only)
```

---

## 📌 Notes

- TaskProvider is a central source of truth for all task logic.
- To-Do and Task Manager screens both access it — logic stays unified.
- Easily extendable to save to Firestore instead of just SharedPreferences.

---

**Happy Coding! 🚀**
