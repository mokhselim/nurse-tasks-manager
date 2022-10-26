import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../screens/main_screens/home_screen/home_screen.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeCtrl = Get.put(HomeController());

    return Scaffold(
      body: SafeArea(
          child: HomeScreen(
        homeCtrl: homeCtrl,
      )),
    );
  }
}
