import 'package:chat_app/screens/login_page.dart';
import 'package:chat_app/screens/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Login.id: (context) => const Login(),
        SignUpPage.id: (context) => const SignUpPage(),
        // ChatPage.id: (context) => const ChatPage(email),
      },
      debugShowCheckedModeBanner: false,
      home: const Login(),
    );
  }
}
