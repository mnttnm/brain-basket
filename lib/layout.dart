import 'package:flutter/material.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/widgets/large_screen.dart';
import 'package:rs_books/widgets/nav_bar.dart';
import 'package:rs_books/widgets/side_menu.dart';
import 'package:rs_books/widgets/small_screen.dart';

class SiteLayout extends StatelessWidget {
  final Widget child;
  SiteLayout({required this.child, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return Scaffold(
        key: scaffoldKey,
        appBar: topNavigationBar(context, scaffoldKey),
        drawer: ResponsiveWidget.isSmallScreen(context) ? SideMenu() : null,
        body: Container(
          child: ResponsiveWidget(
            largeScreen: LargeScreen(
              child: child,
            ),
            smallScreen: SmallScreen(
              child: child,
            ),
          ),
        ));
  }
}
