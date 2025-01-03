import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({super.key});

  final _officeCoords = LatLng(43.0617955, -86.228449);

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
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Location"),),
      body: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(vertical: 45, horizontal: 10),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Our Office Location",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25,),
              Expanded(
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
              ),
              SizedBox(height: 10),
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

}