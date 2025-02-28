import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'animations_state.dart';

class AnimationsCubit extends Cubit<AnimationsState> {
  AnimationsCubit() : super(AnimationsInitial());

  void mustProvideAnimation({required bool value}) {
    emit(
      AnimationsStarted(
        shouldStart: value,
      ),
    );
  }
}
