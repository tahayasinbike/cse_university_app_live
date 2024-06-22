import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Iletisim extends StatelessWidget {
  const Iletisim({super.key});

  @override
  Widget build(BuildContext context) {
    void copyNum(String number) async {
      await Clipboard.setData(ClipboardData(text: number));
    }

    String mainTel = "08505223890";
    String mainTel2 = "4443788";
    String num1 = "02124166113";
    String num2 = "02124166170";
    String num3 = "021241661190";
    String istuKep = "istun@hs02.kep.tr";
    String istunInfo = "info@istun.edu.tr";
    final uniLocation = Uri.parse("https://maps.app.goo.gl/ZqBzfdHZTnDejWmAA");
    final wpNumber = Uri.parse("https://wa.me/05530410009");
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "İletişim",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        body: ListView(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sütlüce Kampüsü",
                          style: Theme.of(context).textTheme.displayLarge,
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 200,
                        height: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: OutlinedButton(
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                          side: const WidgetStatePropertyAll(BorderSide(
                              style: BorderStyle.solid,
                              width: 1,
                              color: Colors.white))),
                      onPressed: () async {
                        launchUrl(uniLocation, mode: LaunchMode.inAppWebView);
                      },
                      // ignore: avoid_unnecessary_containers
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        "Sütlüce Mah. İmrahar Cad. No:82",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, bottom: 20),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Text(
                                          "Beyoğlu/İstanbul",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                        const Icon(Icons.location_on_outlined)
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 200,
                        height: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        const Icon(Icons.call),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: OutlinedButton(
                              onLongPress: () {
                                copyNum(mainTel);
                              },
                              onPressed: () async {
                                final Uri phoneCall =
                                    Uri(scheme: 'tel', path: mainTel);
                                await launchUrl(phoneCall);
                              },
                              child: Text(mainTel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        const Icon(Icons.call),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: OutlinedButton(
                              onLongPress: () {
                                copyNum(mainTel2);
                              },
                              onPressed: () async {
                                final Uri phoneCall =
                                    Uri(scheme: 'tel', path: mainTel2);
                                await launchUrl(phoneCall);
                              },
                              child: Text(mainTel2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Ulaşabileceğiniz Diğer Numaralar",
                            style: Theme.of(context).textTheme.displayMedium),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: OutlinedButton(
                              onLongPress: () {
                                copyNum(num1);
                              },
                              onPressed: () async {
                                final Uri phoneCall =
                                    Uri(scheme: 'tel', path: num1);
                                await launchUrl(phoneCall);
                              },
                              child: Text(num1,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: OutlinedButton(
                                onLongPress: () {
                                  copyNum(num2);
                                },
                                onPressed: () async {
                                  final Uri phoneCall =
                                      Uri(scheme: 'tel', path: num2);
                                  await launchUrl(phoneCall);
                                },
                                child: Text(num2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium),
                              ))),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: OutlinedButton(
                          onLongPress: () {
                            copyNum(num3);
                          },
                          onPressed: () async {
                            final Uri phoneCall =
                                Uri(scheme: 'tel', path: num3);
                            await launchUrl(phoneCall);
                          },
                          child: Text(num3,
                              style: Theme.of(context).textTheme.displayMedium),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 30,
                          height: 30,
                          child: Image(image: AssetImage("assets/wp.png")),
                        ),
                        OutlinedButton(
                          onPressed: () async {
                            launchUrl(wpNumber, mode: LaunchMode.inAppWebView);
                          },
                          child: Text("WhatsApp: 0553 041 00 09",
                              style: Theme.of(context).textTheme.displayMedium),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onLongPress: () {
                      copyNum(istuKep);
                    },
                    onPressed: () async {
                      final Uri sendMail = Uri(
                          scheme: 'mailto',
                          path: "istun@hs02.kep.tr",
                          queryParameters: {'subject': 'İstunKepMobil'});
                      await launchUrl(sendMail);
                    },
                    child: const Text("KEP: istun@hs02.kep.tr"),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                        onLongPress: () {
                          copyNum(istunInfo);
                        },
                        onPressed: () async {
                          final Uri sendMail = Uri(
                              scheme: 'mailto',
                              path: "info@istun.edu.tr",
                              queryParameters: {'subject': 'İstunMailMobil'});
                          await launchUrl(sendMail);
                        },
                        child: const Text("info@istun.edu.tr")),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
