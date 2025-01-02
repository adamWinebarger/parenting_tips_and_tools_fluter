

import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class PDFViewer extends StatefulWidget {
  const PDFViewer({super.key, required this.filePath});

  final String filePath;

  @override
  State<StatefulWidget> createState() =>_PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  final Completer<PDFViewController> _controller = Completer<PDFViewController>();
  String? _localPath;
  bool _isLoading = true;

  Future<void> _loadPDF() async {
    setState(() {
      _isLoading = true;
    });

    try {
      //get temp directory
      final tempDir = await getTemporaryDirectory();

      //const s = "assets/pdfs/example/adhd_tips_pdfs/ADDADHDTools4Teachers.pdf";

      //define destination file path
      final filePath = "${tempDir.path}/${widget.filePath.split('/').last}";

      //let's make sure things are exactly right here
      //print(filePath);

      //load the asset and write it to the temp directory
      //print("Fetching byte data");
      final byteData = await DefaultAssetBundle.of(context).load(widget.filePath);
      final file = File(filePath);
      //print("Initiating buffer");
      await file.writeAsBytes(byteData.buffer.asUint8List());
      //print("Made it to here");

      //update state to relect the loaded path
      setState(() {
        _localPath = filePath;
        _isLoading = false;
      });

    } catch (e) {
      print("Error loading PDF: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPDF();
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.filePath);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Viewer"),
      ),
      body: _isLoading
        ? const Center(child: CircularProgressIndicator(),)
        : _localPath == null
          ? const Center(child: Text('Error Loading PDF'),)
          : Padding(
              padding: EdgeInsets.only(top: 45),
            child: PDFView(
              filePath: _localPath,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: true,
              pageFling: true,
              //backgroundColor: Colors.black,
              onRender: (pages) {
                print("Rendered $pages pages");
              },
              onError: (error) {
                print("PDFView Error: $error");
              },
              onPageError: (page, error) {
                print("Error on page $page: $error");
              },
            ),
        )
    );
  }

}