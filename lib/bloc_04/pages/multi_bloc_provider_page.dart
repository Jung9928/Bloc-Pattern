import 'package:bloc_pattern_01/bloc_04/bloc/sample_bloc.dart';
import 'package:bloc_pattern_01/bloc_04/bloc/sample_second_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiBlocProviderPage extends StatefulWidget {
  const MultiBlocProviderPage({super.key});

  @override
  State<MultiBlocProviderPage> createState() => _MultiBlocProviderPageState();
}

class _MultiBlocProviderPageState extends State<MultiBlocProviderPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SampleBloc(),
      child: BlocProvider(
        create: (context) => SampleSecondsBloc(),
        child: SamplePage(),
      ),
    );
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider(create: ((context) => SampleBloc())),
    //     BlocProvider(create: ((context) => SampleSecondsBloc())),
    //   ],
    //   child: SamplePage(),
    // );
  }
}

class SamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('Bloc Provider Sample'),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context.read<SampleBloc>().add(SampleEvent());
                  },
                  child: Text('+')),
              ElevatedButton(
                  onPressed: () {
                    context.read<SampleSecondsBloc>().add(SampleSecondsEvent());
                  },
                  child: Text('-')),
            ],
          )
        ],
      ),
    ));
  }
}
