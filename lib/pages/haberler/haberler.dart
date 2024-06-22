import 'package:cse_university_app/pages/auth/widgets/auth_widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Haberler extends StatefulWidget {
  const Haberler({super.key});

  @override
  State<Haberler> createState() => _HaberlerState();
}

class _HaberlerState extends State<Haberler> {
  late List<Map<String, dynamic>>? news;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  Future<void> getNews() async {
    news = await AuthWidgets().getNews();
    setState(() {
      isLoading = false;
    });
    // print(news);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Haberler",
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : news != null && news!.isNotEmpty
                ? ListView.builder(
                    itemCount: news?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                          width: double.infinity,
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0, top: 0, bottom: 0),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        useSafeArea: true,
                                        context: context,
                                        builder: (context) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Center(
                                              child: InteractiveViewer(
                                                maxScale: 5.0,
                                                child: Image.network(
                                                  news?[index]["image"] ?? "",
                                                  fit: BoxFit.fill,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Image.network(
                                                        "https://www.istun.edu.tr/templates/default/assets/images/istun.logo.white.png");
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      width: 80,
                                      color: Theme.of(context).primaryColor,
                                      child: Center(
                                        child: Image.network(
                                          news?[index]["image"] ?? "",
                                          fit: BoxFit.fill,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.network(
                                                "https://www.istun.edu.tr/templates/default/assets/images/istun.logo.white.png");
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 8,
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        useSafeArea: true,
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      news?[index]
                                                              ["description"] ??
                                                          "",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: SizedBox(
                                        width: 250,
                                        child: Text(
                                          news?[index]["title"] ?? "",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: news?[index]["link"] != null &&
                                          news![index]["link"]!.isNotEmpty
                                      ? TextButton(
                                          onPressed: () {
                                            launchUrl(
                                              Uri.parse(
                                                  news?[index]["link"] ?? ""),
                                              mode: LaunchMode.inAppWebView,
                                            );
                                          },
                                          child: FittedBox(
                                            child: Text(
                                              "Link",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const Center(child: Text("No news available")),
      ),
    );
  }
}
