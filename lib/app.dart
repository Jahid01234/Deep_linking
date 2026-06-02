import 'package:deep_linking/feature/home/view/home_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deep Linking',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white
      ),
      home: HomeScreen()
    );
  }
}
