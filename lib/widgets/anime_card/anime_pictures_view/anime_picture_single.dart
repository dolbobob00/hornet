import 'package:flutter/material.dart';

import '../image_card/image_card.dart';

class AnimePictureSingle extends StatelessWidget {
  const AnimePictureSingle({super.key, required this.pictureUrl, required this.uploadedAt, required this.source});
  final String pictureUrl;
  final String uploadedAt;
  final String source;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(
          25,
        ),
      ),
      child: ImageCard(
        imageUrl: pictureUrl,
        date: uploadedAt,
        source: source,
      ),
    );
  }
}
