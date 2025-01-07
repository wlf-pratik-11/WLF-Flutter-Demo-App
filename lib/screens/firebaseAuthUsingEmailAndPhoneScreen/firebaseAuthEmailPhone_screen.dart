import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';

class FirebaseauthemailphoneScreen extends StatefulWidget {
  const FirebaseauthemailphoneScreen({super.key});

  @override
  State<FirebaseauthemailphoneScreen> createState() => _FirebaseauthemailphoneScreenState();
}

class _FirebaseauthemailphoneScreenState extends State<FirebaseauthemailphoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Firebase Auth using Email and Phone"),
      body: _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [commonButton("Login using Email"), commonButton("Login using Phone")],
    );
  }
}
