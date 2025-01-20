import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'LocationDetailOfPlaceIdDl.dart';
import 'LocationSuggetionDl.dart';

class GoogleMapScreenBloc {
  GoogleMapScreenBloc() {
    getUserCurrentLocation();
  }

  late GoogleMapController mapController;

  TextEditingController searchLocation = TextEditingController();

  var uuid = new Uuid();
  String? _sessionToken;
  String key = "AIzaSyBGJ8mEq1C8Kn4mWY-ds6jDfsr7O8-JNGk";

  LatLng currentPosition = const LatLng(56.324293441187315, 38.13961947281509);

  final addressController = BehaviorSubject<List<Placemark>>();
  final suggetionListController = BehaviorSubject<List<Predictions>>();
  final showSuggestionsController = BehaviorSubject<bool>.seeded(false);

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> getUserCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentPosition = LatLng(position.latitude, position.longitude);
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: currentPosition,
      zoom: 16.0,
    )));
  }

  Future<LatLng> getLocationOnCameraPosition(BuildContext context) async {
    final screenWidth = MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio;
    final screenHeight = MediaQuery.of(context).size.height * MediaQuery.of(context).devicePixelRatio;

    final middleX = screenWidth / 2;
    final middleY = screenHeight / 2;

    final screenCoordinate = ScreenCoordinate(
      x: middleX.round(),
      y: middleY.round(),
    );
    final middlePoint = await mapController.getLatLng(screenCoordinate);
    List<Placemark> location = await placemarkFromCoordinates(middlePoint.latitude, middlePoint.longitude);
    searchLocation.text =
        "${location[0].street},${location[0].thoroughfare}, ${location[0].subLocality}, ${location[0].locality}, ${location[0].administrativeArea}, ${location[0].country}";
    addressController.sink.add(location);
    return LatLng(middlePoint.latitude, middlePoint.longitude);
  }

  Future<void> findAddress({LatLng? latlang}) async {
    try {
      currentPosition = latlang ?? currentPosition;
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: currentPosition,
            zoom: 16.0,
          ),
        ),
      );
      List<Placemark> location = await placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude);
      addressController.sink.add(location);
      print("findAddress Latitude Longitude: ${currentPosition.latitude} :: ${currentPosition.longitude}");
    } catch (e) {
      print("Error in findAddress: $e");
    }
  }

  onChangedData() {
    if (_sessionToken == null) {
      _sessionToken = uuid.v4();
    }
    getSuggetions();
  }

  Future<void> getSuggetions() async {
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=${searchLocation.text}&key=$key&sessiontoken=$_sessionToken';
    var responce = await Dio().get(request);
    var desiredRes = LocationSuggetionDl.fromJson(responce.data);
    List<Predictions> lstLocations = desiredRes.predictions ?? [];
    suggetionListController.sink.add(lstLocations);
  }

  showSuggetionCheack() {
    showSuggestionsController.sink.add(!showSuggestionsController.value);
  }

  Future<void> getLatLonFromPlaceID(String placeID) async {
    String baseURL = 'https://maps.googleapis.com/maps/api/place/details/json';
    String request = '$baseURL?input=${searchLocation.text}&placeid=$placeID&key=$key&sessiontoken=$_sessionToken';
    var responce = await Dio().get(request);
    var locationDetails = LocationDetailOfPlaceIdDl.fromJson(responce.data);
    Geometry? geometry = locationDetails.result?.geometry;
    currentPosition =
        new LatLng(geometry?.location?.lat ?? currentPosition.latitude, geometry?.location?.lng ?? currentPosition.longitude);
  }

  void confirmLocation() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("yourLocation", "${searchLocation.text}");
  }
}
