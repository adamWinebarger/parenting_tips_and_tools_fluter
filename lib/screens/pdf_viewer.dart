

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewer extends StatefulWidget {
  const PDFViewer({super.key, required this.filePath});

  final String filePath;

  @override
  State<StatefulWidget> createState() =>_PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  final Completer<PDFViewController> _controller = Completer<PDFViewController>();
  // int? pages = 0;
  // int? currentPage = 0;
  // bool isReady = false;
  // String errorMessage = '';
  bool _pdfReady = false;
  int? _pages = 0;
  PDFViewController? _pdfViewController;

  @override
  Widget build(BuildContext context) {
    print(widget.filePath);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Viewer"),
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: widget.filePath,
            autoSpacing: false,
            enableSwipe: true,
            //swipeHorizontal: true,
            pageFling: false,
            backgroundColor: Colors.deepPurple,
            onRender: (pages) {
              setState(() {
                _pages = pages;
                _pdfReady = true;
              });
            },
            onError: (e) {
              print("error: $e");
              //Let's have some error handling go in here at some point
            },
            onViewCreated: (PDFViewController pvc) {
              _pdfViewController = pvc;
            },

            onPageChanged: (page, total) {
              setState(() {

              });
            },


          ),
        ],
      )
    );
  }

}