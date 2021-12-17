import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/constants/controllers.dart';
import 'package:rs_books/styled_widgets/styled_spacers.dart';
import 'package:rs_books/styles.dart';
import 'package:rs_books/themes.dart';
import 'package:rs_books/widgets/custom_text.dart';
import 'package:rs_books/widgets/menu_item_icon.dart';

class HorizontalMenuItem extends StatelessWidget {
  final String itemName;
  final void Function() onTap;
  const HorizontalMenuItem({
    Key? key,
    required this.itemName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    final Color linkColor = theme.surface1;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: onTap,
        onHover: (value) {
          value
              ? menuController.onHover(itemName)
              : menuController.onHover("not hovering");
        },
        child: Obx(
          () => Container(
            //todo: This is not proper way to set the bootom border effect, \
            //todo: without height, the border is getting mixed with the bottom body.

            height: 60,
            // padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: menuController.isHovering(itemName) == true ||
                    menuController.isActive(itemName) == true
                ? BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 6, color: theme.surface1),
                    ),
                  )
                : null,
            child: Row(
              children: [
                MenuItemIcon(iconLabel: itemName, iconColor: linkColor),
                HSpace(Insets.sm),
                CustomText(text: itemName, color: linkColor)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
