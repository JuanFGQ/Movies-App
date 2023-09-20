import 'dart:async';
import 'dart:ui';
// credits
// https://stackoverflow.com/a/52922130/7834829

// class Debouncer<T> {
//   Debouncer({required this.duration, this.onValue});

//   final Duration duration;

//   void Function(T value)? onValue;

//   T? _value;
//   Timer? _timer;

//   T get value => _value!;

//   set value(T val) {
//     _value = val;
//     _timer?.cancel();
//     _timer = Timer(duration, () => onValue!(_value!));
//   }
// }

class Debouncer {
  Debouncer({required this.milliseconds});

  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  void run(VoidCallback action) {
    //If a timer is send, first the previous counter must be cancelled
    if (null != _timer) {
      _timer?.cancel();
    }
    _timer = Timer(
      Duration(milliseconds: milliseconds),
      action,
    );
  }

  void cancel() => _timer?.cancel();
}
