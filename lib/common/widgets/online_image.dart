import 'package:alchef/config/app_images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:alchef/common/widgets/loading_shimmer.dart';

class OnlineImage extends StatelessWidget {
  const OnlineImage({
    super.key,
    required this.link,
    this.placeHolder,
    this.errorWidget,
    this.shape,
    required this.height,
    required this.width,
    this.radius = 0,
    this.fit,
    this.customRadius,
  });

  final String link;
  final Widget? placeHolder;
  final Widget? errorWidget;
  final BoxShape? shape;
  final double height;
  final double width;
  final double radius;
  final BoxFit? fit;
  final BorderRadiusGeometry? customRadius;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: link,
      placeholder: (context, url) =>
          placeHolder ??
          Container(
            height: height,
            width: width,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(shape: shape ?? BoxShape.rectangle),
            child: LoadingShimmer(
              height: double.infinity,
              width: double.infinity,
              radius: radius,
            ),
          ),
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: shape ?? BoxShape.rectangle,
          borderRadius:
              customRadius ??
              (shape == null ? BorderRadius.circular(radius) : null),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        child:
            errorWidget ??
            Image.asset(
              AppImages.logo,
              height: height,
              width: width,
              fit: fit ?? BoxFit.cover,
            ),
      ),
    );
  }
}
