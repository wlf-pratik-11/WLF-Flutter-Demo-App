import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/commons/multi_language_strings.dart';
import 'package:main_app_demo/screens/signUpScreen/signup_screen.dart';
import 'package:main_app_demo/screens/tabbarDemo/tabbar_screen.dart';

import '../commons/my_colors.dart';
import 'changeScreensDemo/content_holder_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static const List menuItem = [
    {
      "name":"Tabbar and Dialog Demo",
      "route":TabbarDemoPage()
    },
    {
      "name":"Practice Screen",
      "route": ContentHolderScreen()
    },
    {
      "name":"Sign Up Screen",
      "route": SignupScreen()
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            MultiLanguageStrings.mainPage,
            style: appbarTextStyle(),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: MyColors.darkBlue,
          systemOverlayStyle: SystemUiOverlayStyle(
            systemStatusBarContrastEnforced: true,
            // statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          )),
      drawer: Drawer(
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
                      color: Colors
                          .white, // Ensures text is visible on top of the image
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

      ),
    );
  }
}
