import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/screens/firebaseAuthUsingEmailAndPhoneScreen/authUsingEmail/loginScreen/login_using_email_screen.dart';

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
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.02, vertical: screenSizeRatio * 0.02),
          child: darkBlueCommonButton(
            icons: Icon(
              Icons.email_outlined,
              color: Colors.white,
              size: screenSizeRatio * 0.05,
            ),
            "Login using Email",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginUsingEmailScreen(),
                  ));
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.02, vertical: screenSizeRatio * 0.02),
          child: darkBlueCommonButton(
            icons: Icon(
              Icons.phone_android,
              color: Colors.white,
              size: screenSizeRatio * 0.05,
            ),
            "Login using Phone",
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
