import 'dart:async';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddItemBloc{

  AddItemBloc();

  final myController = BehaviorSubject<String>();

  TextEditingController item = TextEditingController();
  
  List<String> itemList = [];

  Future<void> saveItemList(List<String> itemList) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList('itemList',itemList);
  }

  void addItem(){
    itemList.add(item.text);
  }

}