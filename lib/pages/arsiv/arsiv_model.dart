import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse_university_app/pages/auth/widgets/auth_widgets.dart';
import 'package:cse_university_app/pages/main_page/widgets/drawer.dart';
import 'package:cse_university_app/service/auth_service.dart';
import 'package:cse_university_app/utils/custom_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ArsivModel extends StatefulWidget {
  String collection;
  String title;
  ArsivModel({
    Key? key,
    required this.collection,
    required this.title,
  }) : super(key: key);

  @override
  State<ArsivModel> createState() => _ArsivModelState();
}

class _ArsivModelState extends State<ArsivModel> {
  late String? rol = "";
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final User? user = AuthService().currentUser;
  late CollectionReference userRef;

  final GlobalKey<ScaffoldState> kiy = GlobalKey();
  // ignore: unused_field
  late PdfViewerController _pdfViewerController;
  late CollectionReference siteRef;
  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    getInfo();
  }

  Future<void> getInfo() async {
    var userInfo = await AuthWidgets().getRole(user);
    setState(() {
      rol = userInfo?["rol"] ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference siteRef =
        firebaseFirestore.collection(widget.collection);
    return Scaffold(
      key: kiy,
      drawer: AppDrawer(
        rol: rol ?? "",
      ),
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
            child: Text(
          widget.title,
          style: CustomColors.barStyle,
          maxLines: 1,
        )),
        leading: IconButton(
          onPressed: () {
            /* Navigator.pop(context); */
            kiy.currentState!.openDrawer();
          },
          icon: Icon(
            Icons.menu,
            size: 30,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            height: 800,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: siteRef.snapshots(), //ben neyi dinliycem kardeşim
                    builder:
                        (BuildContext context, AsyncSnapshot asyncSnapshot) {
                      if (asyncSnapshot.hasError) {
                        return const Center(
                          child: Text(
                              "Hata olustu Tekrar Deneyiniz veya Yeniden Giriş Yapınız"),
                        ); //hata olduysa texti bastır
                      } else {
                        if (asyncSnapshot.hasData) {
                          //data gelmişse datayı yoldaysa circularprogress
                          List<DocumentSnapshot> listOfDocumentSnapShot =
                              asyncSnapshot.data.docs;
                          return Flexible(
                            child: ListView.builder(
                              itemCount: listOfDocumentSnapShot
                                  .length, //kullanıcı idleri olduğu kısım
                              itemBuilder: (BuildContext context, int index) {
                                Map<String, dynamic>? data =
                                    listOfDocumentSnapShot[index].data()
                                        as Map<String, dynamic>?;
                                String belgeName = data?["belgeName"] ?? "";
                                String belgeLink = data?["belgeLink"] ?? "";

                                return InkWell(
                                  /* onTap: () {
                           showDialog(
                             useSafeArea: true,
                             context: context, 
                             builder: (context) {
                               return Dialog(
                                 child: SizedBox(
                                   height: 400,
                                   child: Padding(
                                     padding: const EdgeInsets.all(20),
                                     child: ListView(
                                      shrinkWrap: true,
                                       children: [
                                          Center(child: Text("$belgeName",style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                                          const SizedBox(height: 15),
                                         // Center(child: Text("$belgeLink",style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),

                                          Container(
                                            width: double.infinity,
                                            height: 400,
                                            child: SfPdfViewer.network(
                                              canShowScrollStatus: true,
                                              "$belgeLink"
                                              ,maxZoomLevel: 5,
                                              controller: _pdfViewerController,
                                               ),
                                          ),
                                          
                                         
                                          
                                          
                                       ],
                                     ),
                                     ),
                     
                                 ),
                               );
                             },);
                         }, */
                                  child: Card(
                                    child: ListTile(
                                      title: Text(
                                        "$belgeName",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      trailing: IconButton(
                                        onPressed: () async {
                                          launchUrl(Uri.parse(belgeLink),
                                              mode: LaunchMode.platformDefault);
                                          // await listOfDocumentSnapShot[index].reference.delete();
                                        },
                                        icon: Lottie.asset("assets/Adobe.json"),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
