part of 'stopwacth_cubit.dart';

@immutable
abstract class StopwacthState {
  final int duration;

  StopwacthState(this.duration);
}

class Ready extends StopwacthState {
  Ready(int duration) : super(duration);
}

class Paused extends StopwacthState {
  Paused(int duration) : super(duration);
}

class Running extends StopwacthState {
  Running(int duration) : super(duration);
}
