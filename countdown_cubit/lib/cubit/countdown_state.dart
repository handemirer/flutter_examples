part of 'countdown_cubit.dart';

@immutable
abstract class CountdownState {
  final int duration;

  CountdownState(this.duration);
}

class Ready extends CountdownState {
  Ready(int duration) : super(duration);
}

class Paused extends CountdownState {
  Paused(int duration) : super(duration);
}

class Running extends CountdownState {
  Running(int duration) : super(duration);
}
