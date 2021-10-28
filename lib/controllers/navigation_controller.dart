import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class NavigationController extends GetxController {
  static NavigationController instance = Get.find();
  final GlobalKey<NavigatorState> navigationKey = GlobalKey();

  void navigateTo(String routeName, {Object? args}) {
      navigationKey.currentState!.pushNamed(routeName, arguments: args);
  }

  goback() => navigationKey.currentState!.pop();
}
