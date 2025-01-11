import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/screens/firebaseCrudOperation/firebase_crud_screen_bloc.dart';

import '../../../commons/my_colors.dart';
import 'addPhone/add_phone_screen.dart';
import 'brandwise_phone_list_screen_bloc.dart';

class BrandwisePhoneListScreen extends StatefulWidget {
  final index;

  const BrandwisePhoneListScreen(this.index, {super.key});

  @override
  State<BrandwisePhoneListScreen> createState() => _BrandwisePhoneListScreenState();
}

class _BrandwisePhoneListScreenState extends State<BrandwisePhoneListScreen> {
  BrandwisePhoneListScreenBloc _bloc = BrandwisePhoneListScreenBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("${FirebaseCrudScreenBloc().brandLogoList[widget.index].brandName} Phone List"),
      body: _buildScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddPhoneScreen(widget.index),
          ));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: MyColors.darkBlue,
      ),
    );
  }

  Widget _buildScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: FirebaseAnimatedList(
            query: _bloc.getFirebaseRef(widget.index),
            itemBuilder: (context, snapshot, animation, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.02, vertical: screenSizeRatio * 0.01),
                child: InkWell(
                  onTap: () {},
                  child: Card(
                    elevation: 10,
                    child: Container(
                      height: apiCallScreenListItemHeight,
                      decoration: BoxDecoration(
                        color: MyColors.darkBlue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.015),
                            child: ClipRRect(
                              borderRadius: BorderRadiusDirectional.circular(10),
                              child: Image.network(
                                snapshot.child("imgUrl").value.toString(),
                                fit: BoxFit.fill,
                                height: screenSizeRatio * 0.42,
                                width: screenSizeRatio * 0.26,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.03, vertical: screenSizeRatio * 0.03),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.child("phoneName").value.toString(),
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: screenSizeRatio * 0.025),
                                  ),
                                  Spacer(),
                                  Text("Price : ₹${snapshot.child("price").value.toString()}",
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: screenSizeRatio * 0.025)),
                                  Spacer(),
                                  Text("About : ${snapshot.child("description").value.toString()}",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: screenSizeRatio * 0.025)),
                                  Spacer(),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
