part of 'animations_cubit.dart';

@immutable
sealed class AnimationsState {}

final class AnimationsInitial extends AnimationsState {}

final class AnimationsStarted extends AnimationsState {
  AnimationsStarted({required this.shouldStart});
  final bool shouldStart;
}
