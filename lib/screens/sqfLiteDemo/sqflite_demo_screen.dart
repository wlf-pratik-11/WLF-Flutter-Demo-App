import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/commons/my_colors.dart';
import 'package:main_app_demo/screens/sqfLiteDemo/sqflite_demo_screen_block.dart';

import 'addContacts/add_contact_screen.dart';

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
              Text("Add Contact",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: alertDilogeTextFontsize),),
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
          Text("Please Add Contact",style: TextStyle(fontSize: descriptionFontsize),):
          listView(contactList.data ?? []);
        }
      ),
    );
  }
  Widget listView( List<Map<String,dynamic>> contactList ){
    return ListView.builder(
      itemCount: contactList.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: MyColors.darkBlue,),
          margin: EdgeInsets.all(10),
          height: cardHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 25),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  clipBehavior: Clip.antiAlias,
                  child: (contactList[index]['img'].toString().isEmpty??true) ? Image.asset("assets/images/userImg.png",height: 60,width: 60,fit: BoxFit.cover,) : Image.file(File(contactList[index]['img']??" "),height: 60,width: 60,fit: BoxFit.cover,),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(contactList[index]['name'],style: TextStyle(fontSize: cardTitleTextFontsize,color: Colors.white,fontWeight: FontWeight.bold),),
                  Text("+91 ${contactList[index]['mobile']}",style: TextStyle(fontSize: cardSubTextFontsize,color: Colors.white,fontWeight: FontWeight.bold),)
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
                    size: iconSize,
                  ),
                  onTap: () {
                    _bloc.goToAddContactScreen(context,id: contactList[index]['id']);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                    size: iconSize,
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text("Are sure want to delete: ${contactList[index]['name']}"),
                        backgroundColor: MyColors.darkBlue,
                        titleTextStyle: TextStyle(color: Colors.white, fontSize: alertDilogeTextFontsize,fontWeight: FontWeight.bold,fontFamily: GoogleFonts.nunito().fontFamily,),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: Text('Cancel',style: TextStyle(color: Colors.white, fontSize: alertDilogeTextFontsize,fontWeight: FontWeight.bold,fontFamily: GoogleFonts.nunito().fontFamily,)),
                          ),
                          TextButton(
                            onPressed: () {
                              _bloc.deleteContact(contactList[index]['id']);
                              Navigator.pop(context);
                            },
                            child: Text('Yes',style: TextStyle(color: Colors.white, fontSize: alertDilogeTextFontsize,fontWeight: FontWeight.bold,fontFamily: GoogleFonts.nunito().fontFamily,),),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget gridView(List<Map<String,dynamic>> contactList){
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(contactList.length, (index) {
        return Container(
          decoration: BoxDecoration(color: MyColors.darkBlue,borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.white,width: 5)),
          height: cardHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 25,top: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  clipBehavior: Clip.antiAlias,
                  child: (contactList[index]['img'].toString().isEmpty??true) ? Image.asset("assets/images/userImg.png",height: 60,width: 60,fit: BoxFit.cover,) : Image.file(File(contactList[index]['img']??" "),height: 60,width: 60,fit: BoxFit.cover,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(contactList[index]['name'],style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                    Text("+91 ${contactList[index]['mobile']}",style: TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),Spacer(),
                      InkWell(
                        radius: 15,
                        highlightColor: Colors.transparent,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onTap: () {
                          _bloc.goToAddContactScreen(context, id: contactList[index]['id']);
                        },
                      ),
                      Spacer(),
                      InkWell(
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text("Are sure want to delete: ${contactList[index]['name']}"),
                              backgroundColor: MyColors.darkBlue,
                              titleTextStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.nunito().fontFamily,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                  child: Text('Cancel',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: GoogleFonts.nunito().fontFamily,
                                      )),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _bloc.deleteContact(contactList[index]['id']);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: GoogleFonts.nunito().fontFamily,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Spacer(),Spacer(),
                    ],
                  ),
              ),
              ],
            ),
        );
      },),
    );
  }
}
