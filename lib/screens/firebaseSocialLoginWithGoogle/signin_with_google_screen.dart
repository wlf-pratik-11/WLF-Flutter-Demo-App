import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/commons/my_colors.dart';

class SigninWithGoogleScreen extends StatefulWidget {
  const SigninWithGoogleScreen({super.key});

  @override
  State<SigninWithGoogleScreen> createState() => _SigninWithGoogleScreenState();
}

class _SigninWithGoogleScreenState extends State<SigninWithGoogleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Sign in With Google"),
      body: _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: AssetImage("assets/images/loginWithGoogleScreenVector.jpg")),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.05),
          child: ElevatedButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sign in with  ",
                  style: TextStyle(color: MyColors.darkBlue, fontWeight: FontWeight.bold, fontSize: buttonFontsize),
                ),
                Image(
                  image: AssetImage("assets/images/google.png"),
                  height: screenSizeRatio * 0.033,
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              side: BorderSide(color: MyColors.darkBlue),
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10)),
              elevation: 5,
            ),
          ),
        )
      ],
    );
  }
}
