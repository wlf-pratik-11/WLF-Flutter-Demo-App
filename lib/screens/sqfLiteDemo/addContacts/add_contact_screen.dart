import 'dart:io';

import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/screens/sqfLiteDemo/addContacts/add_contact_screen_bloc.dart';
import 'package:main_app_demo/screens/sqfLiteDemo/sqflite_demo_screen_block.dart';

import '../../../commons/my_colors.dart';

class AddContactScreen extends StatefulWidget {
  final int? id;
  final Function()? refreshAllUsers;
  const AddContactScreen({super.key,this.refreshAllUsers,this.id});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {

  @override
  Widget build(BuildContext context) {
    final AddContactScreenBloc _bloc = AddContactScreenBloc(widget.id);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBar(widget.id != null ? "Edit Contact" : "Add Contact"),
      body:SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 120,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: StreamBuilder<String>(
                    stream: _bloc.addContactImageController,
                    builder: (context, image) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(100),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          clipBehavior: Clip.antiAlias,
                          child: (image.data==null) ? Image.asset("assets/images/userImg.png",height: 150,width: 150,fit: BoxFit.cover,) : Image.file(File(image.data??""),height: 150,width: 150,fit: BoxFit.cover,),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: MyColors.darkBlue,
                                ),
                                height: 150,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Spacer(),
                                      InkWell(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.camera_alt_outlined,size: 45,color: Colors.white,),
                                            Text("Camera",style: TextStyle(fontSize: alertDilogeTextFontsize,color: Colors.white),)
                                          ],
                                        ),
                                        onTap: () {
                                          _bloc.pickImageFromCamera();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      Spacer(),
                                      Spacer(),
                                      InkWell(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.photo_album_outlined,size: 45,color: Colors.white,),
                                            Text("Gallery",style: TextStyle(fontSize: alertDilogeTextFontsize,color: Colors.white),)
                                          ],
                                        ),
                                        onTap: () {
                                          _bloc.pickImageFromGallery();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      Spacer()
                                      // Image.file(_bloc.image??),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  ),
                ),
                Form(
                  key: _bloc.formKey,
                    child: Column(
                      children: [
                        inputField("Name", _bloc.name,validator: (value) {
                          return _bloc.nameValidator(value);
                        },),
                        inputField("Phone Number", _bloc.contact,validator: (value) {
                          return _bloc.mobileNumberValidator(value);
                        },isNumber: true),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      if(_bloc.validateForm()){
                        final snakBar = SnackBar(
                          content:Text(widget.id == null ?"Contact saved successfully..!!" : "Contact updated successfully..!!",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: snakbarFontsize),),
                          backgroundColor: Colors.black,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snakBar);
                        widget.id == null ?_bloc.saveOrUpdateContact():_bloc.saveOrUpdateContact(id: widget.id);
                        _bloc.name.clear();
                        _bloc.contact.clear();
                        Navigator.pop(context);
                      }
                      else{
                        final snakBar = SnackBar(
                          content:Text(widget.id == null ?"Contact Not saved..!!" : "Contact not updated.!!",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: snakbarFontsize),),
                          backgroundColor: Colors.black,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snakBar);
                      }
                      print("::::::::::::::::::Refresh all Users : ${widget.refreshAllUsers?.call()}");
                      widget.refreshAllUsers?.call();


                    },
                    child: Text(widget.id == null ? "Save Contact" : "Update Contact",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: buttonFontsize,),),
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
          ),
    );
  }
}
