import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/screens/apiCallScreen/api_call_screen.dart';
import 'package:main_app_demo/screens/firebaseSocialLoginWithGoogle/signin_with_google_screen.dart';
import 'package:main_app_demo/screens/paginationScreen/pagination_screen.dart';
import 'package:main_app_demo/screens/sharedPreferencesScreen/shared_preferences_screen.dart';
import 'package:main_app_demo/screens/showImageFromCamera/show_image_from_camera_and_gallery_screen.dart';
import 'package:main_app_demo/screens/signUpScreen/signup_screen.dart';
import 'package:main_app_demo/screens/sqfLiteDemo/sqflite_demo_screen.dart';
import 'package:main_app_demo/screens/tabbarDemo/tabbar_screen.dart';

import '../commons/my_colors.dart';
import 'changeScreensDemo/content_holder_screen.dart';
import 'dateTimeScreen/datetime_screen.dart';
import 'firebaseAuthUsingEmailAndPhoneScreen/firebaseAuthEmailPhone_screen.dart';
import 'responsiveScreen/responsive_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static const List menuItem = [
    {"name": "Tabbar and Dialog Demo", "route": TabbarDemoPage()},
    {"name": "Practice Screen", "route": ContentHolderScreen()},
    {"name": "Sign Up Screen", "route": SignupScreen()},
    {"name": "Date Time Screen", "route": DatetimeScreen()},
    {"name": "Show Image From Camera And Gallery Screen", "route": ShowImageFromCameraAndGalleryScreen()},
    {"name": "Sqf Lite Screen", "route": SqfliteDemoScreen()},
    {"name": "Shared Preferences Screen", "route": SharedPreferencesScreen()},
    {"name": "Responsive Screen", "route": ResponsiveScreen()},
    {"name": "API Call Screen", "route": ApiCallScreen()},
    {"name": "Pagination Screen", "route": PaginationScreen()},
    {"name": "Login using Email/Phone Screen", "route": FirebaseauthemailphoneScreen()},
    {"name": "Login using google Screen", "route": SigninWithGoogleScreen()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBar("Main Page"),
      drawer: Drawer(
        width: drawerWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/drawer_background/drawerbg.jpeg'),
                  fit: BoxFit.fill, // Ensures the image covers the header space
                ),
              ), // Adds padding around the text
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                // Centers text vertically
                children: [
                  Text(
                    "White Label Fox",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Ensures text is visible on top of the image
                    ),
                  ),
                  SizedBox(height: 8),
                  // Adds space between the two text elements
                  Text(
                    "wlfpratiktank@gmail.com",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Ensures the email text is visible
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: drawerItem(menuItem),
            )
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            "Welcome to Our Flutter App",
            style: TextStyle(color: MyColors.darkBlue, fontWeight: FontWeight.bold, fontSize: tabbarFontsize),
          )),
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: Text(":::: Font Sizes ::::"),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: Text("buttonFontsize",style: TextStyle(fontSize: buttonFontsize),),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: Text("descriptionFontsize",style: TextStyle(fontSize: descriptionFontsize),),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: Text("tabbarFontsize",style: TextStyle(fontSize: tabbarFontsize),),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: Text("textfieldTitleFontsize",style: TextStyle(fontSize: textfieldTitleFontsize),),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: Text("drawerTextFontsize",style: TextStyle(fontSize: drawerTextFontsize),),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: Text("fontSize: tabbarTitleTextFontsize",style: TextStyle(fontSize: tabbarTitleTextFontsize),),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: Text(" fontSize: alertDilogeTextFontsize",style: TextStyle( fontSize: alertDilogeTextFontsize),),
          // ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment:MainAxisAlignment.center,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Icon(CustomIcons.briefcase_svgrepo_com,size: 50,),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Icon(CustomIcons.brightness_6,size: 50,),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Icon(CustomIcons.brightness_auto,size: 50,),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Icon(CustomIcons.telephone_svgrepo_com,size: 50,),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Icon(CustomIcons.pen_svgrepo_com,size: 50,),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
