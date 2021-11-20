import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/constants/controllers.dart';
import 'package:rs_books/constants/style.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/styled_widgets/styled_spacers.dart';
import 'package:rs_books/styles.dart';
import 'package:rs_books/themes.dart';
import 'package:rs_books/widgets/side_menu_item.dart';
import 'package:rs_books/widgets/site_title.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    double _width = MediaQuery.of(context).size.width;
    return Container(
        color: light,
        child: ListView(
          children: [
            if (ResponsiveWidget.isSmallScreen(context))
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  VSpace(40),
                  Row(
                    children: [
                      HSpace(_width / 48),
                      Padding(
                        padding: EdgeInsets.all(Insets.sm),
                        child: Image.asset('assets/logo/bb-bw.jpeg',
                            width: 48,
                            height: 48,
                            color: theme.accent1,
                            colorBlendMode: BlendMode.color),
                      ),
                      Flexible(
                          child: SiteTitle(
                        siteTitle: "Brain Basket",
                      )),
                      HSpace(_width / 48),
                    ],
                  ),
                ],
              ),
            VSpace(40),
            Divider(color: theme.accent1),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: sideMenuItems
                  .map((itemName) => SideMenuItem(
                      itemName: itemName as String,
                      onTap: () {
                        if (menuController.isActive(itemName) != true) {
                          menuController.changeActiveItemTo(itemName);
                          context.goNamed(itemName);
                        }
                      }))
                  .toList(),
            )
          ],
        ));
  }
}
