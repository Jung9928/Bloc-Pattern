import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class User {
  String name;
  String address;
  User(this.name, this.address);
}

// User 관련 이벤트
abstract class UserEvent {
  User user;
  UserEvent(this.user);
}

class CreateUserEvent extends UserEvent {
  CreateUserEvent(User user) : super(user);
}

class UpdateUserEvent extends UserEvent {
  UpdateUserEvent(User user) : super(user);
}

class UserBloc extends Bloc<UserEvent, User?> {
  UserBloc() : super(null) {
    on<CreateUserEvent>((event, emit) {
      emit(event.user);
    });
    on<UpdateUserEvent>((event, emit) {
      emit(event.user);
    });
  }
}

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
}

class MyBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    super.onTransition(bloc, transition);
    // Bloc에서 이벤트 발생 시, 로그 출력
    print('observer onTransition... $transition');
  }
}

void main() {
  BlocOverrides.runZoned(() {
    runApp(MyApp());
  }, blocObserver: MyBlocObserver()); // BlocObserver 등록.
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('BlocObserver, BlocListener'),
          ),
          // bloc 의 상태값을 widget에 동기화하는 역할 -> BlocProvider
          body: MultiBlocProvider(
            providers: [
              BlocProvider<BlocCounter>(
                create: (context) => BlocCounter(),
              ),
              BlocProvider<UserBloc>(
                create: (context) => UserBloc(),
              )
            ],
            child: MyWidget(),
          )),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BlocCounter counterBloc = BlocProvider.of<BlocCounter>(context);
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    return BlocBuilder<BlocCounter, int>(builder: (context, count) {
      return MultiBlocListener(
          listeners: [
            BlocListener<BlocCounter, int>(listenWhen: (previous, current) {
              return true;
            },
                // Bloc에서 이벤트 발생으로 상태 값이 변경되었을 때, 처리해야 될 로직 수행.
                listener: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('$state'),
                backgroundColor: Colors.red,
              ));
            }),
            BlocListener<UserBloc, User?>(listener: (context, user) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('${user!.name}'),
                backgroundColor: Colors.blue,
              ));
            }),
          ],
          child: Container(
            color: Colors.deepOrange,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<BlocCounter, int>(
                    buildWhen: (previous, current) {
                      return true;
                    },
                    builder: (context, count) {
                      return Column(
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
                          Text(
                            'Bloc : ${count}',
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
                          ),
                        ],
                      );
                    },
                  ),

                  // BlocBuilder : 화면 구성
                  BlocBuilder<UserBloc, User?>(builder: (context, user) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'user : ${user?.name}, ${user?.address}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            userBloc
                                .add(CreateUserEvent(User('Hong', 'seoul')));
                          },
                          child: Text('create'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            userBloc.add(UpdateUserEvent(User('kim', 'busan')));
                          },
                          child: Text('update'),
                        ),
                      ],
                    );
                  })
                ],
              ),
            ),
          ));
    });
  }
}
