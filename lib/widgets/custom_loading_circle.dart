import 'package:flutter/material.dart';

class CustomLoadingCircle extends StatefulWidget {
  final double? size;
  final String? gifPath;

  const CustomLoadingCircle({
    super.key,
    this.size,
    this.gifPath = 'assets/animations/rem.gif',
  });

  @override
  State<CustomLoadingCircle> createState() => _CustomLoadingCircleState();
}

class _CustomLoadingCircleState extends State<CustomLoadingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final defaultSize = screenSize.width * 0.15; // 15% от ширины экрана
    final adaptiveSize = widget.size ?? defaultSize;

    return RotationTransition(
      turns: _controller,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.blue[300] ?? Colors.blue, width: 2),
        ),
        child: CircleAvatar(
          radius: adaptiveSize / 2,
          foregroundImage: Image.asset(
            widget.gifPath!,
            width: adaptiveSize,
            height: adaptiveSize,
            fit: BoxFit.cover,
          ).image,
        ),
      ),
    );
  }
}
