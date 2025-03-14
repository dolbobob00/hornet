import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:restful_solid_bloc/src/domain/url_service.dart';
import 'package:restful_solid_bloc/widgets/anime_card/image_card/share_button.dart';
import '../cached_image.dart';
import 'download_button.dart';
import '../media_player/media_player.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    this.source,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.date,
  });
  final String imageUrl;
  final String? source;
  final String? date;
  final double? width;
  final double? height;
  final BoxFit? fit;

  bool get _isVideo => imageUrl.endsWith('.mp4') || imageUrl.endsWith('.webm');

  void _handleImageTap(BuildContext context) {
    if (!_isVideo) {
      context.pushNamed(
        'fullscreen_image',
        extra: imageUrl,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _handleImageTap(context),
          child: _isVideo
              ? MediaPlayer(url: imageUrl)
              : CachedImage(
                  imageUrl: imageUrl,
                  width: width ?? double.infinity,
                  height: height ?? MediaQuery.of(context).size.height * 0.45 + 30,
                  fit: fit ?? BoxFit.contain,
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: InkWell(
            onTap: () => GetIt.I<IUrlService>().launchURL(
              imageUrlOrSource: source ?? imageUrl,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    size: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: [
                                const TextSpan(
                                  text: 'Source: ',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: source ?? imageUrl,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Colors.blue,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                ),
                                const TextSpan(
                                  text:
                                      '\n (tap to open, sometimes page may not exist)',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {},
            ),
            ShareButton(
              url: imageUrl,
              text: 'Ayo check this out! (from my app \'hornet\')',
            ),
            DownloadButton(
              url: imageUrl,
            ),
          ],
        )
      ],
    );
  }
}
