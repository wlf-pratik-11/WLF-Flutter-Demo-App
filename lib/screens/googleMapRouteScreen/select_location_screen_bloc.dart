import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../googleMapScreen/mapScreen/LocationDetailOfPlaceIdDl.dart';
import '../googleMapScreen/mapScreen/LocationSuggetionDl.dart';

class SelectLocationScreenBloc {
  final suggetionListController = BehaviorSubject<List<Predictions>>();
  final showSuggestionsController = BehaviorSubject<bool>.seeded(false);
  final isFromLocation = BehaviorSubject<bool>.seeded(false);

  TextEditingController fromLocation = TextEditingController();
  TextEditingController toLocation = TextEditingController();
  LatLng? fromLatLng;
  LatLng? toLatLng;

  var uuid = new Uuid();
  String? _sessionToken;
  String key = "AIzaSyBGJ8mEq1C8Kn4mWY-ds6jDfsr7O8-JNGk";
  LatLng currentPosition = const LatLng(56.324293441187315, 38.13961947281509);

  Future<void> getSuggetions() async {
    print("is From Location Value:::::::::::::::::::::::::::::${isFromLocation.value}");
    _sessionToken ??= uuid.v4();
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=${isFromLocation.value == true ? fromLocation.text : toLocation.text}&key=$key&sessiontoken=$_sessionToken';
    var responce = await Dio().get(request);
    var desiredRes = LocationSuggetionDl.fromJson(responce.data);
    List<Predictions> lstLocations = desiredRes.predictions ?? [];
    suggetionListController.sink.add(lstLocations);
  }

  Future<void> getLatLonFromPlaceID(String placeID) async {
    String baseURL = 'https://maps.googleapis.com/maps/api/place/details/json';
    String request =
        '$baseURL?input=${isFromLocation.value == true ? fromLocation.text : toLocation.text}&placeid=$placeID&key=$key&sessiontoken=$_sessionToken';
    var responce = await Dio().get(request);
    var locationDetails = LocationDetailOfPlaceIdDl.fromJson(responce.data);
    Geometry? geometry = locationDetails.result?.geometry;
    currentPosition =
        new LatLng(geometry?.location?.lat ?? currentPosition.latitude, geometry?.location?.lng ?? currentPosition.longitude);
    print("getLatLonFromPlaceID currentPosition::::::${currentPosition}");
    isFromLocation.value == true
        ? (fromLatLng = new LatLng(currentPosition.latitude, currentPosition.longitude))
        : (toLatLng = new LatLng(
            geometry?.location?.lat ?? currentPosition.latitude, geometry?.location?.lng ?? currentPosition.longitude));
    print("getLatLonFromPlaceID:::::::::::${fromLatLng}:::::::::::::::${toLatLng}");
  }

  void getConfirmLocation() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    fromLocation.text = await pref.getString("fromLocation") ?? fromLocation.text;
    toLocation.text = await pref.getString("toLocation") ?? toLocation.text;
  }
}
