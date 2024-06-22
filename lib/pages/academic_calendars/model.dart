import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse_university_app/pages/academic_calendars/acedamic_calendar.dart';
import 'package:cse_university_app/pages/academic_calendars/widgets/takvim_titlee.dart';
import 'package:cse_university_app/pages/auth/widgets/auth_widgets.dart';
import 'package:cse_university_app/pages/main_page/widgets/drawer.dart';
import 'package:cse_university_app/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AcademicModel extends StatefulWidget {
  const AcademicModel({super.key});

  @override
  State<AcademicModel> createState() => _AcademicModelState();
}

class _AcademicModelState extends State<AcademicModel> {
  final GlobalKey<ScaffoldState> kiy = GlobalKey();
  late String? rol = "";
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final User? user = AuthService().currentUser;
  late CollectionReference userRef;
  @override
  void initState() {
    getInfo();
    super.initState();
  }

  Future<void> getInfo() async {
    var userInfo = await AuthWidgets().getRole(user);
    setState(() {
      rol = userInfo?["rol"] ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: kiy,
      drawer: AppDrawer(
        rol: rol ?? "",
      ),
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
          child: Text(
            "Akademik Takvim",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        toolbarHeight: 70,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 2, offset: Offset(0, 1), spreadRadius: 0.1)
              ]),
              /* color: Colors.red, */
              height: 4.0,
            )),
        leading: IconButton(
          onPressed: () {
            /* Navigator.pop(context); */
            kiy.currentState!.openDrawer();
          },
          icon: const customLeading(),
        ),
      ),
      body: Column(
        children: [
          takvimTitle(context, AcademicCalendar(section: "dentist"),
              "Diş Hekimliği Fakültesi"),
          takvimTitle(context, AcademicCalendar(section: "lisans"),
              "Ön Lisans-Lisans Akademik Takvim"),
          takvimTitle(context, AcademicCalendar(section: "language"),
              "İngilizce Hazırlık Birimi ve Zorunlu Yabancı Dil Dersleri"),
          takvimTitle(context, AcademicCalendar(section: "lisansustu"),
              "Lisansüstü Eğitim Enstitüsü"),
          takvimTitle(
              context, AcademicCalendar(section: "medicine"), "Tıp Fakültesi"),
        ],
      ),
    );
  }
}

class customLeading extends StatelessWidget {
  const customLeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.menu,
      size: 30,
    );
  }
}
