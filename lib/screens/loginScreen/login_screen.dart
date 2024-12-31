
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../commons/common_functions.dart';
import '../resetPasswordScreen/reset_password_screen.dart';
import 'login_screen_block.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginScreenBlock _bloc = LoginScreenBlock();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(
            top: 15,
          ),
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: tabbarFontsize
            ),
          ),
        ),
      ),
      body: Form(
          key: _bloc.formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox.fromSize(size: Size.fromHeight(60)),

                inputField("Email", _bloc.email, validator: (value) {
                  return _bloc.emailValidator(value);
                }),

                StreamBuilder<bool>(
                  stream: _bloc.isPasswordVisible,
                  builder: (context, snapshot) {
                    return inputField("Password", _bloc.password, validator: (value) {
                      return _bloc.passwordValidator(value);
                    }, showEyeIcon: true, isPassword: snapshot.data ?? false,onPressed: () {
                      _bloc.isPasswordVisibleFun();
                    });
                  }
                ),
                StreamBuilder(
                    stream: _bloc.myController,
                    builder: (context, buttonStatus) {
                      return commonButton(
                        "Login",
                        buttonStatusFun: () {
                          if(_bloc.validateForm()){
                            final snakBar = SnackBar(
                              content:Text("Login successfully..!!",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              backgroundColor: Colors.deepPurpleAccent,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snakBar);
                            _bloc.email.clear();
                            _bloc.password.clear();
                          }
                        },
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: InkWell(
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: descriptionFontsize),
                    ),
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => const ResetPasswordScreen(),) );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: RichText(
                    text: TextSpan(
                        text: "Don't have an account yet?",
                        style: TextStyle(
                          fontFamily: GoogleFonts.nunito().fontFamily,
                            color: Colors.black38,
                            fontSize: descriptionFontsize,
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: " Sign Up",
                              style: TextStyle(
                                  color: Colors.deepPurpleAccent,
                                  fontSize: descriptionFontsize,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                })
                        ]),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
