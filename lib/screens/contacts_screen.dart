import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Column(
            children: [
              Text("Contact Information")
              ],
          ),
        ),
      ),
    );
  }

}