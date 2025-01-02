import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';

import '../../commons/my_colors.dart';
import 'api_call_screen_bloc.dart';

class ApiCallScreen extends StatefulWidget {
  const ApiCallScreen({super.key});

  @override
  State<ApiCallScreen> createState() => _ApiCallScreenState();
}

class _ApiCallScreenState extends State<ApiCallScreen> {
  ApiCallScreenBloc _bloc = ApiCallScreenBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBar("Api Call Screen"),
      body: _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return StreamBuilder<List<Map<String, dynamic>>>(
        stream: _bloc.myController,
        builder: (context, snapshot) {
          return (snapshot.data?.isEmpty ?? true)
              ? Center(
                  child: CircularProgressIndicator(
                  color: MyColors.darkBlue,
                ))
              : ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          int id = int.parse(snapshot.data?[index]['id']);
                          _bloc.goToEditDataScreen(
                            context,
                            id,
                          );
                        },
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
                                child: Image.network(
                                  snapshot.data?[index]['image'],
                                  fit: BoxFit.cover,
                                  height: screenSizeRatio * 0.42,
                                  width: screenSizeRatio * 0.26,
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
                                        snapshot.data?[index]['name'],
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            color: Colors.white, fontWeight: FontWeight.bold, fontSize: screenSizeRatio * 0.025),
                                      ),
                                      Spacer(),
                                      Text("Birth Date :${snapshot.data?[index]['bDate']}",
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: screenSizeRatio * 0.025)),
                                      Spacer(),
                                      Text("City: ${snapshot.data?[index]['city']}",
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: screenSizeRatio * 0.025)),
                                      Spacer(),
                                      Text("Phone : ${snapshot.data?[index]['mobileNum']}",
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: screenSizeRatio * 0.025)),
                                      Spacer(),
                                      Text("Email: ${snapshot.data?[index]['email']}",
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: screenSizeRatio * 0.025)),
                                      Spacer(),
                                      Text("Address: ${snapshot.data?[index]['address']}",
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: screenSizeRatio * 0.025)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        });
  }
}
