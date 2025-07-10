import 'dart:async';
import 'dart:ui';

// https://stackoverflow.com/a/55119208/10693073

class Debouncer {
  final int? milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds ?? 0), action);
  }
}
