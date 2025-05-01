import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationScreen extends StatefulWidget {
  @override
  State<LocationScreen> createState() => _LocationScreenState();

}

class _LocationScreenState extends State<LocationScreen> {
  //LocationScreen({super.key});

  //final _officeCoords = const LatLng(43.0617955, -86.228449);
  final _officeCoords = Position(-86.225885, 43.0618141);
  final ACCESS_TOKEN = "pk.eyJ1IjoiYWRhbS13aW5lYjkiLCJhIjoiY202NDNwcTQ2MTcyejJrb2hmY2NubW15ZCJ9.fKrwXx72mgGJ7MRNBDUejw";


  bool _hasNavigationPermission = false;

  Future<void> _checkNavigationPermissions() async {
    final status = await Permission.location.status;
    if (status.isGranted) {
      setState(() {
        _hasNavigationPermission = true;
      });
    } else {
      await _requestPermission();
    }
  }

  Future<void> _requestPermission() async {
    final status = await Permission.location.request();

    if (status.isGranted) {
      setState(() {
        _hasNavigationPermission = true;
      });
    } else {
      setState(() {
        _hasNavigationPermission = false;
      });
    }

    print(status);

    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void _openNavigationApp() async {

    final googleMapsURL = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=509+franklin+ave+grand+haven+mi+49417');

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
    WidgetsFlutterBinding.ensureInitialized();
    MapboxOptions.setAccessToken(ACCESS_TOKEN);
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _checkNavigationPermissions();
    // });
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
              _mapWidget(),
              SizedBox(height: 10),
              TextButton(
                onPressed: _openNavigationApp,
                child: const Text(
                  "509 Franklin Ave, Grand Haven, MI, 49456 (tap here to open in navigator)",
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

  Widget _mapWidget() {
    return Expanded(
        child: GestureDetector(
          //onDoubleTap: _openNavigationApp,
          onLongPress: _openNavigationApp,

          child: MapWidget(
            cameraOptions: CameraOptions(
              center: Point(coordinates: _officeCoords),
              zoom: 13,
              bearing: 0,
              pitch: 0
            ),
            onMapCreated: (MapboxMap mapboxMap) async {
              //Create our point annotation manager
              PointAnnotationManager? pointAnnotationManager =
                await mapboxMap.annotations.createPointAnnotationManager();

              final bytes = await rootBundle.load('assets/images/pin_drop_location.png');
              final imageData = bytes.buffer.asUint8List();

              //Add a point annotation (marker)
              pointAnnotationManager.create(PointAnnotationOptions(
                geometry: Point(coordinates: _officeCoords),
                iconSize: 0.25,
                //iconImage: "marker-15"
                image: imageData
              ));

            },
          )
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