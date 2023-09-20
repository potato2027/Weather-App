import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/GetxBindings/GetxBindings.dart';
import 'package:untitled/views/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GetxBindings(),
      title: 'Flutter Demo',
      home: const HomeScreen(),
    );
  }
}