import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse_university_app/custom_gpt/screen/custom_chat_screen.dart';
import 'package:cse_university_app/pages/auth/widgets/auth_widgets.dart';
import 'package:cse_university_app/pages/main_page/widgets/carousel.dart';
import 'package:cse_university_app/pages/main_page/widgets/carousel_servis_etkinlik.dart';
import 'package:cse_university_app/pages/main_page/widgets/drawer.dart';
import 'package:cse_university_app/pages/main_page/widgets/sayilar_slider.dart';
import 'package:cse_university_app/pages/main_page/widgets/yazi_header.dart';
import 'package:cse_university_app/pages/ois_blackboard/widgets/beyaz_istun_title.dart';
import 'package:cse_university_app/pages/ring/ring_service.dart';
import 'package:cse_university_app/service/auth_service.dart';
import 'package:cse_university_app/state/state.dart';
import 'package:cse_university_app/widget_tree.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late String? rol = "";
  late String? apiKey = "";
  late String? baseUrl = "";
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late CollectionReference userRef;
  final User? user = AuthService().currentUser;

  @override
  void initState() {
    super.initState();
    getInfo();
    RingService().getSH();
  }

  Future<void> getInfo() async {
    var userInfo = await AuthWidgets().getRole(user);
    /* var apiInfo = await Privacy().getApiKey();
    var baseInfo = await Privacy().getBaseUrl(); */
    setState(() {
      rol = userInfo?["rol"];
      /* apiKey = apiInfo?["apikey1"];
      baseUrl = baseInfo?["baseurl"];
      print(apiKey);
      print(baseUrl); */
      print("main page rol => ${rol}");
    });
  }

  Future<void> signOut() async {
    await AuthService().signOut();
  }

  final StateManage vm = StateManage();
  final GlobalKey<ScaffoldState> myKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    int activeIndex = 0;
    final sayilarInfo = [
      const SayilarSlider(sayi: "6790", subTitle: "Öğrenci"),
      const SayilarSlider(sayi: "7641", subTitle: "Mezun"),
      const SayilarSlider(sayi: "182", subTitle: "Akademisyen"),
      const SayilarSlider(sayi: "6", subTitle: "Enstitü"),
      const SayilarSlider(sayi: "14", subTitle: "Fakülte"),
      const SayilarSlider(sayi: "2", subTitle: "YüksekOkul"),
      const SayilarSlider(sayi: "2", subTitle: "Toplam Kaynak"),
    ];

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        child: Image.asset("assets/chat_logo.png"),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomChatScreen(
                  rol: rol,
                  apiKey: apiKey,
                  baseUrl: baseUrl,
                ),
              ));
        },
      ),
      key: myKey,
      appBar: AppBar(
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 6, offset: Offset(0, 1), spreadRadius: 0.3)
              ]),
              height: 4.0,
            )),
        leading: IconButton(
          onPressed: () {
            myKey.currentState!.openDrawer();
          },
          icon: const Icon(UniconsLine.bars),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppbarIstun(),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ShaderMask(
                shaderCallback: (Rect rect) {
                  return const LinearGradient(colors: <Color>[
                    Colors.white,
                    Colors.yellow,
                    Colors.white,
                    Colors.yellow,
                    Colors.white,
                    Colors.yellow,
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)
                      .createShader(rect);
                },
                child: Text(
                  "CSE",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => WidgetTree()));
            },
            icon: const Icon(UniconsLine.sign_out_alt, color: Colors.cyan),
          ),
        ],
      ),
      drawer: AppDrawer(rol: rol ?? ""),
      body: Column(
        children: [
          const Expanded(
            flex: 6,
            child: CarouselDeneme(),
          ),
          Expanded(flex: 2, child: yaziHeader("Sayılarla İstun", context)),
          Expanded(
              flex: 3,
              child: CarouselSlider.builder(
                itemCount: sayilarInfo.length,
                itemBuilder: (context, index, realIndex) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 7,
                                offset: Offset(0, 3),
                                spreadRadius: 0.3)
                          ],
                          color: Theme.of(context).scaffoldBackgroundColor,
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          )),
                      height: 100,
                      child: Center(
                        child: sayilarInfo[index],
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                    scrollDirection: Axis.vertical,
                    initialPage: 0,
                    onPageChanged: (index, reason) => activeIndex = index,
                    autoPlay: false,
                    //autoPlayAnimationDuration: const Duration(seconds: 1),
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    enlargeCenterPage:
                        true, //büyüyüp küçülerek resimler değişiyor
                    viewportFraction:
                        0.5, //sadece sliderda 1 tane resim gösterir
                    height: 250),
              )),
          Expanded(flex: 2, child: yaziHeader("Etkinlikler", context)),
          const Expanded(
            flex: 6,
            child: ServisEtkinlik(),
          ),
          const Expanded(
              flex: 1,
              child: SizedBox(
                height: 10,
              ))
        ],
      ),
    );
  }
}
