import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/screens/googleMapRouteScreen/chooseLocationFromMapScreen/choose_location_from_map_screen.dart';
import 'package:main_app_demo/screens/googleMapRouteScreen/showRouteScreen/show_route_screen.dart';
import 'package:main_app_demo/screens/googleMapRouteScreen/showRouteScreen/show_route_screen_bloc.dart';

import '../../commons/my_colors.dart';
import '../googleMapScreen/mapScreen/LocationSuggetionDl.dart';
import 'select_location_screen_bloc.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  SelectLocationScreenBloc _bloc = SelectLocationScreenBloc();
  List<Predictions>? searchSuggestions = [];

  @override
  Widget build(BuildContext context) {
    _bloc.getConfirmLocation();
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: commonAppBar("Trip Route Selection"),
        body: StreamBuilder<List<Predictions>>(
            stream: _bloc.suggetionListController,
            builder: (context, snapshot) {
              return StreamBuilder<bool>(
                  stream: _bloc.showSuggestionsController,
                  builder: (context, showSuggetionCheckSnapshot) {
                    return Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: screenSizeRatio * 0.05, right: screenSizeRatio * 0.02, left: screenSizeRatio * 0.02),
                                  child: ListTile(
                                    tileColor: MyColors.darkBlue.withOpacity(0.05),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10)),
                                    leading: Icon(
                                      Icons.location_on_outlined,
                                      color: MyColors.darkBlue,
                                      size: screenSizeRatio * 0.05,
                                    ),
                                    title: Text(
                                      "Select Your Route",
                                      style: TextStyle(
                                          color: MyColors.darkBlue,
                                          fontSize: screenSizeRatio * 0.03,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: screenSizeRatio * 0.03, right: screenSizeRatio * 0.03, top: screenSizeRatio * 0.05),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      _bloc.isFromLocation.sink.add(true);
                                      _bloc.getSuggetions();
                                      searchSuggestions = value.isEmpty ? [] : snapshot.data;
                                      value.isEmpty
                                          ? _bloc.showSuggestionsController.sink.add(false)
                                          : _bloc.showSuggestionsController.sink.add(true);
                                    },
                                    keyboardType: TextInputType.streetAddress,
                                    controller: _bloc.fromLocation,
                                    decoration: InputDecoration(
                                      labelText: "Your Location",
                                      labelStyle: TextStyle(color: MyColors.darkBlue, fontWeight: FontWeight.bold),
                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                      filled: true,
                                      fillColor: Colors.white,
                                      prefixIconConstraints: BoxConstraints(maxHeight: screenSizeRatio * 0.05),
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.025),
                                        child: Icon(
                                          Icons.my_location,
                                          color: MyColors.darkBlue,
                                          size: screenSizeRatio * 0.035,
                                        ),
                                      ),
                                      suffixIcon: InkWell(
                                        onTap: () async {
                                          _bloc.showSuggestionsController.sink.add(false);
                                        },
                                        child: Icon(Icons.search),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: MyColors.darkBlue, width: 0.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: MyColors.darkBlue, width: 2),
                                      ),
                                    ),
                                  ),
                                ),
                                if (showSuggetionCheckSnapshot.data == true && _bloc.isFromLocation.value == true)
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: screenSizeRatio * 0.02, horizontal: screenSizeRatio * 0.03),
                                        child: Container(
                                          height: screenSizeRatio * 0.6,
                                          decoration: BoxDecoration(
                                            color: MyColors.darkBlue.withOpacity(0.05),
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(color: Colors.grey.shade300, blurRadius: 5, offset: Offset(0, 3)),
                                            ],
                                          ),
                                          child: ListView.separated(
                                            separatorBuilder: (context, index) {
                                              return Divider();
                                            },
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: searchSuggestions?.length ?? 0,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                title: Text(
                                                  searchSuggestions?[index].description ?? " No Data Found",
                                                  maxLines: 2,
                                                ),
                                                onTap: () async {
                                                  _bloc.isFromLocation.sink.add(false);
                                                  _bloc.fromLocation.text = searchSuggestions?[index].description ?? "";
                                                  await _bloc.getLatLonFromPlaceID(searchSuggestions?[index].placeId ?? "");
                                                  _bloc.showSuggestionsController.sink.add(false);
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: screenSizeRatio * 0.03, vertical: screenSizeRatio * 0.01),
                                        child: ListTile(
                                          onTap: () {
                                            _bloc.showSuggestionsController.sink.add(false);
                                            Navigator.push(context, MaterialPageRoute(
                                              builder: (context) {
                                                return ChooseLocationFromMapScreen(
                                                  isFromLocation: true,
                                                );
                                              },
                                            ));
                                          },
                                          trailing: Icon(
                                            Icons.navigate_next,
                                            color: MyColors.darkBlue,
                                            size: screenSizeRatio * 0.05,
                                          ),
                                          tileColor: MyColors.darkBlue.withOpacity(0.05),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10)),
                                          leading: Icon(
                                            Icons.map_outlined,
                                            color: MyColors.darkBlue,
                                            size: screenSizeRatio * 0.04,
                                          ),
                                          title: Text(
                                            "Set location from map",
                                            style: TextStyle(
                                                color: MyColors.darkBlue,
                                                fontSize: screenSizeRatio * 0.03,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.03, vertical: screenSizeRatio * 0.02),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      _bloc.isFromLocation.sink.add(false);
                                      _bloc.getSuggetions();
                                      searchSuggestions = value.isEmpty ? [] : snapshot.data;
                                      value.isEmpty
                                          ? _bloc.showSuggestionsController.sink.add(false)
                                          : _bloc.showSuggestionsController.sink.add(true);
                                    },
                                    keyboardType: TextInputType.streetAddress,
                                    controller: _bloc.toLocation,
                                    decoration: InputDecoration(
                                      labelText: "Chose Destination",
                                      labelStyle: TextStyle(color: MyColors.darkBlue, fontWeight: FontWeight.bold),
                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                      filled: true,
                                      fillColor: Colors.white,
                                      prefixIconConstraints: BoxConstraints(maxHeight: screenSizeRatio * 0.05),
                                      prefixIcon: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.025),
                                        child: Icon(
                                          Icons.location_on_outlined,
                                          color: MyColors.darkBlue,
                                          size: screenSizeRatio * 0.04,
                                        ),
                                      ),
                                      suffixIcon: InkWell(
                                        onTap: () async {
                                          // await _bloc.findAddress();
                                          // _bloc.showSuggestionsController.sink.add(false);
                                        },
                                        child: Icon(Icons.search),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: MyColors.darkBlue, width: 0.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(color: MyColors.darkBlue, width: 2),
                                      ),
                                    ),
                                  ),
                                ),
                                if (showSuggetionCheckSnapshot.data == true && _bloc.isFromLocation.value == false)
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: screenSizeRatio * 0.02, horizontal: screenSizeRatio * 0.03),
                                        child: Container(
                                          height: screenSizeRatio * 0.6,
                                          decoration: BoxDecoration(
                                            color: MyColors.darkBlue.withOpacity(0.05),
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(color: Colors.grey.shade300, blurRadius: 5, offset: Offset(0, 3)),
                                            ],
                                          ),
                                          child: ListView.separated(
                                            separatorBuilder: (context, index) {
                                              return Divider();
                                            },
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: searchSuggestions?.length ?? 0,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                title: Text(
                                                  searchSuggestions?[index].description ?? " No Data Found",
                                                  maxLines: 2,
                                                ),
                                                onTap: () async {
                                                  _bloc.toLocation.text = searchSuggestions?[index].description ?? "";
                                                  await _bloc.getLatLonFromPlaceID(searchSuggestions?[index].placeId ?? "");
                                                  // await _bloc.findAddress();
                                                  _bloc.showSuggestionsController.sink.add(false);
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: screenSizeRatio * 0.03, vertical: screenSizeRatio * 0.01),
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(
                                              builder: (context) {
                                                _bloc.showSuggestionsController.sink.add(false);
                                                return ChooseLocationFromMapScreen(
                                                  isFromLocation: false,
                                                );
                                              },
                                            ));
                                          },
                                          trailing: Icon(
                                            Icons.navigate_next,
                                            color: MyColors.darkBlue,
                                            size: screenSizeRatio * 0.05,
                                          ),
                                          tileColor: MyColors.darkBlue.withOpacity(0.05),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10)),
                                          leading: Icon(
                                            Icons.map_outlined,
                                            color: MyColors.darkBlue,
                                            size: screenSizeRatio * 0.04,
                                          ),
                                          title: Text(
                                            "Set location from map",
                                            style: TextStyle(
                                                color: MyColors.darkBlue,
                                                fontSize: screenSizeRatio * 0.03,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.03, vertical: screenSizeRatio * 0.04),
                          child: darkBlueCommonButton("Confirm Location", onPressed: () async {
                            await ShowRouteScreenBloc().userCurrentPosition();
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ShowRouteScreen(
                                  fromLatLng: _bloc.fromLatLng,
                                  toLatLng: _bloc.toLatLng,
                                );
                              },
                            ));
                          },
                              icons: Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                                size: screenSizeRatio * 0.045,
                              )),
                        )
                      ],
                    );
                  });
            }),
      ),
    );
  }
}
