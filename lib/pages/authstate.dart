import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartinventory/pages/Dashboard.dart';
import 'package:smartinventory/pages/Login.dart';

class Authstate extends StatelessWidget {
  const Authstate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
           builder: (context, User){
            if (User.hasData) {
              return Dashboard();
            }else{
              return Login();
            }
           }),
    );
  }
}
