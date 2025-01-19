import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationScreen extends StatefulWidget {
  @override
  State<LocationScreen> createState() => _LocationScreenState();

}

class _LocationScreenState extends State<LocationScreen> {
  //LocationScreen({super.key});

  final _officeCoords = const LatLng(43.0617955, -86.228449);

  bool _hasNavigationPermission = false;

  Future<void> _checkNavigationPermissions() async {
    final status = await Permission.location.status;
    if (status.isGranted) {
      setState(() {
        _hasNavigationPermission = true;
      });
    }
  }

  Future<void> _requestPermission() async {
    final status = await Permission.location.request();
    if (status.isGranted) {
      setState(() {
        _hasNavigationPermission = true;
      });
    }

    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void _openNavigationApp() async {
    final googleMapsURL = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=${_officeCoords.latitude},${_officeCoords.longitude}');

    if (await canLaunchUrl(googleMapsURL)) {
      await launchUrl(googleMapsURL);
    } else {
      throw 'Could not launch ${googleMapsURL.toString()}';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkNavigationPermissions();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Location"),),
      body: Container(
        margin: EdgeInsets.all(25),
        padding: EdgeInsets.symmetric(vertical: 45, horizontal: 10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Our Office Location",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25,),
              //_hasNavigationPermission ? _googleMapsWidget() : _buildErrorWidget(),
              _googleMapsWidget(),
              SizedBox(height: 10),
              TextButton(
                onPressed: _openNavigationApp,
                child: const Text(
                  "509 Franklin Ave.,\nGrand Haven, MI, 49456",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                  ),
                  textAlign: TextAlign.center,
                )
              )
              // GestureDetector(
              //   onDoubleTap: _openNavigationApp,
              //   child: Container(
              //     padding: EdgeInsets.all(15),
              //     child: const Text(
              //       'Double Tap the map to navigate',
              //       style: TextStyle(fontSize: 16, color: Colors.blue),
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              // )

            ],
          ),
        ),
      )
    );
  }

  Widget _googleMapsWidget() {
    return Expanded(
      child: GestureDetector(
        onDoubleTap: _openNavigationApp,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: _officeCoords,
              zoom: 16.0
          ),
          markers: {
            Marker(
                markerId: MarkerId("Dr. Al's Office"),
                position: _officeCoords,
                infoWindow: InfoWindow(title: "Dr. Al's Office")
            ),
          },
          myLocationButtonEnabled: false,
          myLocationEnabled: false,
          zoomControlsEnabled: false, //might come back and change this one
          scrollGesturesEnabled: false,
          tiltGesturesEnabled: false,
          rotateGesturesEnabled: false,
          zoomGesturesEnabled: false,
        ),
      )

    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Location permission is required to show the map.',
            style: TextStyle(
              fontSize: 16
            ),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: _requestPermission,
            child: Text("Want to enable location permissions?", style: TextStyle(fontSize: 16), textAlign: TextAlign.center,)
          )
        ],
      ),
    );
  }

}