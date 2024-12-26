import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

import '../../commons/my_colors.dart';

class ShowImageFromCameraAndGalleryScreenBloc{
  ShowImageFromCameraAndGalleryScreenBloc();

  final myController = BehaviorSubject<String>();

  File? image;

  void pickImageFromGallery()async{
    PermissionStatus status = await Permission.photos.request();
    if(status==PermissionStatus.granted){
      try{
        final image  = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 100);
        if(image==null) return;

        myController.sink.add(await imageCrop(image.path));
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
        myController.sink.add((await imageCrop(image.path)));
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
}