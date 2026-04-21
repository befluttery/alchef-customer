import 'package:alchef/common/widgets/online_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatelessWidget {
  const CustomCarousel({
    super.key,
    this.controller,
    required this.height,
    this.radius = 0,
    required this.imageUrls,
    this.imageFit,
    this.onImageChanged,
    this.autoPlay = true,
    this.customRadius,
    required this.onTap,
  });

  final CarouselSliderController? controller;
  final double height;
  final double radius;
  final List<String> imageUrls;
  final BoxFit? imageFit;
  final Function(int index, CarouselPageChangedReason reason)? onImageChanged;
  final bool autoPlay;
  final BorderRadiusGeometry? customRadius;
  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      carouselController: controller,
      itemCount: imageUrls.length,
      options: CarouselOptions(
        height: height,
        aspectRatio: 16 / 9,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: autoPlay,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        onPageChanged: onImageChanged,
        scrollDirection: Axis.horizontal,
      ),

      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          InkWell(
            onTap: () => onTap(itemIndex),
            child: OnlineImage(
              link: imageUrls[itemIndex],
              height: double.infinity,
              width: double.infinity,
              radius: radius,
              fit: imageFit,
              customRadius: customRadius,
            ),
          ),
    );
  }
}
