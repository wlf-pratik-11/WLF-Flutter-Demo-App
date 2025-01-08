import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/screens/firebaseAuthUsingEmailAndPhoneScreen/authUsingEmail/loginScreen/login_using_email_screen_bloc.dart';
import 'package:main_app_demo/screens/firebaseAuthUsingEmailAndPhoneScreen/authUsingEmail/signUpScreen/signup_using_email_screen.dart';

import '../../../../commons/my_colors.dart';

class LoginUsingEmailScreen extends StatefulWidget {
  const LoginUsingEmailScreen({super.key});

  @override
  State<LoginUsingEmailScreen> createState() => _LoginUsingEmailScreenState();
}

class _LoginUsingEmailScreenState extends State<LoginUsingEmailScreen> {
  LoginUsingEmailScreenBloc _bloc = LoginUsingEmailScreenBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Login"),
      body: _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return Form(
      key: _bloc.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: screenSizeRatio * 0.1,
          ),
          inputField(
            "Email ",
            _bloc.email,
            validator: (value) {
              return _bloc.emailValidate(value);
            },
          ),
          StreamBuilder<bool>(
              stream: _bloc.isPasswordVisible,
              builder: (context, isPasswordVisibleCheack) {
                return inputField(
                  "Password",
                  _bloc.password,
                  validator: (value) {
                    return _bloc.passwordValidate(value);
                  },
                  showEyeIcon: true,
                  isPassword: isPasswordVisibleCheack.data,
                  onPressed: () {
                    _bloc.isPAsswordVisibleFun();
                  },
                );
              }),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.02, vertical: screenSizeRatio * 0.06),
            child: darkBlueCommonButton(
              "Login",
              onPressed: () {
                if (_bloc.validateForm()) {
                  final snakBar = SnackBar(
                    content: Text(
                      "Login Succesfully..!!",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: snakbarFontsize),
                    ),
                    backgroundColor: MyColors.darkBlue,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snakBar);
                  _bloc.dispose();
                  Navigator.pop(context);
                }
                return print("Form State =======>>>>>>>>${_bloc.validateForm()}");
              },
            ),
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "Don't have an account yet ? ",
                style:
                    TextStyle(color: Colors.black38, fontWeight: FontWeight.bold, fontFamily: GoogleFonts.nunito().fontFamily)),
            TextSpan(
                text: "Sign Up",
                style:
                    TextStyle(color: MyColors.darkBlue, fontWeight: FontWeight.bold, fontFamily: GoogleFonts.nunito().fontFamily),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SignupUsingEmailScreen(),
                    ));
                  }),
          ]))
        ],
      ),
    );
  }
}
