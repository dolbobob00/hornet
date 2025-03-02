import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restful_solid_bloc/src/presentation/cubit/animations_cubit/cubit/animations_cubit.dart';
import 'package:restful_solid_bloc/src/constants/ui_constants.dart';

class CustomAnimatedIcon extends StatefulWidget {
  const CustomAnimatedIcon({
    super.key,
    required this.animIcon,
    required this.size,
    this.color,
    this.onTap,
  });
  final AnimatedIconData animIcon;
  final double size;
  final VoidCallback? onTap;
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
      duration: const Duration(
        milliseconds: UIConstants.animationDurationMedium,
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the controller before super.dispose()
    controller.dispose();
    super.dispose();
  }


  void playAnimation(bool isOpened) {
    if (!mounted) return;
    if (isOpened) {
      controller.forward();
    } else {
      controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: BlocListener<AnimationsCubit, AnimationsState>(
        listener: (context, state) {
          if (state is AnimationsStarted) {
            playAnimation(state.shouldStart);
          }
        },
        child: AnimatedIcon(
          color: widget.color,
          icon: widget.animIcon,
          size: widget.size,
          progress: controller,
        ),
      ),
    );
  }
}
