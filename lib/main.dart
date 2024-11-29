import 'package:auth_app/firebase_options.dart';
import 'package:auth_app/views/login_view.dart';
import 'package:auth_app/views/notes_view.dart';
import 'package:auth_app/views/register_view.dart';
import 'package:auth_app/views/verify_email_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase before running the app
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 97, 111, 194),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        '/login/': (context) => LoginView(),
        '/register/': (context) => RegisterView(),
        '/notes/': (context) => NotesView(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Since Firebase is initialized in main(), no need to use FutureBuilder here
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        return const NotesView();
      } else {
        user.sendEmailVerification();
        return const EmailVerificationView();
      }
    } else {
      return const LoginView();
    }
  }
}
