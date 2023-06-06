import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 1. 이벤트 등록
abstract class CounterEvent {
  int no;
  CounterEvent(this.no);
}

class IncrementEvent extends CounterEvent {
  IncrementEvent(int no) : super(no);
}

class DecrementEvent extends CounterEvent {
  DecrementEvent(int no) : super(no);
}

// 2. bloc 클래스 선언
class BlocCounter extends Bloc<CounterEvent, int> {
  BlocCounter() : super(0) {
    // 이벤트 등록
    on<IncrementEvent>((event, emit) {
      // state : 기존에 유지됐던 상태값.
      // IncrementEvent에서 이벤트가 발생하며 추가된 데이터를 기존 상태에 더하고 새로운 상태로 갱신.
      emit(state + event.no);
    });
    on<DecrementEvent>((event, emit) {
      emit(state - event.no);
    });
  }

  @override
  void onEvent(CounterEvent event) {
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    super.onTransition(transition);
    print('transition... $transition');
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bloc Test'),
        ),
        // bloc 의 상태값을 widget에 동기화하는 역할 -> BlocProvider
        body: BlocProvider<BlocCounter>(
          create: (context) => BlocCounter(),
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BlocCounter counterBloc = BlocProvider.of<BlocCounter>(context);
    return BlocBuilder<BlocCounter, int>(builder: (context, count) {
      return Container(
          color: Colors.deepOrange,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${counterBloc.state}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    counterBloc.add(IncrementEvent(2));
                  },
                  child: Text('increment'),
                ),
                ElevatedButton(
                  onPressed: () {
                    counterBloc.add(DecrementEvent(2));
                  },
                  child: Text('decrement'),
                )
              ],
            ),
          ));
    });
  }
}
