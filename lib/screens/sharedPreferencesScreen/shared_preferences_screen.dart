import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/commons/my_colors.dart';
import 'package:main_app_demo/screens/sharedPreferencesScreen/shared_preferences_screen_bloc.dart';

import 'addItem/add_item.dart';

class SharedPreferencesScreen extends StatefulWidget {
  const SharedPreferencesScreen({super.key});

  @override
  State<SharedPreferencesScreen> createState() => _SharedPreferencesScreenState();
}

class _SharedPreferencesScreenState extends State<SharedPreferencesScreen> {
  SharedPreferencesScreenBloc _bloc = SharedPreferencesScreenBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBar("Shared Preferences Demo"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 25,),
          Center(child: Text("Item List",style: TextStyle(fontSize: tabbarFontsize,color: MyColors.darkBlue,fontWeight: FontWeight.bold,),)),
          Expanded(
            child: StreamBuilder<List<String>>(
              stream: _bloc.myController,
              builder: (context, itemList) {
                return ListView.builder(
                  padding:EdgeInsets.only(top: 10,bottom: 20) ,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: itemList.data?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                        child: Container(
                          height: 100,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: MyColors.darkBlue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: Text("${itemList.data?[index]}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: cardTitleTextFontsize),textAlign: TextAlign.center,)),
                        ),
                      );
                    },
                );
              }
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
            await Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddItem();
            },));
            _bloc.getItemList();
        },
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
    );
  }
}
