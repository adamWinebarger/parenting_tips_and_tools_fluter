

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';


class PDFViewer2 extends StatefulWidget {
  const PDFViewer2({super.key, required this.filePath});

  final String filePath;

  @override
  State<StatefulWidget> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer2> {

  late PdfControllerPinch _pdfControllerPinch;
  int _totalPages = 0;
  int _currentPage = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //print(widget.filePath);
    _pdfControllerPinch = PdfControllerPinch(document: PdfDocument.openAsset(widget.filePath));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PDF Viewer",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Color(0xfffef7ff),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Page $_currentPage of $_totalPages",
              style: TextStyle(
                color: Colors.grey[800]
              ),
            ),
            IconButton(
              onPressed: () {
                _pdfControllerPinch.previousPage(duration: Duration(milliseconds: 660), curve: Curves.easeInCubic);
              },
              icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back)
            ),
            IconButton(
              onPressed: () {
                _pdfControllerPinch.nextPage(duration: Duration(milliseconds: 660), curve: Curves.easeInCubic);
              },
              icon: Icon(Platform.isIOS ? Icons.arrow_forward_ios : Icons.arrow_forward)
            )
          ],
        ),
        _pdfView()
      ],
    );
  }

  Widget _pdfView() {
    return Expanded(
      child: PdfViewPinch(
        controller: _pdfControllerPinch,
        onDocumentLoaded: (doc) {
          setState(() {
            _totalPages = doc.pagesCount;
          });
        },
        onPageChanged: (page) {
          setState(() {
            _currentPage = page;
          });
        },
      )
    );
  }
}