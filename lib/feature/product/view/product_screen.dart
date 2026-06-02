import 'package:deep_linking/core/style/global_text_style.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "This is Product Screen...........",
              style: globalTextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
