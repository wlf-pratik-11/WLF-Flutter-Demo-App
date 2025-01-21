import 'package:flutter/material.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/screens/googleMapScreen/mapScreen/google_map_screen.dart';
import 'package:main_app_demo/screens/googleMapScreen/savedLocationScreen/saved_location_screen_bloc.dart';

import '../../../commons/my_colors.dart';
import '../mapScreen/LocationSuggetionDl.dart';

class SavedLocationScreen extends StatefulWidget {
  const SavedLocationScreen({super.key});

  @override
  State<SavedLocationScreen> createState() => _SavedLocationScreenState();
}

class _SavedLocationScreenState extends State<SavedLocationScreen> {
  SavedLocationScreenBloc _bloc = SavedLocationScreenBloc();
  List<Predictions>? searchSuggestions = [];

  @override
  Widget build(BuildContext context) {
    _bloc.getConfirmLocation();
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: commonAppBar("Select Location"),
        body: StreamBuilder<List<Predictions>>(
          stream: _bloc.suggetionListController,
          builder: (context, snapshot) {
            return StreamBuilder<bool>(
                stream: _bloc.showSuggestionsController,
                builder: (context, showSuggetionCheckSnapshot) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              "Your Location",
                              style: TextStyle(
                                  color: MyColors.darkBlue, fontSize: screenSizeRatio * 0.03, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: screenSizeRatio * 0.03, horizontal: screenSizeRatio * 0.04),
                          child: StreamBuilder<String>(
                              stream: _bloc.yourLocationController,
                              builder: (context, snapshot) {
                                return Text(
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  "${snapshot.data}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: descriptionFontsize,
                                  ),
                                );
                              }),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.03, vertical: screenSizeRatio * 0.02),
                          child: TextFormField(
                            onChanged: (value) {
                              _bloc.onChangedData();
                              searchSuggestions = value.isEmpty ? [] : snapshot.data;
                              value.isEmpty
                                  ? _bloc.showSuggestionsController.sink.add(false)
                                  : _bloc.showSuggestionsController.sink.add(true);
                            },
                            keyboardType: TextInputType.streetAddress,
                            controller: _bloc.searchLocation,
                            decoration: InputDecoration(
                              labelText: "Search Location",
                              labelStyle: TextStyle(color: MyColors.darkBlue, fontWeight: FontWeight.bold),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              filled: true,
                              fillColor: Colors.white,
                              prefixIconConstraints: BoxConstraints(maxHeight: screenSizeRatio * 0.05),
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.025),
                                child: Image.asset(
                                  "assets/images/googleMapIcon.png",
                                ),
                              ),
                              suffixIcon: InkWell(
                                onTap: () async {
                                  await _bloc.findAddress();
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
                        if (showSuggetionCheckSnapshot.data == true)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.03),
                            child: Container(
                              height: 305, // Set appropriate height
                              margin: const EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(color: Colors.grey.shade300, blurRadius: 5, offset: Offset(0, 3)),
                                ],
                              ),
                              child: ListView.builder(
                                itemCount: searchSuggestions?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(
                                      searchSuggestions?[index].description ?? " No Data Found",
                                      maxLines: 2,
                                    ),
                                    onTap: () async {
                                      _bloc.searchLocation.text = searchSuggestions?[index].description ?? "";
                                      await _bloc.getLatLonFromPlaceID(searchSuggestions?[index].placeId ?? "");
                                      await _bloc.findAddress();
                                      _bloc.showSuggestionsController.sink.add(false);
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.03, vertical: screenSizeRatio * 0.01),
                          child: InkWell(
                            onTap: () {
                              _bloc.getUserCurrentLocation();
                            },
                            child: ListTile(
                              trailing: Icon(
                                Icons.navigate_next,
                                color: MyColors.darkBlue,
                                size: screenSizeRatio * 0.05,
                              ),
                              tileColor: MyColors.darkBlue.withOpacity(0.05),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(10)),
                              leading: Icon(
                                Icons.my_location_outlined,
                                color: MyColors.darkBlue,
                                size: screenSizeRatio * 0.04,
                              ),
                              title: Text(
                                "Get Your Location",
                                style: TextStyle(
                                    color: MyColors.darkBlue, fontSize: screenSizeRatio * 0.03, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.03, vertical: screenSizeRatio * 0.01),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return GoogleMapScreen();
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
                                  color: MyColors.darkBlue, fontSize: screenSizeRatio * 0.03, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.03, vertical: screenSizeRatio * 0.05),
                          child: darkBlueCommonButton("Confirm Location",
                              onPressed: () => _bloc.confirmLocation(),
                              icons: Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                                size: screenSizeRatio * 0.045,
                              )),
                        )
                      ],
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
