import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselDeneme extends StatefulWidget {
  const CarouselDeneme({super.key});

  @override
  State<CarouselDeneme> createState() => _CarouselDenemeState();
}

class _CarouselDenemeState extends State<CarouselDeneme> {
  final controller = CarouselController();
  int activeIndex = 0;

  final urlImages = [
    //burda url resimler olucak denemelik koydum
    "assets/kampuss.jpeg",
    "assets/sutluce.jpg",
    "assets/night.jpg",
    "assets/sinif.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Scaffold(
        body: Stack(
          children: [
            CarouselSlider.builder(
              carouselController: controller,
              itemCount: urlImages.length,
              itemBuilder: (context, i, realIndex) {
                final urlImage = urlImages[i];
                return buildImage(urlImage, i);
              },
              options: CarouselOptions(
                  enlargeFactor: 0.5,
                  initialPage: 0,
                  onPageChanged: (index, reason) => setState(() => activeIndex = index),
                  /* reverse: true, */ autoPlay: true,
                  autoPlayAnimationDuration: const Duration(seconds: 2),
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  enlargeCenterPage: true, //büyüyüp küçülerek resimler değişiyor
                  viewportFraction: 1, //sadece sliderda 1 tane resim gösterir
                  height: 250),
            ),
            Align(alignment: Alignment.bottomCenter, child: buildIndicator()),
            Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: ileri,
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ))),
            Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: geri,
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ))),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String urlImage, int i) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        color: Colors.grey,
        child: /* Image.network */ Image.asset(
          urlImage,
          fit: BoxFit.cover,
        ),
      );
  Widget buildIndicator() => AnimatedSmoothIndicator(
      effect: CustomizableEffect(
          spacing: 3,
          dotDecoration: DotDecoration(
            width: 15,
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          activeDotDecoration:
              DotDecoration(width: 10, borderRadius: BorderRadius.circular(10), color: const Color(0xffB70404))),
      activeIndex: activeIndex,
      count: urlImages.length);

  void ileri() => controller.nextPage();
  void geri() => controller.previousPage();
}
