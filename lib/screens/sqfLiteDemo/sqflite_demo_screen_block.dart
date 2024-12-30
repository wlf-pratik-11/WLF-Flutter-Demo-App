import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_app_demo/screens/sqfLiteDemo/addContacts/add_contact_screen.dart';
import 'package:main_app_demo/screens/sqfLiteDemo/sqflite_demo_screen_repo.dart';
import 'package:rxdart/rxdart.dart';

class SqfliteDemoScreenBlock{

  SqfliteDemoScreenBlock(){
    getAllUsers();
    allContacts.sink.add(contactList);
  }

  final allContacts = BehaviorSubject<List<Map<String,dynamic>>>();

  List<Map<String,dynamic>> contactList = [];

  Future<List<Map<String, dynamic>>> deleteContact(int id) async {
    try {
      print("::::::::::::::::::::::::Iddd : $id::::::::::::::::::::::::");
      await SqfliteDemoScreenRepo.deleteContact(id);
      contactList = await SqfliteDemoScreenRepo.getAllContacts();
      allContacts.sink.add(contactList);
      print("::::::::::::::::::::::::Contact Listc : ${contactList.toString()}::::::::::::::::::::::::");
    } catch (e) {
      print("Error deleting contact: $e");
    }
    return contactList;
  }


  Future<List<Map<String,dynamic>>> getAllUsers()async{
    contactList = await SqfliteDemoScreenRepo.getAllContacts();
    allContacts.sink.add(contactList);
    return contactList;
  }


  void goToAddContactScreen(BuildContext context,{int? id}){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => id==null ?AddContactScreen(refreshAllUsers: () {
        return getAllUsers();
      }):AddContactScreen(refreshAllUsers: () {
        return getAllUsers();
      },id: id,)),
    );
  }
}