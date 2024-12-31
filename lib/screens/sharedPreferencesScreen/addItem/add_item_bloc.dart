import 'dart:async';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddItemBloc{

  AddItemBloc();

  final myController = BehaviorSubject<String>();

  TextEditingController item = TextEditingController();

  Future<void> saveItemList() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> itemList =pref.getStringList('itemList') ?? [];
    itemList.add(item.text);
    print("Data Saved: ${itemList.toString()}");
    await pref.setStringList('itemList',itemList);
  }

}