import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/animations_cubit/cubit/animations_cubit.dart';

class CustomAnimatedIcon extends StatefulWidget {
  const CustomAnimatedIcon(
      {super.key, required this.animIcon, required this.size, this.color});
  final AnimatedIconData animIcon;
  final double size;
  final Color? color;
  @override
  State<CustomAnimatedIcon> createState() => _CustomAnimatedIconState();
}

class _CustomAnimatedIconState extends State<CustomAnimatedIcon>
    with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );
  }

  void playAnimation() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AnimationsCubit, AnimationsState>(
      listener: (context, state) {
        if (state is AnimationsStarted) {
          playAnimation();
        }
      },
      child: AnimatedIcon(
        color: widget.color,
        icon: widget.animIcon,
        size: widget.size,
        progress: controller,
      ),
    );
  }
}
