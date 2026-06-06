import 'package:deep_linking/core/style/global_text_style.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
              "This is home screen...........",
              style: globalTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
