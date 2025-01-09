import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/commons/my_colors.dart';
import 'package:main_app_demo/screens/firebaseAuthUsingEmailAndPhoneScreen/authUsingPhone/enterOtpScreen/enter_otp_screen_bloc.dart';

class EnterOtpScreen extends StatefulWidget {
  const EnterOtpScreen({super.key});

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  EnterOtpScreenBloc _bloc = EnterOtpScreenBloc();

  Color accentPurpleColor = Color(0xFF6A53A1);
  Color primaryColor = Color(0xFF121212);
  Color accentPinkColor = Color(0xFFF99BBD);
  Color accentDarkGreenColor = Color(0xFF115C49);
  Color accentYellowColor = Color(0xFFFFB612);
  Color accentOrangeColor = Color(0xFFEA7A3B);

  @override
  Widget build(BuildContext context) {
    TextStyle? createStyle(Color color) {
      ThemeData theme = Theme.of(context);
      return theme.textTheme.displaySmall?.copyWith(color: color, fontSize: screenSizeRatio * 0.04, fontWeight: FontWeight.bold);
    }

    var otpTextStyles = [
      createStyle(accentPurpleColor),
      createStyle(accentYellowColor),
      createStyle(accentDarkGreenColor),
      createStyle(accentOrangeColor),
      createStyle(accentPinkColor),
      createStyle(accentPurpleColor),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBar("Enter OTP"),
      body: _buildScreen(otpTextStyles),
    );
  }

  Widget _buildScreen(var otpTextStyles) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Form(
          key: _bloc.formKey,
          child: OtpTextField(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            numberOfFields: 6,
            styles: otpTextStyles,
            focusedBorderColor: accentPurpleColor,
            showFieldAsBox: true,
            fieldWidth: 50,
            borderRadius: BorderRadius.circular(10),
            fillColor: Colors.white,
            borderColor: MyColors.darkBlue,
            borderWidth: 4.0,
            onCodeChanged: (value) {
              _bloc.OTP.text += value;
              print("OTP tesxts ==========>${_bloc.OTP.text}");
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.02, vertical: screenSizeRatio * 0.1),
          child: darkBlueCommonButton(
            "Login",
            onPressed: () {
              if (_bloc.validateForm()) {
                final snakBar = SnackBar(
                  content: Text(
                    "Login via OTP Succesfull..!!",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: snakbarFontsize),
                  ),
                  backgroundColor: MyColors.darkBlue,
                );
                ScaffoldMessenger.of(context).showSnackBar(snakBar);
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
          ),
        ),
      ],
    );
  }
}
