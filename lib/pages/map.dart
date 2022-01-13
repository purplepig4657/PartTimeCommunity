import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  const Map({Key? key,
    required this.startReview}) : super(key: key);

  final void Function() startReview;

  @override
  State<Map> createState() => MapState();
}

class MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markers = [];
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(36.360660, 127.344645),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _markers.add(Marker(
        markerId: const MarkerId("1"),
        draggable: true,
        onTap: () {
          print("asfd");
          widget.startReview();
        },
        position: LatLng(36.360660, 127.344595)));
  }

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(36.360660, 127.344645),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 150,
        child: GoogleMap(
        mapType: MapType.normal,
        markers: Set.from(_markers),
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}