import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:async';
part 'countdown_state.dart';

class CountdownCubit extends Cubit<CountdownState> {
  int duration = 60;
  bool run = false;
  Timer? _timer;

  CountdownCubit() : super(Ready(60));

  set d(int d) {
    this.duration = d > 0 ? d : 0;
    emit(Ready(duration));
  }

  int get d {
    return this.duration;
  }

  void start() {
    run = !run;
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (run) {
        duration--;
        emit(Running(duration));
        if (duration <= 0) {
          duration = 60;
          run = false;
          emit(Ready(duration));
          timer.cancel();
        }
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
    duration = 60;
    _timer!.cancel();
    emit(Ready(duration));
  }
}
