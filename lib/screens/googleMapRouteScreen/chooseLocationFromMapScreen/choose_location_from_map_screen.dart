import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:main_app_demo/commons/common_functions.dart';

import '../../../commons/my_colors.dart';
import '../../googleMapScreen/mapScreen/LocationSuggetionDl.dart';
import 'choose_location_from_map_screen_bloc.dart';

class ChooseLocationFromMapScreen extends StatefulWidget {
  final bool isFromLocation;
  const ChooseLocationFromMapScreen({super.key, required this.isFromLocation});

  @override
  State<ChooseLocationFromMapScreen> createState() => _ChooseLocationFromMapScreenState();
}

class _ChooseLocationFromMapScreenState extends State<ChooseLocationFromMapScreen> {
  ChooseLocationFromMapScreenBloc _bloc = ChooseLocationFromMapScreenBloc();
  List<Predictions>? searchSuggestions = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Select Location From Map"),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Stack(
            children: [
              GoogleMap(
                onMapCreated: _bloc.onMapCreated,
                onCameraIdle: () => _bloc.getLocationOnCameraPosition(context),
                initialCameraPosition: CameraPosition(target: _bloc.currentPosition, zoom: 14),
                zoomControlsEnabled: false,
              ),
              Center(
                child: Image.asset(
                  "assets/images/basic_location_pin_flat_vector.jpg",
                  height: screenSizeRatio * 0.07,
                ),
              ),
              StreamBuilder<List<Predictions>>(
                  stream: _bloc.suggetionListController,
                  builder: (context, snapshot) {
                    return StreamBuilder<bool>(
                        stream: _bloc.showSuggestionsController,
                        builder: (context, showSuggetionCheckSnapshot) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
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
                                        await _bloc.findAddress(latlang: await _bloc.getLocationOnCameraPosition(context));
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
                                if (showSuggetionCheckSnapshot.data == true)
                                  Container(
                                    height: 200, // Set appropriate height
                                    margin: const EdgeInsets.only(top: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(color: Colors.grey.shade300, blurRadius: 5, offset: Offset(0, 3)),
                                      ],
                                    ),
                                    child: ListView.builder(
                                      itemCount: searchSuggestions?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(searchSuggestions?[index].description ?? " No Data Found"),
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
                              ],
                            ),
                          );
                        });
                  }),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSizeRatio * 0.03, vertical: screenSizeRatio * 0.04),
            child: darkBlueCommonButton("Confirm Location", onPressed: () {
              _bloc.confirmLocation(widget.isFromLocation);
              Navigator.pop(context);
            },
                icons: Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: screenSizeRatio * 0.045,
                )),
          )
        ],
      ),
      // bottomSheet: StreamBuilder<List<Placemark>>(
      //   stream: _bloc.addressController,
      //   builder: (context, location) {
      //     return Positioned(
      //       bottom: 0,
      //       left: 0,
      //       right: 0,
      //       child: Container(
      //         alignment: Alignment.center,
      //         decoration: BoxDecoration(color: MyColors.darkBlue, borderRadius: BorderRadiusDirectional.circular(20)),
      //         width: double.maxFinite,
      //         height: screenSizeRatio * 0.20,
      //         child: Column(
      //           children: [
      //             Padding(
      //               padding: const EdgeInsets.symmetric(vertical: 15),
      //               child: Text(
      //                 "|| Address ||",
      //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
      //               ),
      //             ),
      //             Padding(
      //               padding: EdgeInsets.only(left: screenSizeRatio * 0.04, right: screenSizeRatio * 0.04),
      //               child: Text(
      //                 maxLines: 3,
      //                 "${location.data?[0].street ?? ""}, ${location.data?[0].thoroughfare ?? ""}, ${location.data?[0].subLocality ?? ""}, ${location.data?[0].locality ?? ""}, ${location.data?[0].administrativeArea ?? ""}, ${location.data?[0].country ?? ""}",
      //                 style: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 15,
      //                   fontWeight: FontWeight.bold,
      //                   overflow: TextOverflow.ellipsis,
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: screenSizeRatio * 0.13),
        child: FloatingActionButton(
          onPressed: () async {
            await _bloc.getUserCurrentLocation();
          },
          child: const Icon(
            Icons.my_location,
            color: Colors.white,
          ),
          backgroundColor: MyColors.darkBlue,
          elevation: 10,
        ),
      ),
    );
  }
}
