import 'package:deep_linking/core/route/routes.dart';
import 'package:deep_linking/core/style/global_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Home",
          style: globalTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ) ,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                  "This is home screen...........",
                  style: globalTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.teal.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
                onPressed: ()=> Get.toNamed(AppRoutes.product),
                child: Text(
                  "Click...........",
                  style: globalTextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }
}
