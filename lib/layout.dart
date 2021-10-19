import 'package:flutter/material.dart';
import 'package:rs_books/constants/style.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/widgets/large_screen.dart';
import 'package:rs_books/widgets/nav_bar.dart';
import 'package:rs_books/widgets/side_menu.dart';
import 'package:rs_books/widgets/small_screen.dart';

class SiteLayout extends StatelessWidget {
  const SiteLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return Scaffold(
        key: scaffoldKey,
        appBar: topNavigationBar(context, scaffoldKey),
        drawer: ResponsiveWidget.isSmallScreen(context)? SideMenu(): null,
        body: Container(
          decoration: BoxDecoration(gradient: bckgradnt),
          child: ResponsiveWidget(
            largeScreen: LargeScreen(),
            smallScreen: SmallScreen(),
          ),
        ));
  }
}
