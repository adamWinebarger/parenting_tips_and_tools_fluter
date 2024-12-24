

import 'package:dr_als_parenting_tips_and_tools_flutter/screens/contacts_screen.dart';
import 'package:dr_als_parenting_tips_and_tools_flutter/screens/list_screen.dart';
import 'package:dr_als_parenting_tips_and_tools_flutter/widgets/image_button.dart';
import 'package:dr_als_parenting_tips_and_tools_flutter/k.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum _NavigationScreens {
  Contacts,
  Location,
  ADDTipSheets,
  ParentingTipSheets,
  GoodWebsites,
  Videos
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> {


  void _launchURL() async {
    final docalURL = Uri.parse("https://www.attentiondoc.com");

    if (await canLaunchUrl(docalURL)) {
      //print("MAde it to here");
      await launchUrl(docalURL);
    } else {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Failed to load Dr. Al's Website", style: TextStyle(color: Colors.black,)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Ok", style: TextStyle(color: Colors.black),)
              )
            ],
          );
        }
      );
    }
  }

  void _go2NewScreen(_NavigationScreens whichScreen) {
    switch (whichScreen) {
      case _NavigationScreens.Contacts:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ContactsScreen())
        );
        break;
      case _NavigationScreens.GoodWebsites:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ListViewScreen(listViewSelection: ListViewSelection.goodWebsites)
          )
        );
        break;
      case _NavigationScreens.ADDTipSheets:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ListViewScreen(listViewSelection: ListViewSelection.adhdTipSheet)));
        break;
      case _NavigationScreens.ParentingTipSheets:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ListViewScreen(listViewSelection: ListViewSelection.tipSheet))
        );
        break;
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: const EdgeInsets.only(top: 65, left: 25, right: 25, bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Dr. Al's Parenting Tips & Tools",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 44,
                      fontWeight: FontWeight.bold
                    ),
                  )
              ),
            ),
            //So this will be the first row of buttons
            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: ImageButton(
                    imagePath: websitesButtonPath,
                    label: "Dr. Al's\nWebsite",
                    onPressed: _launchURL
                )),
                Expanded(child: ImageButton(
                  imagePath: contactButtonPath,
                  label: "Contact\n",
                  onPressed: () => _go2NewScreen(_NavigationScreens.Contacts),
                )),
                Expanded(child: ImageButton(
                    imagePath: locationButtonPath,
                    label: "Location\n",
                    onPressed: () {}
                ))
              ],
            )),
            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: ImageButton(
                  imagePath: adhdButtonPath,
                  label: "ADD/ADHD\nTip Sheets",
                  onPressed: () => _go2NewScreen(_NavigationScreens.ADDTipSheets),
                )),
                Expanded(child: ImageButton(
                  imagePath: happyFolderButtonPath,
                  label: "Parenting\nTip Sheets",
                  onPressed: () => _go2NewScreen(_NavigationScreens.ParentingTipSheets),
                )),
                Expanded(child: ImageButton(
                  imagePath: goodWebsitesButton,
                  label: "Good\nWebsites",
                  onPressed: () => _go2NewScreen(_NavigationScreens.GoodWebsites),
                ))
              ],
            )),
            Expanded(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded( child: ImageButton(
                  imagePath: videoButtonPath,
                  label: "Videos",
                  onPressed: () {},
                )),

              ],
            ))

          ],
        ),
    );
  }



}