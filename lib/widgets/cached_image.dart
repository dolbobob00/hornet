import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restful_solid_bloc/widgets/custom_loading_circle.dart';

class CachedImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const CachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width ?? MediaQuery.of(context).size.width * 0.85,
      height: height ?? MediaQuery.of(context).size.height * 0.5,
      fit: fit ?? BoxFit.cover,
      placeholder: (context, url) => const Center(
        child: CustomLoadingCircle(),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        color: Colors.red,
      ),
      // Настройки кэширования
      memCacheWidth: 800,
      memCacheHeight: 800,
      maxWidthDiskCache: 550,
      maxHeightDiskCache: 550,
    );
  }
}
