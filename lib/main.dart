import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/constants/style.dart';
import 'package:rs_books/controllers/cart_controller.dart';
import 'package:rs_books/controllers/menu_controller.dart';
import 'package:rs_books/controllers/navigation_controller.dart';
import 'package:rs_books/layout.dart';

void main() {
  Get.put(NavigationController());
  Get.put(MenuController());
  runApp(ChangeNotifierProvider(
    create: (context) => CartController(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "RS Books",
      theme: ThemeData().copyWith(
        cardTheme: CardTheme().copyWith(margin: EdgeInsets.zero),
        primaryColorDark: primaryDark,
        primaryColorLight: primaryLight,
        primaryColor: primaryMedium,
        appBarTheme: AppBarTheme().copyWith(
            toolbarTextStyle: AppBartextStyle, backgroundColor: Colors.deepPurple.shade300),
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()
        }),
      ),
      home: SiteLayout(),
    );
  }
}
