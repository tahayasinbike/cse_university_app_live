import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse_university_app/pages/academic_calendars/model.dart';
import 'package:cse_university_app/pages/auth/widgets/auth_widgets.dart';
import 'package:cse_university_app/pages/main_page/widgets/drawer.dart';
import 'package:cse_university_app/pages/ring/ring_service.dart';
import 'package:cse_university_app/service/auth_service.dart';
import 'package:cse_university_app/utils/custom_colors.dart';
import 'package:cse_university_app/widgets/custom_sizedBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RingPage extends StatefulWidget {
  const RingPage({super.key});

  @override
  State<RingPage> createState() => _RingPageState();
}

class _RingPageState extends State<RingPage> {
  final GlobalKey<ScaffoldState> kiy = GlobalKey();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late String? rol = "";
  final User? user = AuthService().currentUser;
  late CollectionReference userRef;
  late List ringListHS = [];
  late List ringListSH = [];
  @override
  void initState() {
    getInfo();
    super.initState();
  }

  Future<void> getInfo() async {
    var userInfo = await AuthWidgets().getRole(user);
    ringListHS = await RingService().getHS();
    ringListSH = await RingService().getSH();
    setState(() {
      rol = userInfo?["rol"] ?? "";
      ringListHS = ringListHS;
      ringListSH = ringListSH;
    });
    //print(ringListHS);
    //print(ringListSH);
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
              "Ring Saatleri",
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
        body: ringListHS.length != 0
            ? ListView.builder(
                itemCount: ringListHS.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> ringMapHS = ringListHS[index];
                  Map<String, dynamic> ringMapSH = ringListSH[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    child: Container(
                      width: double.infinity,
                      height: 70,
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customSizedBoxWidth(5),
                            Text(
                              "HALICIOĞLU \n SÜTLÜCE : ${ringMapHS["HALICIOĞLU-SÜTLÜCE"]}",
                              style: CustomColors.ringStyle,
                            ),
                            customSizedBoxWidth(25),
                            Text(
                              "SÜTLÜCE \n HALICIOĞLU : ${ringMapSH["SÜTLÜCE-HALICIOĞLU"]}",
                              style: CustomColors.ringStyle,
                            ),
                            customSizedBoxWidth(5),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: CustomColors.white,
                          border: Border.all(color: CustomColors.cardColor)),
                    ),
                  );
                },
              )
            : Center(child: CircularProgressIndicator()));
  }
}
