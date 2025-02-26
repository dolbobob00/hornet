import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MediaCard extends StatefulWidget {
  final String url;
  final String? source;
  final String? date;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const MediaCard({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.source,
    this.date,
  });

  @override
  State<MediaCard> createState() => _MediaCardState();
}

class _MediaCardState extends State<MediaCard> {
  VideoPlayerController? _controller;
  bool _isVideo = false;

  @override
  void initState() {
    super.initState();
    _initializeMedia();
  }

  void _initializeMedia() {
    _isVideo = widget.url.toLowerCase().endsWith('.webm') ||
        widget.url.toLowerCase().endsWith('.mp4');

    if (_isVideo) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url))
        ..initialize().then((_) {
          if (mounted) {
            setState(() {});
            _controller?.play();
            _controller?.setLooping(true);
          }
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isVideo) {
      if (_controller?.value.isInitialized ?? false) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: widget.width,
              height: widget.height,
              child: FittedBox(
                fit: widget.fit??BoxFit.contain,
                child: SizedBox(
                  width: _controller!.value.size.width,
                  height: _controller!.value.size.height,
                  child: VideoPlayer(_controller!),
                ),
              ),
            ),
            VideoProgressIndicator(
              _controller!,
              allowScrubbing: true,
              padding: const EdgeInsets.all(8),
            ),
          ],
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    } else {
      return CachedNetworkImage(
        imageUrl: widget.url,
        fit: widget.fit,
        width: widget.width,
        height: widget.height,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    }
  }
}
