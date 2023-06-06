import 'package:bloc/bloc.dart';

/**
 * BlocObserver 클래스를 상속받아 CounterObserver 클래스 생성
 * 상태변화 감시 onChange() 구현
 */

class CounterObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} %change');
  }
}
