import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/commons/my_colors.dart';
import 'package:main_app_demo/screens/firebaseSocialLoginWithGoogle/signin_with_google_screen_bloc.dart';

class SigninWithGoogleScreen extends StatefulWidget {
  const SigninWithGoogleScreen({super.key});

  @override
  State<SigninWithGoogleScreen> createState() => _SigninWithGoogleScreenState();
}

class _SigninWithGoogleScreenState extends State<SigninWithGoogleScreen> {
  SigninWithGoogleScreenBloc _bloc = SigninWithGoogleScreenBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: screenSizeRatio * 0.15,
              ),
              Text(
                "Welcome to our",
                style: TextStyle(
                    fontSize: screenSizeRatio * 0.03, color: MyColors.darkBlue.withOpacity(0.7), fontWeight: FontWeight.bold),
              ),
              Text(
                "WLF Demo Flutter App",
                style: TextStyle(fontSize: screenSizeRatio * 0.05, color: MyColors.darkBlue, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: screenSizeRatio * 0.06,
              ),
              Image(
                image: AssetImage("assets/images/wlfLogo.png"),
                height: screenSizeRatio * 0.15,
              ),
              SizedBox(
                height: screenSizeRatio * 0.01,
              ),
              Image(image: AssetImage("assets/images/loginWithGoogleScreenVector.jpg")),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.05, vertical: screenSizeRatio * 0.03),
                child: Container(
                  height: screenSizeRatio * 0.1,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _bloc.signinWithGoogle(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: MyColors.darkBlue, width: 3.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10)),
                      elevation: 5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Sign in with  ",
                          style: TextStyle(color: MyColors.darkBlue, fontWeight: FontWeight.bold, fontSize: buttonFontsize),
                        ),
                        Image(
                          image: AssetImage("assets/images/googleLogo.png"),
                          height: screenSizeRatio * 0.033,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}
