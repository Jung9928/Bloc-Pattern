import 'package:bloc_pattern_01/bloc_04/pages/bloc_provider_page.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BlocProviderPage()),
              );
            },
            child: const Text('BlocProvider'),
          ),
        ]),
      ),
    );
  }
}
