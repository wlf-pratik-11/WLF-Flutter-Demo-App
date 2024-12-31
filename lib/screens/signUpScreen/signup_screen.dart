
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:main_app_demo/screens/signUpScreen/signup_screen_block.dart';

import '../../commons/common_functions.dart';
import '../loginScreen/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignupScreenBloc _bloc = SignupScreenBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            "Sign Up",
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox.fromSize(size: Size.fromHeight(60)),
              //Name
              inputField(
                "Name",
                _bloc.name,
                validator: (value) {
                  return _bloc.nameValidator(value);
                },
              ),
              //Email
              inputField("Email", _bloc.email, validator: (value) {
                return _bloc.emailValidator(value);
              }),
              //PassWord
              StreamBuilder<bool>(
                  stream: _bloc.isPasswordVisible,
                  builder: (context, snapshot) {
                    return inputField("Password", _bloc.password,
                        validator: (value) {
                          return _bloc.passwordValidator(value);
                        },
                        showEyeIcon: true,
                        isPassword: snapshot.data ?? true,
                        onPressed: () {
                          _bloc.isPasswordVisibleFun();
                        });
                  }),

              Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 15, top: 10, bottom: 10),
                child: Row(
                  children: [
                    StreamBuilder<bool>(
                      stream: _bloc.myController,
                      builder: (context, cheack) {
                        return Checkbox(
                          value: cheack.data ?? false,
                          onChanged: (value) {
                            _bloc.tncCheackBox(value ?? false);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          activeColor: Colors.deepPurpleAccent,
                          side: MaterialStateBorderSide.resolveWith(
                            (states) => BorderSide(
                                width: 2.0,
                                color: Colors.deepPurpleAccent,
                                style: BorderStyle.solid),
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: Text.rich(
                        maxLines: 2,
                        TextSpan(
                            text: 'By signing up, you agree to the',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: descriptionFontsize,
                                fontWeight: FontWeight.bold),
                            children: <InlineSpan>[
                              TextSpan(
                                text: ' Terms of  Service and Privacy Policy',
                                style: TextStyle(
                                    color: Colors.deepPurpleAccent,
                                    fontSize: descriptionFontsize,
                                    fontWeight: FontWeight.bold),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
              ),

              StreamBuilder<bool>(
                  stream: _bloc.myController,
                  builder: (context, buttonStatus) {
                    return commonButton(
                      "Sign Up",
                      buttonStatusFun: (buttonStatus.data ?? false)
                          ? () {
                              if (_bloc.validateForm()) {
                                final snakBar = SnackBar(
                                  content: Text(
                                    "Sign Up successfully..!!",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  backgroundColor: Colors.deepPurpleAccent,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snakBar);
                                _bloc.name.clear();
                                _bloc.email.clear();
                                _bloc.password.clear();
                                _bloc.tncCheackBox(false);
                              }
                            }
                          : null,
                    );
                  }),

              Text.rich(
                maxLines: 2,
                TextSpan(
                    text: 'Already have an account ?',
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: descriptionFontsize,
                        fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: ' Login',
                          style: TextStyle(
                              color: Colors.deepPurpleAccent,
                              fontSize: descriptionFontsize,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ));
                            })
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
