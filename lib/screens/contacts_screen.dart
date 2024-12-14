import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  final _navAddress = "509 Franklin Ave,\nGrand Haven, MI 49456";
  final _phoneNumber = "(616) 844-4140";
  final _website = "www.attentiondoc.com";

  void _openNavigationApp() async {
    final Uri googleMapsUrl = Uri.parse("https://www.google.com/maps/search/?api=1&query=$_navAddress");
    final Uri appleMapsUrl = Uri.parse("https://maps.apple.com/?q=$_navAddress");

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else if (await canLaunchUrl(appleMapsUrl)) {
      await launchUrl(appleMapsUrl);
    } else {
      throw "Could not launch navigation app";
    }
  }

  void _makePhoneCall() async {
    final Uri phoneURL = Uri.parse(_phoneNumber);

    if (await canLaunchUrl(phoneURL)) {
      await launchUrl(phoneURL);
    } else {
      throw "Could not launch phone call";
    }
  }

  void _go2Website() async {
    final websiteURL = Uri.parse(_website);

    if (await canLaunchUrl(websiteURL)) {
      await launchUrl(websiteURL);
    } else {
      throw "Could not access website";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,

      appBar: AppBar(
        title: const Text("Contact Info"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 30, right: 30, top: 75, bottom: 15),
        child: Center(
          child: Column(
            children: [
              const Text(
                "Contact Information",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text("Dr. Al Winebarger, Ph.D.\n\n"),
              //Alright. So I think the way to do this is to have a row with 2
              //columns in it so we can run things down on each side without them affecting eachother
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Left side Column
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Address:"),
                      InkWell(
                        onTap: _openNavigationApp,
                        child: Text(
                          _navAddress,
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            decorationColor: Colors.blue
                          ),
                        ),
                      ),
                      const SizedBox(height: 50,),
                      Text("Phone"),
                      InkWell(
                        onTap: _makePhoneCall,
                        child: Text(
                          _phoneNumber,
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            decorationColor: Colors.blue
                          ),
                        ),
                      ),
                      SizedBox(height: 50,),
                      Text("Website:"),
                      InkWell(
                        onTap: _go2Website,
                        child: Text(
                          _website,
                          style: TextStyle(
                            color: Colors.blue,
                            decorationColor: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  )),
                  SizedBox(width: 25,),
                  //Right side column
                  const Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Hours:\n"),
                      Text("Mon:\n9:00am-9:00pm\n"),
                      Text("Tues:\n9:00am-9:00pm\n"),
                      Text("Wed:\n9:00am-9:00pm\n"),
                      Text("Thurs:\n9:00am-9:00pm\n"),
                      Text("Fri:\n9:00am-9:00pm\n"),
                      Text("Sat:\nclosed\n"),
                      Text("Sun:\nclosed\n")
                    ],
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}