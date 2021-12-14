import 'package:daryadili/homepage.dart';
import 'package:daryadili/login_page.dart';
import 'package:daryadili/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DaryaDili',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: checkUser() ? const HomePage() : const LoginPage(),
    );
  }
}

bool checkUser() {
  final _auth = FirebaseAuth.instance;
  if (_auth.currentUser != null) {
    return true;
  } else {
    return false;
  }
}
