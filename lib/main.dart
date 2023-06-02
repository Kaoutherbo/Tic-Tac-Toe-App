import 'package:flutter/material.dart';
import '../lib/presentation/LogInScreen.dart.dart';
import '../lib/presentation/GameScreen.dart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
