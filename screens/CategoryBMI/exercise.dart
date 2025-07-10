// screens/CategoryBMI/exercise.dart
import 'dart:async';

class ExerciseItem {
  final String name;
  Duration duration;
  bool isRunning;
  Timer? timer;

  ExerciseItem({
    required this.name,
    this.duration = Duration.zero,
    this.isRunning = false,
    this.timer,
  });
}
