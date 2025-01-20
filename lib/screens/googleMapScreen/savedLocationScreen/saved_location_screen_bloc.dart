import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../mapScreen/LocationDetailOfPlaceIdDl.dart';
import '../mapScreen/LocationSuggetionDl.dart';

class SavedLocationScreenBloc {
  late GoogleMapController mapController;

  TextEditingController searchLocation = TextEditingController();

  var uuid = new Uuid();
  String? _sessionToken;
  String key = "AIzaSyBGJ8mEq1C8Kn4mWY-ds6jDfsr7O8-JNGk";

  LatLng currentPosition = const LatLng(56.324293441187315, 38.13961947281509);

  final addressController = BehaviorSubject<List<Placemark>>();
  final suggetionListController = BehaviorSubject<List<Predictions>>();
  final showSuggestionsController = BehaviorSubject<bool>.seeded(false);
  final yourLocationController = BehaviorSubject<String>();

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
    yourLocationController.sink.add(searchLocation.text);
  }
}
