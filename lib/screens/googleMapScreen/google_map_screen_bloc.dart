import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class GoogleMapScreenBloc {
  late GoogleMapController mapController;

  TextEditingController searchLocation = TextEditingController();

  LatLng currentPosition = const LatLng(56.324293441187315, 38.13961947281509);

  final addressController = BehaviorSubject<List<Placemark>>();

  GoogleMapScreenBloc() {
    getUserCurrentLocation();
  }

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

  Future<void> getLocationOnCameraPosition(BuildContext context) async {
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
    addressController.sink.add(location);
  }

  Future<void> findAddress() async {
    try {
      List<Location> locations = await locationFromAddress(searchLocation.text);
      double latitude = locations.first.latitude;
      double longitude = locations.first.latitude;
      currentPosition = LatLng(latitude, longitude);
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: currentPosition,
            zoom: 16.0,
          ),
        ),
      );
      List<Placemark> location = await placemarkFromCoordinates(latitude, longitude);
      addressController.sink.add(location);
      print("findAddress Latitude Longitude: $latitude :: $longitude");
    } catch (e) {
      print("Error in findAddress: $e");
    }
  }
}
