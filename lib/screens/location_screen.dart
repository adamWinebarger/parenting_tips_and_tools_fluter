

import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Location"),),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        child: Column(
          children: [
            Text("Location Screen")
          ],
        ),
      ),
    );
  }

}