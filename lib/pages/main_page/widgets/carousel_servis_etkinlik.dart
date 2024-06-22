import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cse_university_app/pages/auth/widgets/auth_widgets.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ServisEtkinlik extends StatefulWidget {
  const ServisEtkinlik({Key? key});

  @override
  State<ServisEtkinlik> createState() => _ServisEtkinlikState();
}

class _ServisEtkinlikState extends State<ServisEtkinlik> {
  final controller = CarouselController();
  int activeIndex = 0;
  List<String> events = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getEvent();
  }

  Future<void> getEvent() async {
    List<String> eventUrls = await AuthWidgets().getEvents();
    setState(() {
      events = eventUrls;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Stack(
        children: [
          if (events.isNotEmpty)
            CarouselSlider.builder(
              carouselController: controller,
              itemCount: events.length,
              itemBuilder: (context, index, realIndex) {
                return InkWell(
                  onTap: () {
                    showDialog(
                      useSafeArea: true,
                      context: context,
                      builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: InteractiveViewer(
                            maxScale: 5.0,
                            child: Image.network(
                              events.isNotEmpty ? events[index] : "",
                              /* width: double.infinity, */
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 6,
                          offset: Offset(0, 1),
                          spreadRadius: 1,
                        ),
                      ],
                      border: Border.all(color: Colors.white, width: 1),
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        events[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                enlargeFactor: 0.5,
                initialPage: 0,
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index),
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                enlargeCenterPage: true,
                viewportFraction: 0.6,
                height: 250,
              ),
            ),
          if (isLoading) const Center(child: CircularProgressIndicator()),
          if (!isLoading && events.isEmpty)
            const Center(child: Text("No events available")),
          if (events.isNotEmpty)
            Align(
              alignment: Alignment.bottomCenter,
              child: buildIndicator(),
            ),
          if (events.isNotEmpty)
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: ileri,
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ),
          if (events.isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: geri,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        effect: CustomizableEffect(
          spacing: 3,
          dotDecoration: DotDecoration(
            width: 15,
            dotBorder: const DotBorder(color: Colors.red),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          activeDotDecoration: DotDecoration(
            width: 10,
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffB70404),
          ),
        ),
        activeIndex: activeIndex,
        count: events.isNotEmpty ? events.length : 0,
      );

  void ileri() => controller.nextPage();
  void geri() => controller.previousPage();
}
