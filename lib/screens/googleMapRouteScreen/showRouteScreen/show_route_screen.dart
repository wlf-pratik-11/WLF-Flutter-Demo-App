import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:main_app_demo/commons/common_functions.dart';
import 'package:main_app_demo/screens/googleMapRouteScreen/showRouteScreen/show_route_screen_bloc.dart';

class ShowRouteScreen extends StatefulWidget {
  final LatLng fromLatLng;
  final LatLng toLatLng;
  const ShowRouteScreen({super.key, required this.fromLatLng, required this.toLatLng});

  @override
  State<ShowRouteScreen> createState() => _ShowRouteScreenState();
}

class _ShowRouteScreenState extends State<ShowRouteScreen> {
  ShowRouteScreenBloc _bloc = ShowRouteScreenBloc();
  late GoogleMapController newGoogleMapController;
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Your Route"),
      body: StreamBuilder<Set<Marker>>(
        stream: _bloc.markerController,
        builder: (context, markerSnapshot) {
          return StreamBuilder<Set<Polyline>>(
              stream: _bloc.polylinesController,
              builder: (context, polylineSnapshot) {
                return GoogleMap(
                    initialCameraPosition: _bloc.userCurrentLocation ?? CameraPosition(target: LatLng(25.02555, 59.5555)),
                    myLocationButtonEnabled: true,
                    polylines: polylineSnapshot.data ?? {},
                    markers: markerSnapshot.data ?? {},
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      newGoogleMapController = controller;
                      _controllerGoogleMap.complete(controller);
                      _bloc.getPolylines(formLatLng: widget.fromLatLng, toLatLng: widget.toLatLng);
                    });
              });
        },
      ),
    );
  }
}
