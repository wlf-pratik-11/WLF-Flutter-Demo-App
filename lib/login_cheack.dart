import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_app_demo/screens/firebaseSocialLoginWithGoogle/signin_with_google_screen.dart';
import 'package:main_app_demo/screens/main_page.dart';

class LoginCheack extends StatefulWidget {
  const LoginCheack({super.key});

  @override
  State<LoginCheack> createState() => _LoginCheackState();
}

class _LoginCheackState extends State<LoginCheack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MainPage();
          } else {
            return SigninWithGoogleScreen();
          }
        },
      ),
    );
  }
}
