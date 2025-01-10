import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/commons/my_colors.dart';
import 'package:main_app_demo/screens/firebaseAuthUsingEmailAndPhoneScreen/authUsingPhone/enterOtpScreen/enter_otp_screen_bloc.dart';

class EnterOtpScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  const EnterOtpScreen(this.verificationId, this.phoneNumber, {super.key});

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
      body: StreamBuilder<bool>(
          stream: _bloc.isLoading,
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.06),
                  child: Text(
                    "We will send you an OTP on +91 ${widget.phoneNumber} \nmobile Number",
                    style: TextStyle(
                      fontSize: screenSizeRatio * 0.03,
                      fontWeight: FontWeight.bold,
                      color: MyColors.darkBlue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                OtpTextField(
                  onSubmit: (value) => _bloc.OTP.text = value,
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
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.02, vertical: screenSizeRatio * 0.1),
                    child: ElevatedButton(
                      onPressed: () async {
                        _bloc.isLoading.add(true);
                        if (!await _bloc.otpVeryfy(widget.verificationId, context)) {
                          _bloc.isLoading.add(false);
                          final snakBar = SnackBar(
                            content: Text(
                              "Enter valid OTP !!",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: snakbarFontsize),
                            ),
                            backgroundColor: MyColors.darkBlue,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snakBar);
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
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: buttonFontsize,
                              ),
                            ),
                    )),
              ],
            );
          }),
    );
  }
}
