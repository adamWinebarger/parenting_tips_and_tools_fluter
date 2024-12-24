import 'dart:io';

import 'package:dr_als_parenting_tips_and_tools_flutter/screens/pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum ListViewSelection {
  tipSheet,
  adhdTipSheet,
  goodWebsites
}

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({super.key, required this.listViewSelection});

  final ListViewSelection listViewSelection;

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();

}

class _ListViewScreenState extends State<ListViewScreen> {

  List<_ListItem> _selectedList = [];

  Future<List<_ListItem>> _generateWebsiteList() async {
    List<_ListItem> list = [];

    Map<String, String> websiteMap = {
      "https://www.umass.edu/psc/assessment" : "ADHD Assessment Center",
      "https://adaa.org/living-with-anxiety/children" : "Anxiety & Depression Association of America",
      "https://www.helpguide.org/articles/parenting-family/step-parenting-blended-families.htm" : "Blended Family and Step Parenting Tips",
      "https://www.stopbullying.gov" : "Bullying: What to do",
      "https://chadd.org" : "CHADD -- National Resource on ADHD",
      "https://www.parentbooks.ca/Depression_Resources_for_Kids_&_Teens.html" : "Depression Resources for Kids & Teens",
      "https://www.nimh.nih.gov/health/publications/bipolar-disorder-in-children-and-teens/index.shtml" : "National Institute",
      "https://suicidepreventionlifeline.org/help-yourself/youth" : "National Teen Suicide Prevention Lifeline",
      "https://www.parentingscience.com/parenting-stress-evidence-based-tips.html" : "Parenting Stress: 10 evidence-based tips for making life better",
      "https://www.thepathway2success.com/free-social-emotional-learning-resources" : "Pathway2Success-list of social skills resources for kids who struggle with friendships",
      "https://www.gottman.com/product/the-seven-principles-for-making-marriage-work" : "The Secen Principles for Making Marriage Work",
      "https://www.samhsa.gov/find-help/national-helpline" : "Substance Abuse and Mental Health Service Administration National Helpline, 1-800-662-HEPL(4357), (BIPOLAR DISORDER)"
    };

    for (final website in websiteMap.keys) {
      list.add(_ListItem(
              () async {
            if (await canLaunchUrl(Uri.parse(website))) {
              await launchUrl(Uri.parse(website));
            }
          },
          websiteMap[website]!,
          'assets/images/web_browser_button.png')); //may end up changing this but this is just a placeholder for now
    }
    return list;
  }

  List<_ListItem> _generatePDFList(ListViewSelection selection) {
    List<_ListItem> list = [];

    switch (selection) {
      case ListViewSelection.tipSheet:
        const String dir = 'assets/pdfs/ParentingTipsPDFs/';
        Map<String, String> pdfMap = {
          "Stress Management for Parents" : "StressManagement.pdf",
          "The Keys to Healthy Discipline" : "KeysToHealthyDiscipline.pdf",
          "Barriers to Discipline" : "Barriers2Discipline.pdf",
          "Making Clear Requests - 8 Steps to Slowing Kids Down" : "MakingClearRequests.pdf",
          "Clear Requests Explained" : "ClearRequestsExplained.pdf",
          "Timeout Step-by-Step Guide" : "TimeoutStepByStep.pdf",
          "Timeout - Some Facts & Myths" : "TimeoutFactsAndMyths.pdf",
          "Point Charts Explained" : "PointsChart.pdf",
          "Point Chart Examples" : "appendix2.pdf"
        };

        for (final title in pdfMap.keys) {
          list.add(_ListItem(() {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PDFViewer(filePath: dir + pdfMap[title]!)));
          }, title, 'assets/images/pdficon.png'));
        }
        break;
      case ListViewSelection.adhdTipSheet:
        const String dir = 'assets/pdfs/ADHDTipsPDFs/';
        Map<String, String> pdfMap = {
          "ADHD Explained" : "ADHDexplained.pdf",
          "ADHD Assessment Components Brief" : "ADHDassessment.pdf",
          "The Keys to Healthy Discipline" : "Keys2HealthyDiscipline.pdf",
          "21 Ways to Help Kids With ADD/ADHD" : "21WaysToHelpKidsWithADD.pdf",
          "Barriers to Discipline" : "Barriers2Discipline.pdf",
          "Stress Management for Parents" : "StressManagement4Parents.pdf",
          "Making Clear Requests - 8 Steps to Slowing Kids Down" : "MakingClearRequests.pdf",
          "Clear Requests Explained" : "ClearRequestsExplained.pdf",
          "Timeout Step-by-Step Guide" : "TimeoutStepByStep.pdf",
          "Timeout - Some Facts & Myths" : "TimeoutFactsAndMyths.pdf",
          "Point Charts Explained" : "PointChart.pdf",
          "Point Chart Examples" : "appendix2.pdf"
        };

        for (final title in pdfMap.keys) {
          list.add(_ListItem(() {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PDFViewer(filePath: dir + pdfMap[title]!)));
          }, title, 'assets/images/pdficon.png'));
        }
        break;
      default:
        break;
    }

    return list;
  }


  @override
  void initState() {
    super.initState();

    // generateList(widget.listViewSelection).then((value) => setState(() {
    //   _selectedList = value;
    // }));

    if (widget.listViewSelection == ListViewSelection.goodWebsites) {
      _generateWebsiteList().then((value) => setState(() {
        _selectedList = value;
      }));
    } else {
      setState(() {
        _selectedList = _generatePDFList(widget.listViewSelection);
      });
    }

    print(_selectedList.length);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.listViewSelection == ListViewSelection.tipSheet ? "Tip Sheets" : widget.listViewSelection == ListViewSelection.adhdTipSheet ? "ADD/ADHD Tips" : "Good Websites"),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.separated(
        itemCount: _selectedList.length,
        itemBuilder: (context, index) {
          final item = _selectedList[index];
          return Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: ListTile(
              title: Text(
                item.labelText,
                style: const TextStyle(fontSize: 16, color: Colors.white),
                softWrap: true,
                maxLines: 3,
              ),
              leading: Image.asset(item.imagePath),
              onTap: () {
                item.selectionFunction();
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey,
            thickness: 1,
            height: 1,
          );
        },
      )
    );
  }

}

//The idea behind this private class is essentially to simplify what needs to be
//in each list item. So we'll make a list of list items and for the list view, we'll
//pass in a specified list depending on which value from the enum is passed as an input parameter
class _ListItem {
  _ListItem(this.selectionFunction, this.labelText, this.imagePath);

  final Function selectionFunction;
  final String labelText;
  final String imagePath;
}