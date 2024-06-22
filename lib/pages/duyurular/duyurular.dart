import 'package:cse_university_app/pages/auth/widgets/auth_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Duyurular extends StatefulWidget {
  const Duyurular({Key? key}) : super(key: key);

  @override
  State<Duyurular> createState() => _DuyurularState();
}

class _DuyurularState extends State<Duyurular> {
  List<Map<String, dynamic>>? anons = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getAnnounces();
  }

  Future<void> getAnnounces() async {
    await initializeDateFormatting("tr_TR");
    anons = await AuthWidgets().getAnnounces();
    setState(() {
      isLoading = false;
    });
    print(anons);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Duyurular",
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : anons != null && anons!.isNotEmpty
                  ? ListView.builder(
                      itemCount: anons?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: IntrinsicHeight(
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                      useSafeArea: true,
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                  maxHeight: 800),
                                              child: SingleChildScrollView(
                                                physics:
                                                    AlwaysScrollableScrollPhysics(),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          anons?[index]["image"] !=
                                                                      null &&
                                                                  anons![index][
                                                                          "image"]!
                                                                      .isNotEmpty
                                                              ? InkWell(
                                                                  onTap: () {
                                                                    showDialog(
                                                                      useSafeArea:
                                                                          true,
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                InteractiveViewer(
                                                                              maxScale: 5.0,
                                                                              child: Image.network(
                                                                                anons?[index]["image"] ?? "",
                                                                                fit: BoxFit.fill,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                  child: Container(
                                                                      child: Image.network(
                                                                          anons?[index]["image"] ??
                                                                              "")))
                                                              : const SizedBox
                                                                  .shrink(),
                                                          Text(
                                                            anons?[index][
                                                                    "description"] ??
                                                                "",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 2)),
                                    width: double.infinity,
                                    height: 80,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: double.infinity,
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  DateFormat("yMMMd", "tr")
                                                      .format(DateTime.parse(
                                                          anons?[index]
                                                                  ["date"] ??
                                                              "")),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium
                                                      ?.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 7,
                                          child: SizedBox(
                                            width: 250,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                anons?[index]["title"] ?? "",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: anons?[index]["link"] !=
                                                        null &&
                                                    anons![index]["link"]!
                                                        .isNotEmpty
                                                ? TextButton(
                                                    onPressed: () {
                                                      launchUrl(
                                                          Uri.parse(anons?[
                                                                      index]
                                                                  ["link"] ??
                                                              ""),
                                                          mode: LaunchMode
                                                              .inAppWebView);
                                                    },
                                                    child: FittedBox(
                                                        child: Text(
                                                      "Link",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.blue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    )),
                                                  )
                                                : const SizedBox.shrink())
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(child: Text("No announcements available")),
        ));
  }
}
