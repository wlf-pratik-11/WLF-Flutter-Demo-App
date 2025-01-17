import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/commons/my_colors.dart';
import 'package:main_app_demo/screens/googleMapScreen/google_map_screen_bloc.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final GoogleMapScreenBloc _bloc = GoogleMapScreenBloc();
  List<String> _searchSuggestions = []; // List to hold search suggestions
  bool _showSuggestions = false; // Control visibility of suggestions

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Google Map Screen"),
      body: Stack(
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
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  onChanged: (value) {
                    // Fetch suggestions based on input
                    setState(() {
                      _searchSuggestions = value.isEmpty ? [] : List.generate(5, (index) => "Suggestion $index for $value");
                      _showSuggestions = _searchSuggestions.isNotEmpty;
                    });
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
                if (_showSuggestions)
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
                      itemCount: _searchSuggestions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_searchSuggestions[index]),
                          onTap: () {
                            setState(() {
                              _bloc.searchLocation.text = _searchSuggestions[index];
                              _showSuggestions = false;
                            });
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
          StreamBuilder<List<Placemark>>(
            stream: _bloc.addressController,
            builder: (context, location) {
              return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: MyColors.darkBlue, borderRadius: BorderRadiusDirectional.circular(20)),
                  width: double.maxFinite,
                  height: screenSizeRatio * 0.20,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "|| Address ||",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: screenSizeRatio * 0.04, right: screenSizeRatio * 0.04),
                        child: Text(
                          maxLines: 3,
                          "${location.data?[0].street ?? ""}, ${location.data?[0].thoroughfare ?? ""}, ${location.data?[0].subLocality ?? ""}, ${location.data?[0].locality ?? ""}, ${location.data?[0].administrativeArea ?? ""}, ${location.data?[0].country ?? ""}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100),
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
