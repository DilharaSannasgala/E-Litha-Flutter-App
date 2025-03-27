import 'package:e_litha/screens/home-screen.dart';
import 'package:e_litha/screens/loading-screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'E-Litha', initialRoute: '/', routes: {
      '/': (context) => LoadingScreen(),
      '/home': (context) => HomePage(),
    });
  }
}
