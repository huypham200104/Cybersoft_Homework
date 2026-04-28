import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cyber_app_homework/baitap1.dart';
import 'package:cyber_app_homework/baitap2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cyber App Homework',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      //home: const OnboardingScreen(), // baitap1
       home: const Baitap2Screen(), // baitap2
    );
  }
}
