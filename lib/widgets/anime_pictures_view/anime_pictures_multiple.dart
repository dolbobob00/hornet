import 'package:flutter/material.dart';
import '../image_card/image_card.dart';

class AnimePicturesMultiple extends StatefulWidget {
  const AnimePicturesMultiple({
    super.key,
    required this.pictureUrls,
    required this.uploadedAt,
    required this.source,
  });

  final List<String> pictureUrls;
  final List<String> uploadedAt;
  final List<String> source;

  @override
  State<AnimePicturesMultiple> createState() => _AnimePicturesMultipleState();
}

class _AnimePicturesMultipleState extends State<AnimePicturesMultiple> {
  late final PageController _pageController;
  
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 1.0,
      initialPage: 0,
      keepPage: true,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(25),
      ),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.6 + 
               MediaQuery.of(context).padding.bottom,
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.pictureUrls.length,
          scrollDirection: Axis.vertical,
        
          pageSnapping: true,
          padEnds: false,
          allowImplicitScrolling: true, 
          itemBuilder: (context, index) {
  
            _preloadAdjacentImages(index);
            
            return ImageCard(
              imageUrl: widget.pictureUrls[index],
              date: widget.uploadedAt[index],
              source: widget.source[index],
            );
          },
        ),
      ),
    );
  }

  void _preloadAdjacentImages(int currentIndex) {
    // Предзагрузка следующих 4 изображений
    for (int i = 1; i <= 4; i++) {
      final nextIndex = currentIndex + i;
      if (nextIndex < widget.pictureUrls.length) {
        precacheImage(
          NetworkImage(widget.pictureUrls[nextIndex]),
          context,
        );
      }
    }
  }
}
