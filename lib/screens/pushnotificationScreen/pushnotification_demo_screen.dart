import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';

class PushnotificationDemoScreen extends StatefulWidget {
  const PushnotificationDemoScreen({super.key});

  @override
  State<PushnotificationDemoScreen> createState() => _PushnotificationDemoScreenState();
}

class _PushnotificationDemoScreenState extends State<PushnotificationDemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Pushnotification Demo"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text("Pushnotification Demo")],
      ),
    );
  }
}
