import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'app.dart';
import 'counter_observer.dart';

/**
 * State를 감시할 위젯을 BlocOverrides.runZoned()로 감싸고
 * counter_observer.dart에서 구현한 CounterObserver()를 감시할
 * 위젯인 RunApp에 연결.
 */

void main() {
  BlocOverrides.runZoned(
    () => runApp(const CounterApp()),
    blocObserver: CounterObserver(),
  );
}
