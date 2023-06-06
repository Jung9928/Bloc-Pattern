import 'dart:developer';

import 'package:flutter/material.dart';

import 'counter/counter.dart';

/**
 * MaterialApp 클래스를 CounterApp 클래스가 상속받아
 * CounterPage()를 Home으로 페이지 route 수행.
 */

class CounterApp extends MaterialApp {
  const CounterApp({Key? key}) : super(key: key, home: const CounterPage());
}
