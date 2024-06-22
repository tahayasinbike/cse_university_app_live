import 'package:cse_university_app/pages/ois_blackboard/widgets/beyaz_istun_title.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OisBlackboard extends StatefulWidget {
  const OisBlackboard({super.key});

  @override
  State<OisBlackboard> createState() => _OisBlackboardState();
}

class _OisBlackboardState extends State<OisBlackboard> {
  final oisUrl = Uri.parse("https://ois.istun.edu.tr/auth/login");
  final blackBoardUrl = Uri.parse("https://www.istun.edu.tr/tr/blackboard");
  final istun = Uri.parse("https://www.istun.edu.tr/tr");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppbarIstun(),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 280),
        child: Column(
          children: [
            ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xffCD1818))),
                onPressed: () {
                  launchUrl(istun, mode: LaunchMode.inAppWebView);
                },
                child: Text(
                  "İstun Web",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xffCD1818))),
                onPressed: () {
                  launchUrl(oisUrl, mode: LaunchMode.inAppWebView);
                },
                child: Text(
                  "Ois Giriş",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0xffCD1818))),
                onPressed: () {
                  launchUrl(blackBoardUrl, mode: LaunchMode.inAppWebView);
                },
                child: Text("Blackboard Giriş",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontWeight: FontWeight.bold)))
          ],
        ),
      ),
    );
  }
}
