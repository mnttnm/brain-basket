import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:rs_books/constants/controllers.dart';
import 'package:rs_books/constants/style.dart';
import 'package:rs_books/styles.dart';
import 'package:rs_books/widgets/custom_text.dart';

class VerticalMenuItem extends StatelessWidget {
  final String itemName;
  final void Function() onTap;
  const VerticalMenuItem(
      {Key? key, required this.itemName, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? menuController.onHover(itemName)
            : menuController.onHover("not hovering");
      },
      child: Obx(() => Container(
            color: menuController.isHovering(itemName) == true
                ? lightGrey.withOpacity(0.1)
                : Colors.transparent,
            child: Row(
              children: [
                Visibility(
                  visible: menuController.isHovering(itemName) == true ||
                    menuController.isActive(itemName) == true,
                child: Container(
                    width: 6,
                    height: 72,
                    color: dark,
                  ),
                  maintainSize: true,
                  maintainState: true,
                  maintainAnimation: true,
                ),
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(Insets.lg),
                      child: menuController.returnIconFor(itemName),
                    ),
                    if (menuController.isActive(itemName) != true)
                      Flexible(
                          child: CustomText(
                        text: itemName,
                        color: menuController.isHovering(itemName) == true
                            ? dark
                            : Colors.black87,
                      ),
                      )
                    else
                      Flexible(
                          child: CustomText(
                        text: itemName,
                        color: dark,
                        size: 18,
                        weight: FontWeight.bold,
                      ))
                  ],
                ),
              )
              ],
            ),
          ),
      ),
    );
  }
}
