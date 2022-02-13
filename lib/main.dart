import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/controllers/address_controller.dart';
import 'package:rs_books/controllers/cart_controller.dart';
import 'package:rs_books/controllers/menu_controller.dart';
import 'package:rs_books/layout.dart';
import 'package:rs_books/routing/router.dart';
import 'package:rs_books/themes.dart';

void main() {
  Get.put(MenuController());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartController(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddressController(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme _theme = AppTheme.fromType(ThemeType.Teal_Light);
    final cart = Provider.of<CartController>(context, listen: false);
    final GoRouter _router = GoRouter(
      redirect: (state) {
        if (state.location == '/payment' ||
            state.location == '/ordersuccess' ||
            state.location == '/checkout') {
          if (cart.products.isEmpty) {
            return '/books';
          }
          return null;
        }
      },
      // urlPathStrategy: UrlPathStrategy.path,
      routes: generateRoute(context),
      errorPageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: const Center(
          child: Text("Error Page"),
        ),
      ),
      navigatorBuilder: (context, state, child) => SiteLayout(child: child),
    );
    return Provider.value(
      value: _theme,
      child: GetMaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        theme: _theme.toThemeData(),
        debugShowCheckedModeBanner: false,
        title: "Brain Basket",
      ),
    );
  }
}
