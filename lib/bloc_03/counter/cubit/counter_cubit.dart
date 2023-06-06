import 'package:bloc/bloc.dart';

/**
 * CounterView()에서 상태변화를 호출하면 CounterCubit클래스의
 * 호출된 함수가 상태 변화 수행.
 */

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  // 현재 상태 값 +1 수행
  void increment() => emit(state + 1);

  // 현재 상태 값 -1 수행
  void decrement() => emit(state - 1);
}
