import 'package:deep_linking/core/style/global_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Product",
          style: globalTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ) ,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "This is Product Screen...........",
              style: globalTextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
