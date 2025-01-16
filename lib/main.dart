import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/commons/my_colors.dart';
import 'package:main_app_demo/screens/pushnotificationScreen/pushnotification_service.dart';
import 'package:overlay_support/overlay_support.dart';

import 'firebase_options.dart';
import 'login_cheack.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PushnotificationService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    commonFontSizes(context);
    return OverlaySupport(
      global: true,
      toastTheme: ToastThemeData(background: Colors.yellow),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: GoogleFonts.nunito().fontFamily,
          appBarTheme: AppBarTheme(color: MyColors.darkBlue),
        ),
        home: LoginCheack(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
