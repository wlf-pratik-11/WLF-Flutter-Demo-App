import 'dart:io';

import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/commons/my_colors.dart';
import 'package:main_app_demo/screens/sqfLiteDemo/sqflite_demo_screen_block.dart';

class SqfliteDemoScreen extends StatefulWidget {
  const SqfliteDemoScreen({super.key});

  @override
  State<SqfliteDemoScreen> createState() => _SqfliteDemoScreenState();
}

class _SqfliteDemoScreenState extends State<SqfliteDemoScreen> {
  SqfliteDemoScreenBlock _bloc = SqfliteDemoScreenBlock();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBar("Sqf Lite Demo",actions: [
        InkWell(
          radius: 15,
          highlightColor:  Colors.transparent,
          child: Row(
            children: [
              Text("Add Contact",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(Icons.add,color: Colors.white,size: 30),
              ),
            ],
          ),
          onTap: () {
            _bloc.goToAddContactScreen(context);
          },
        ),
      ]),
      body: StreamBuilder<List<Map<String,dynamic>>>(
        stream: _bloc.allContacts,
        builder: (context, contactList) {
          return contactList.data?.length==null ?
          Text("Please Add Contact"):
          ListView.builder(
            itemCount: contactList.data?.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: MyColors.darkBlue,),
                margin: EdgeInsets.all(10),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 25),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        clipBehavior: Clip.antiAlias,
                        child: (contactList.data?[index]['img'].toString().isEmpty??true) ? Image.asset("assets/images/userImg.png",height: 60,width: 60,fit: BoxFit.cover,) : Image.file(File(contactList.data?[index]['img']??" "),height: 60,width: 60,fit: BoxFit.cover,),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(contactList.data?[index]['name'],style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                        Text("+91 ${contactList.data?[index]['mobile']}",style: TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.bold),)
                      ],
                    ),
                    Spacer(),
                    Padding(
                              padding: const EdgeInsets.only(right: 25),
                              child: InkWell(
                                radius: 15,
                                highlightColor:  Colors.transparent,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  print("Edit Button");
                                },
                              ),
                            ),
                            Padding(
                      padding: const EdgeInsets.only(right: 20),
                              child: InkWell(
                                child: Icon(
                                  Icons.delete_outline,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  _bloc.deleteContact(index);
                                },
                              ),
                            ),
                  ],
                ),
              );
              },
          );
        }
      ),
    );
  }
}
