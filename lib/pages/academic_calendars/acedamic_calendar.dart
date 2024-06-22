import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse_university_app/pages/auth/widgets/auth_widgets.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AcademicCalendar extends StatefulWidget {
  String? section;
  AcademicCalendar({
    Key? key,
    required this.section,
  }) : super(key: key);

  @override
  State<AcademicCalendar> createState() => _AcademicCalendarState();
}

class _AcademicCalendarState extends State<AcademicCalendar> {
  late String? link = "";
  final GlobalKey<ScaffoldState> myKey = GlobalKey();
  late PdfViewerController _pdfViewerController;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
    guncelle();
  }

  Future guncelle() async {
    var calendarInfo = await AuthWidgets().getCalendars(widget.section!);
    setState(() {
      link = calendarInfo?["link"];
      print(link);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: myKey,
        appBar: AppBar(
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  _pdfViewerController.zoomLevel = 3;
                },
                icon: const Icon(Icons.zoom_in))
          ],
          title: FittedBox(
            child: Text(
              "Akademik Takvim",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
        ),
        body: widget.section != null && link != null && link!.isNotEmpty
            ? SfPdfViewer.network(
                "${link}"
                // TakvimList().dis,
                ,
                maxZoomLevel: 5,
                controller: _pdfViewerController,
              )
            : const Center(child: CircularProgressIndicator()));
  }
}
