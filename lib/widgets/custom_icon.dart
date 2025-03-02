import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.icon, this.size, this.weight, this.color});
  final IconData icon;
  final double? size;
  final double? weight;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size ?? 24,
      weight: weight,
      color: color,
    );
  }
}
