import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_app_demo/screens/sqfLiteDemo/sqflite_demo_screen_repo.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

import '../../../commons/my_colors.dart';

class AddContactScreenBloc {

  AddContactScreenBloc();

  final addContactController = BehaviorSubject<String>();
  final addContactImageController = BehaviorSubject<String>();

  final singleContact = BehaviorSubject<List<Map<String,dynamic>>>();
  List<Map<String,dynamic>> singleContactList = [];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController contact = TextEditingController();

  String img="";


  void pickImageFromGallery()async{
    PermissionStatus status = await Permission.photos.request();
    if(status==PermissionStatus.granted){
      try{
        final image  = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 100);
        if(image==null) return;
        img = image.path;
        addContactImageController.sink.add(await imageCrop(image.path));
      }
      catch(e){
        print("::::::::::::::::There is Error:::::::::::::::::::");
      }
    }
    else if(status==PermissionStatus.denied){
      print("::::::::::::::::Permission is Denied:::::::::::::::::::");
    }
  }

  void pickImageFromCamera()async{
    PermissionStatus status = await Permission.camera.request();
    if(status==PermissionStatus.granted){
      try{
        final image  = await ImagePicker().pickImage(source: ImageSource.camera);
        if(image==null) return;
        img = image.path;
        addContactImageController.sink.add((await imageCrop(image.path)));
      }
      catch(e){
        print("::::::::::::::::There is Error:::::::::::::::::::");
      }
    }
    else if(status==PermissionStatus.denied){
      print("::::::::::::::::Permission is Denied:::::::::::::::::::");
      openAppSettings();
    }
  }

  Future<String> imageCrop(String path) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "Image Cropper",
            cropGridColor: Colors.white,
            toolbarColor: MyColors.darkBlue,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: Colors.cyanAccent,
            dimmedLayerColor: Colors.black,
            aspectRatioPresets: [
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
            ],
          ),
        ]
    );
    return croppedFile?.path??"";
  }

  String? nameValidator(String value){
    if(value.isEmpty || value.length<4){
      return "Enter Your Full Name..";
    }else{
      return null;
    }
  }

  String? mobileNumberValidator(String value){
    if(value.isEmpty || value.length<10){
      return "Enter Mobile Number";
    }else{
      return null;
    }
  }

  bool validateForm(){
    if(formKey.currentState?.validate()??false){
      return true;
    }
    else{
      return false;
    }
  }

  Future<void> addContact()async{
    if(validateForm()){
      await SqfliteDemoScreenRepo.addNewContact(name.text, contact.text,img);
    }
  }

  Future<List<Map<String,dynamic>>> getContactById(int id)async{
    singleContactList = await SqfliteDemoScreenRepo.getContactById(id);
    img = singleContactList[id]['img'];
    name = singleContactList[id]['name'];
    contact = singleContactList[id]['contact'];
    singleContact.sink.add(singleContactList);
    return singleContactList;
  }

}