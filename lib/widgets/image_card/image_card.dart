import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:restful_solid_bloc/src/domain/url_service.dart';
import 'package:restful_solid_bloc/widgets/image_card/share_button.dart';
import '../media_player/media_player.dart';
import 'download_button.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final String? date;
  final String? source;

  const ImageCard({
    Key? key,
    required this.imageUrl,
    this.date,
    this.source,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: MediaPlayer(
              url: imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          if (date != null || source != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (date != null)
                    Text(
                      'Uploaded: $date',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  if (source != null)
                    Text(
                      'Source: $source',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
