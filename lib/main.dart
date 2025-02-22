import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smartinventory/pages/Login.dart';
import 'package:smartinventory/pages/SignUp.dart';
import 'package:smartinventory/pages/category.dart';
import 'package:smartinventory/pages/product.dart';
import 'firebase_options.dart'; // Ensure this path is correct

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Login(), // Set Signup as the home screen
    );
  }
}