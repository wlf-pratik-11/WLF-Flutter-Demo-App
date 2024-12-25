import 'dart:async';

import 'package:flutter/material.dart';
import 'package:main_app_demo/screens/tabbarDemo/formForNavigatorDemo/form_for_navigator_screen.dart';

class TabbarScreenBlock{
  final _myController = StreamController<String>();
  Stream<String> get myStream => _myController.stream;
  Sink<String> get mySink => _myController.sink;

  String name = '';
  String mobile = '';
  String birthDate = '';
  String email = '';

  void navigateAndGetDAtaFromForm(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FormForNavigator(),
        ));

    if (!context.mounted) return;

    if (result != null) {
      name = result['name'];
      mobile = result['mobile'];
      birthDate = result['birthDate'];
      email = result['email'];
      mySink.add(name);
      mySink.add(mobile);
      mySink.add(birthDate);
      mySink.add(email);
    }
  }

  void dispose(){
    _myController.close();
  }


}