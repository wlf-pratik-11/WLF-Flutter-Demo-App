import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class ShowRouteScreenBloc {
  final polylinesController = BehaviorSubject<Set<Polyline>>();
  final markerController = BehaviorSubject<Set<Marker>>();

  final Set<Marker> markersSet = {};
  final Set<Polyline> polylineSet = {};
  List<LatLng> LatLenList = [];
  late Position currentPosition;
  CameraPosition? userCurrentLocation;
  PolylinePoints polylinePoints = PolylinePoints();

  Future<void> userCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    userCurrentLocation = CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 16);
  }

  void addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(markerId: markerId, icon: descriptor, position: position);
    markersSet.add(marker);
  }

  void addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      color: Colors.green,
      width: 8,
    );
    polylineSet.add(polyline);
  }

  getPolylines({required LatLng formLatLng, required LatLng toLatLng}) async {
    print("From lat nan::::::::::${formLatLng}:::::::::::::${toLatLng}");
    await userCurrentPosition();
    LatLenList.add(formLatLng);
    LatLenList.add(toLatLng);

    addPolyLine(LatLenList);

    addMarker(formLatLng, "Origin", BitmapDescriptor.defaultMarker);
    addMarker(toLatLng, "Destination", BitmapDescriptor.defaultMarker);

    polylinesController.sink.add(polylineSet);
    markerController.sink.add(markersSet);
  }
}
