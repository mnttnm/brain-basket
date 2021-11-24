import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/constants/controllers.dart';
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
    final AppTheme theme = context.watch();
    final double _width = MediaQuery.of(context).size.width;
    const siteTitle = String.fromEnvironment('SITE_TITLE');

    return Container(
        color: theme.surface1,
        child: ListView(
          children: [
            if (ResponsiveWidget.isSmallScreen(context))
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  VSpace.xl,
                  Row(
                    children: [
                      HSpace(_width / 48),
                      Padding(
                        padding: EdgeInsets.all(Insets.sm),
                        child: Image.asset('assets/logo/bb-bw.jpeg',
                            width: 48,
                            height: 48,
                            color: theme.accent1,
                            colorBlendMode: BlendMode.color,
                      ),
                      ),
                      const Flexible(
                          child: SiteTitle(
                        siteTitle: siteTitle,
                      ),
                    ),
                      HSpace(_width / 48),
                    ],
                  ),
                ],
              ),
            VSpace.xl,
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
                      },
                  ),
                )
                  .toList(),
            )
          ],
        ),
    );
  }
}
