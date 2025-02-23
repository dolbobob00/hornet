import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:restful_solid_bloc/src/domain/downloader.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cached_image.dart';
import '../download_button.dart';

class ImageCard extends StatelessWidget {
  const ImageCard(
      {super.key,
      this.source,
      required this.imageUrl,
      this.width,
      this.height,
      this.fit,
      this.date});
  final String imageUrl;
  final String? source;
  final String? date;
  final double? width;
  final double? height;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedImage(
          imageUrl: imageUrl,
          width: width ?? double.infinity,
          height: height ?? MediaQuery.of(context).size.height * 0.45,
          fit: fit ?? BoxFit.contain,
        ),
        Text(
          date ?? '',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: InkWell(
            onTap: _launchURL,
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
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Source: ',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: source ?? imageUrl,
                                  style: const TextStyle(
                                    color: Colors.blue,
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
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {},
            ),
            DownloadButton(
              url: imageUrl,
            ),
          ],
        )
      ],
    );
  }

  void _launchURL() async {
    final Uri url = Uri.parse(source ?? imageUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
