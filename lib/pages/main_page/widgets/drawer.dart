import 'package:cse_university_app/custom_gpt/screen/custom_chat_screen.dart';
import 'package:cse_university_app/pages/academic_calendars/acedamic_calendar.dart';
import 'package:cse_university_app/pages/academic_calendars/model.dart';
import 'package:cse_university_app/pages/arsiv/arsiv_model.dart';
import 'package:cse_university_app/pages/duyurular/duyurular.dart';
import 'package:cse_university_app/pages/haberler/haberler.dart';
import 'package:cse_university_app/pages/iletisim/iletisim.dart';
import 'package:cse_university_app/pages/main_page/main_page.dart';
import 'package:cse_university_app/pages/main_page/widgets/list_tile_method.dart';
import 'package:cse_university_app/pages/ois_blackboard/ois_blackboard_giris.dart';

import 'package:cse_university_app/utils/custom_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class AppDrawer extends StatelessWidget {
  final String rol;
  final String version = "0.1.0";
  // ignore: use_key_in_widget_constructors
  const AppDrawer({
    Key? key,
    required this.rol,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 170,
                    child: Image(
                      image: AssetImage("assets/sutluce.jpg"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: SizedBox(
                      width: 100,
                      height: 40,
                      child: Image.asset(
                        "assets/yazisiz.png",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 95),
                    child: ListTile(
                      title: Text('İstanbul Sağlık ve Teknoloji',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                      subtitle: Text('Üniversitesi',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        user.email.toString(),
                        style:
                            TextStyle(color: CustomColors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
              /////////////////

              const SizedBox(
                height: 10,
              ),
              ListTileMethod(
                  context: context,
                  titlee: "Ana Sayfa",
                  sayfa: MainPage(),
                  icon: Icons.home_outlined),
              const SizedBox(
                height: 10,
              ),
              ListTileMethod(
                  context: context,
                  titlee: "Duyurular",
                  icon: Icons.event_rounded,
                  sayfa: const Duyurular()),
              const SizedBox(
                height: 10,
              ),
              ListTileMethod(
                  context: context,
                  titlee: "Haberler",
                  icon: Icons.newspaper_outlined,
                  sayfa: const Haberler()),
              const SizedBox(
                height: 10,
              ),
              ExpansionTile(
                collapsedIconColor:
                    Theme.of(context).iconTheme.color, //kapalıyken
                iconColor: CustomColors.yellow, //açıkken
                leading: Icon(UniconsLine.archive),
                title: Text(
                  "Arşiv",
                  style: TextStyle(color: CustomColors.white),
                ),
                children: [
                  ExpansionTile(
                    title: Center(
                        child: Text("Öğrenci Belgeleri",
                            style: TextStyle(color: CustomColors.white))),
                    children: [
                      ListTileMethod(
                          context: context,
                          titlee: "Formlar",
                          sayfa: ArsivModel(
                              collection: "files", title: "Formlar")),
                      ListTileMethod(
                          context: context,
                          titlee: "Eczacılık Fakültesi",
                          sayfa: ArsivModel(
                              collection: "ecza",
                              title: "Eczacılık Fakültesi")),
                      ListTileMethod(
                          context: context,
                          titlee: "Mühendislik ve Doğa Bilimleri Fakültesi",
                          sayfa: ArsivModel(
                              collection: "engineer",
                              title:
                                  "Mühendislik ve Doğa Bilimleri Fakültesi")),
                      ListTileMethod(
                          context: context,
                          titlee: "Sağlık Bilimleri Fakültesi",
                          sayfa: ArsivModel(
                              collection: "saglikBilimleri",
                              title: "Sağlık Bilimleri Fakültesi")),
                      ListTileMethod(
                          context: context,
                          titlee: "Sağlık Meslek Yüksekokulu",
                          sayfa: ArsivModel(
                              collection: "saglikMeslek",
                              title: "Sağlık Meslek Yüksekokulu")),
                    ],
                  ),
                  rol == "admin"
                      ? ExpansionTile(
                          title: Center(
                              child: Text("İdareci Belgeleri",
                                  style: TextStyle(color: CustomColors.white))),
                          children: [
                            ListTileMethod(
                                context: context,
                                titlee: "İdareci Belgeleri",
                                sayfa: ArsivModel(
                                    collection: "idareci",
                                    title: "İdareci Belgeleri")),
                            ListTileMethod(
                                context: context,
                                titlee: "Sınav Belgeleri",
                                sayfa: ArsivModel(
                                    collection: "idareciSinav",
                                    title: "Sınav Belgeleri")),
                          ],
                        )
                      : SizedBox.shrink(),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ListTileMethod(
                  context: context,
                  titlee: "iletişim",
                  icon: Icons.mail_outline_rounded,
                  sayfa: const Iletisim()),
              const SizedBox(
                height: 10,
              ),
              ListTileMethod(
                  context: context,
                  titlee: "Akademik Takvim",
                  icon: Icons.calendar_month,
                  sayfa: AcademicModel()),
              const SizedBox(
                height: 10,
              ),
              /*  ListTileMethod(
                  context: context,
                  titlee: "Ring Saatleri",
                  icon: Icons.bus_alert_outlined,
                  sayfa: const RingTime()), */
              const SizedBox(
                height: 10,
              ),
              ListTileMethod(
                  context: context,
                  titlee: "Ois & Blackboard Giriş",
                  icon: Icons.account_tree_outlined,
                  sayfa: const OisBlackboard()),
              const SizedBox(
                height: 10,
              ),
              ListTileMethod(
                  context: context,
                  titlee: "Yemekhanem",
                  icon: Icons.restaurant,
                  subTitlee: "Pek Yakında!"),
              const SizedBox(
                height: 10,
              ),

              const SizedBox(
                height: 10,
              ),
              AboutListTile(
                icon: Icon(
                  Icons.info,
                  color: Theme.of(context).iconTheme.color,
                ),
                applicationIcon: const Icon(
                  Icons.code_outlined,
                  color: Colors.black,
                ),
                applicationName: "CSE ISTUN",
                applicationVersion: version,
                applicationLegalese: '© 2024 DeVast',
                aboutBoxChildren: const [
                  //LicensesTextName
                ],
                child: Text(
                  "Hakkımızda",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  height: 70,
                  color: Colors.transparent,
                  child: const Center(
                      child: Image(image: AssetImage("assets/trans.png"))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
