import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/commons/my_colors.dart';
import 'package:main_app_demo/screens/showImageFromCamera/show_image_from_camera_and_gallery_screen_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

class ShowImageFromCameraAndGalleryScreen extends StatefulWidget {
  const ShowImageFromCameraAndGalleryScreen({super.key});

  @override
  State<ShowImageFromCameraAndGalleryScreen> createState() => _ShowImageFromCameraAndGalleryScreenState();
}

class _ShowImageFromCameraAndGalleryScreenState extends State<ShowImageFromCameraAndGalleryScreen> {
  ShowImageFromCameraAndGalleryScreenBloc _bloc = ShowImageFromCameraAndGalleryScreenBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBar("Show Image From Camera and Gallery"),
      body: _buildBody(context,_bloc),
    );
  }
}

Widget _buildBody(BuildContext context,ShowImageFromCameraAndGalleryScreenBloc _bloc) {
  return StreamBuilder<String>(
    stream: _bloc.myController,
    builder: (context, image) {
      return Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: (image.data == "") ? AssetImage('assets/drawer_background/drawerbg.jpeg'):
                  FileImage(File(image.data ?? "")),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: ElevatedButton(
              onPressed: () {
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
                                  Text("Camera",style: TextStyle(fontSize: 20,color: Colors.white),)
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
                                  Text("Gallery",style: TextStyle(fontSize: 20,color: Colors.white),)
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
              child: Text("Pick Image",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: buttonFontsize,),),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 0,vertical: 10),
                minimumSize: Size(double.maxFinite, 20),
                backgroundColor: MyColors.darkBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                elevation: 3,
              ),
            ),
          ),
        ],
      );
    }
  );
}


