import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rs_books/constants/controllers.dart';
import 'package:rs_books/constants/style.dart';
import 'package:rs_books/styled_widgets/styled_spacers.dart';
import 'package:rs_books/styles.dart';
import 'package:rs_books/widgets/custom_text.dart';

class HorizontalMenuItem extends StatelessWidget {
  final String itemName;
  final void Function() onTap;
  const HorizontalMenuItem(
      {Key? key, required this.itemName, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: onTap,
        onHover: (value) {
          value
              ? menuController.onHover(itemName)
              : menuController.onHover("not hovering");
        },
        child: Obx(() => Container(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: menuController.isHovering(itemName) == true ||
                        menuController.isActive(itemName) == true
                    ? BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.black, width: 6)))
                    : null,
                child: Row(
                  children: [
                    menuController.returnIconFor(itemName),
                    HSpace(Insets.sm),
                    if (menuController.isActive(itemName) != true)
                      CustomText(
                        text: itemName,
                        color: menuController.isHovering(itemName) == true
                            ? dark
                            : light,
                      )
                    else
                      CustomText(
                        text: itemName,
                        color: dark,
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
