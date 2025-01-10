import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/commons/my_colors.dart';

import 'login_using_phone_screen_bloc.dart';

class LoginUsingPhoneScreen extends StatefulWidget {
  const LoginUsingPhoneScreen({super.key});

  @override
  State<LoginUsingPhoneScreen> createState() => _LoginUsingPhoneScreenState();
}

class _LoginUsingPhoneScreenState extends State<LoginUsingPhoneScreen> {
  LoginUsingPhoneScreenBloc _bloc = LoginUsingPhoneScreenBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBar("Login with phone"),
      body: StreamBuilder<bool>(
          stream: _bloc.isLoading,
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/loginWithPhone.png",
                            height: screenSizeRatio * 0.9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.06),
                  child: Text(
                    "We will send you an OTP on this \nmobile Number",
                    style: TextStyle(
                      fontSize: screenSizeRatio * 0.03,
                      fontWeight: FontWeight.bold,
                      color: MyColors.darkBlue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Form(
                  key: _bloc.formKey,
                  child: inputField("Mobile Number", _bloc.phoneNumber, validator: (value) {
                    return _bloc.phoneNumberValidate(value);
                  }, isNumber: true),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: screenSizeRatio * 0.03,
                        right: screenSizeRatio * 0.03,
                        top: screenSizeRatio * 0.02,
                        bottom: screenSizeRatio * 0.1),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_bloc.validateForm()) {
                          _bloc.isLoading.add(true);
                          await _bloc.getOTp(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsetsDirectional.symmetric(horizontal: 0, vertical: 10),
                        minimumSize: Size(double.maxFinite, screenSizeRatio * 0.08),
                        backgroundColor: MyColors.darkBlue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenSizeRatio * 0.01)),
                        elevation: 3,
                      ),
                      child: snapshot.data ?? false
                          ? LoadingAnimationWidget.discreteCircle(color: Colors.white, size: buttonFontsize)
                          : Text(
                              "Get OTP",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: buttonFontsize,
                              ),
                            ),
                    ))
              ],
            );
          }),
    );
  }
}
