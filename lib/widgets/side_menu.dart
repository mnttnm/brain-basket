import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rs_books/constants/controllers.dart';
import 'package:rs_books/constants/style.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/widgets/custom_text.dart';
import 'package:rs_books/widgets/side_menu_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
        color: light,
        child: ListView(
          children: [
            if (ResponsiveWidget.isSmallScreen(context))
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: _width / 48,
                      ),
                      Flexible(
                          child: CustomText(
                        text: "RS-Books",
                        size: 20,
                        weight: FontWeight.bold,
                        color: active,
                      )),
                      SizedBox(
                        width: _width / 48,
                      ),
                    ],
                  ),
                ],
              ),
            SizedBox(
              height: 40,
            ),
            Divider(
              color: Colors.purpleAccent.shade400
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: sideMenuItems
                  .map((itemName) => SideMenuItem(
                      itemName: itemName,
                      onTap: () {
                        if (!menuController.isActive(itemName)) {
                          menuController.changeActiveItemTo(itemName);
                          if (ResponsiveWidget.isSmallScreen(context))
                            Get.back();
                          navigationController.navigateTo(itemName);
                        }
                      }))
                  .toList(),
            )
          ],
        ));
  }
}
