import 'package:flutter/material.dart';
import 'pages/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';  // Ensure Riverpod is imported

void main() {
  runApp(const ProviderScope(child: GymRoutineApp()));  // Wrap your app with ProviderScope
}

class GymRoutineApp extends StatelessWidget {
  const GymRoutineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
