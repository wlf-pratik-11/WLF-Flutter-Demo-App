import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/screens/sharedPreferencesScreen/addItem/add_item_bloc.dart';

import '../../../commons/my_colors.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  AddItemBloc _bloc = AddItemBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Add Items"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.only(left: 25,right: 25),
            child: TextFormField(controller: _bloc.item,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  suffixIcon: Icon(Icons.add_business_outlined),label: Text("Item Name :",style: TextStyle(fontSize: textfieldTitleFontsize),),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25,right: 25,top: 30),
            child: ElevatedButton(
              onPressed: () {
                  _bloc.saveItemList();
                  Navigator.pop(context);
              },
              child: Text("Add",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: buttonFontsize,),),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 0,vertical: 10),
                minimumSize: Size(double.maxFinite, 20),
                backgroundColor: MyColors.darkBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
