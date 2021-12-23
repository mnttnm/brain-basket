import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/widgets/large_screen.dart';
import 'package:rs_books/widgets/nav_bar.dart';
import 'package:rs_books/widgets/order_progress_bar.dart';
import 'package:rs_books/widgets/side_menu.dart';
import 'package:rs_books/widgets/small_screen.dart';

class SiteLayout extends StatelessWidget {
  final Widget child;
  const SiteLayout({required this.child, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    final showProgresStatusBar =
        [CheckOutPageRoute, PaymentsPageRoute, OrderSuccessPageRoute].any(
      (element) => GoRouter.of(context).location.contains(
            getPathStrForRoute(element),
          ),
    );
    return Scaffold(
      key: scaffoldKey,
      appBar: topNavigationBar(context, scaffoldKey),
      drawer: ResponsiveWidget.isSmallScreen(context) ? const SideMenu() : null,
      body: Column(
        children: [
          if (showProgresStatusBar) Expanded(child: OrderProgressStatusBar()),
          Expanded(
            flex: 9,
            child: ResponsiveWidget(
              largeScreen: LargeScreen(
                child: child,
              ),
              smallScreen: SmallScreen(
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
