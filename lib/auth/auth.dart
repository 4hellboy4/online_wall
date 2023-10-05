import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wall_online/auth/login_or_auth.dart';
import 'package:wall_online/pages/home_page.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snap) {
          if (snap.hasData) {
            return const HomePage();
          } else {
            return const LoginOrAuth();
          }
        },
      ),
    );
  }
}
