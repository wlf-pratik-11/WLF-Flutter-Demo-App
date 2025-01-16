import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/screens/pushnotificationScreen/pushnotification_demo_screen_bloc.dart';
import 'package:main_app_demo/screens/pushnotificationScreen/pushnotification_service.dart';

class PushnotificationDemoScreen extends StatefulWidget {
  const PushnotificationDemoScreen({super.key});

  @override
  State<PushnotificationDemoScreen> createState() => _PushnotificationDemoScreenState();
}

class _PushnotificationDemoScreenState extends State<PushnotificationDemoScreen> {
  PushnotificationDemoScreenBloc _bloc = PushnotificationDemoScreenBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Pushnotification Demo"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              PushnotificationService().showNotification();
            },
            child: Center(child: Text("Pushnotification Demo")),
          ),
        ],
      ),
    );
  }
}
