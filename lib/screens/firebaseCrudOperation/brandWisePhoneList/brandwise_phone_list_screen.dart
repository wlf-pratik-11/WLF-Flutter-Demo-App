import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
  final BrandwisePhoneListScreenBloc _bloc = BrandwisePhoneListScreenBloc();

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
        backgroundColor: Colors.black,
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
              padding: EdgeInsets.only(bottom: screenSizeRatio * 0.15),
              defaultChild:
                  Center(child: LoadingAnimationWidget.discreteCircle(color: MyColors.darkBlue, size: screenSizeRatio * 0.06)),
              query: _bloc.getFirebaseRef(widget.index),
              itemBuilder: (context, snapshot, animation, indexOfItemBuilder) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.02, vertical: screenSizeRatio * 0.01),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                  "Edit or Delete",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenSizeRatio * 0.03,
                                  ),
                                ),
                                content: Text(
                                  "which action are you want to perform ?",
                                  style: TextStyle(color: Colors.white, fontSize: descriptionFontsize),
                                ),
                                actions: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.push(context, MaterialPageRoute(
                                            builder: (context) {
                                              BigInt itemKey = BigInt.parse(snapshot.key.toString());
                                              return AddPhoneScreen(widget.index, itemKey: itemKey);
                                            },
                                          ));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10))),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              color: MyColors.darkBlue,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.01),
                                              child: Text(
                                                "Edit",
                                                style: TextStyle(
                                                    color: MyColors.darkBlue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: descriptionFontsize),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Center(
                                                  child: Icon(
                                                Icons.delete_outline,
                                                color: Colors.white,
                                                size: screenSizeRatio * 0.05,
                                              )),
                                              backgroundColor: MyColors.darkBlue,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10)),
                                              content: Text(
                                                "Are you sure to detele this record ?",
                                                style: TextStyle(color: Colors.white, fontSize: descriptionFontsize),
                                              ),
                                              actions: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text(
                                                          "Cancel",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: descriptionFontsize),
                                                        )),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        BigInt itemKey = BigInt.parse(snapshot.key.toString());
                                                        return _bloc.deleteData(widget.index, itemKey, context);
                                                      },
                                                      child: Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            color: MyColors.darkBlue,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: descriptionFontsize),
                                                      ),
                                                      style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadiusDirectional.circular(10)),
                                                          backgroundColor: Colors.white),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10))),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.delete_outline,
                                              color: MyColors.darkBlue,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.01),
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: MyColors.darkBlue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: descriptionFontsize),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: Colors.white, fontWeight: FontWeight.bold, fontSize: descriptionFontsize),
                                          )),
                                    ],
                                  ),
                                ],
                                backgroundColor: MyColors.darkBlue,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10)),
                              ));
                    },
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
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadiusDirectional.circular(10),
                                  color: Colors.white,
                                ),
                                height: screenSizeRatio * 0.42,
                                width: screenSizeRatio * 0.26,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.02),
                                  child: ClipRRect(
                                    borderRadius: BorderRadiusDirectional.circular(10),
                                    child: Image.network(
                                      snapshot.child("imgUrl").value.toString(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.03, vertical: screenSizeRatio * 0.03),
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
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 5,
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
              }),
        )
      ],
    );
  }
}
