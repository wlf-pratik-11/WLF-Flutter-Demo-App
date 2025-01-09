import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/commons/my_colors.dart';
import 'package:main_app_demo/screens/firebaseAuthUsingEmailAndPhoneScreen/authUsingEmail/signUpScreen/signup_using_email_screen_bloc.dart';

class SignupUsingEmailScreen extends StatefulWidget {
  const SignupUsingEmailScreen({super.key});

  @override
  State<SignupUsingEmailScreen> createState() => _SignupUsingEmailScreenState();
}

class _SignupUsingEmailScreenState extends State<SignupUsingEmailScreen> {
  final SignupUsingEmailScreenBloc _bloc = SignupUsingEmailScreenBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Sign Up"),
      body: _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return Form(
      key: _bloc.formKey,
      child: Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: screenSizeRatio * 0.1,
              ),
              inputField(
                "Name :",
                _bloc.name,
                validator: (value) {
                  return _bloc.nameValidate(value);
                },
              ),
              inputField(
                "E-mail :",
                _bloc.email,
                validator: (value) {
                  return _bloc.emailValidate(value);
                },
              ),
              inputField(
                "Password :",
                _bloc.password,
                validator: (value) {
                  return _bloc.passwordValidate(value);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.02, vertical: screenSizeRatio * 0.06),
                child: darkBlueCommonButton(
                  "Sign Up",
                  onPressed: () async {
                    if (_bloc.validateForm()) {
                      if (await _bloc.signUp()) {
                        final snakBar = SnackBar(
                          content: Text(
                            "Sign Up Succesfully..!!",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: snakbarFontsize),
                          ),
                          backgroundColor: MyColors.darkBlue,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snakBar);
                        Navigator.pop(context);
                      } else if (!await _bloc.signUp()) {
                        final snakBar = SnackBar(
                          content: Text(
                            "Invalid Email or Password",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: snakbarFontsize),
                          ),
                          backgroundColor: MyColors.darkBlue,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snakBar);
                      }
                    }
                  },
                ),
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Already have an account ? ",
                      style: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.nunito().fontFamily,
                      )),
                  TextSpan(
                      text: " Login",
                      style: TextStyle(
                          color: MyColors.darkBlue, fontWeight: FontWeight.bold, fontFamily: GoogleFonts.nunito().fontFamily),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                        }),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
