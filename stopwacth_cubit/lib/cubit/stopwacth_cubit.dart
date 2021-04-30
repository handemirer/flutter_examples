import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:async';
part 'stopwacth_state.dart';

class StopwacthCubit extends Cubit<StopwacthState> {
  int duration = 0;
  bool run = false;
  Timer? _timer;

  StopwacthCubit() : super(Ready(0));

  void start() {
    run = !run;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (run) {
        duration++;
        emit(Running(duration));
      } else {
        emit(Paused(duration));
        timer.cancel();
      }
    });
  }

  void pause() {
    run = false;
    emit(Paused(duration));
  }

  void reset() {
    run = false;
    duration = 0;
    _timer!.cancel();
    emit(Ready(duration));
  }
}
