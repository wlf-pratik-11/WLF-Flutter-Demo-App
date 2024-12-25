import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/commons/my_colors.dart';

class ShowImageFromCameraAndGalleryScreen extends StatefulWidget {
  const ShowImageFromCameraAndGalleryScreen({super.key});

  @override
  State<ShowImageFromCameraAndGalleryScreen> createState() => _ShowImageFromCameraAndGalleryScreenState();
}

class _ShowImageFromCameraAndGalleryScreenState extends State<ShowImageFromCameraAndGalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Show Image From Camera and Gallery"),
      body: _buildBody(context),
    );
  }
}

Widget _buildBody(BuildContext context) {
  return Column(
    children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0,20,0,0),
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt_outlined,size: 45,color: Colors.white,),
                              Text("Camera",style: TextStyle(fontSize: 20,color: Colors.white),)
                            ],
                          ),
                          Spacer(),
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.photo_album_outlined,size: 45,color: Colors.white,),
                              Text("Gallery",style: TextStyle(fontSize: 20,color: Colors.white),)
                            ],
                          ),
                          Spacer()
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Text("Pick Image",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20,),),
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.darkBlue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              elevation: 3,
            ),

          ),
        ),
      )
    ],
  );
}
