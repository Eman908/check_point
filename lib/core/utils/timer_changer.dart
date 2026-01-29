import 'dart:async';

class ThreeMinuteTimer {
  static const int maxSeconds = 3 * 60;
  int _currentSeconds = maxSeconds;
  Timer? _timer;

  void start(void Function(String time) onTick) {
    _timer?.cancel();

    _currentSeconds = maxSeconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentSeconds == 0) {
        _currentSeconds = maxSeconds;
      } else {
        _currentSeconds--;
      }

      onTick(_formatTime(_currentSeconds));
    });
  }

  void stop() {
    _timer?.cancel();
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}
