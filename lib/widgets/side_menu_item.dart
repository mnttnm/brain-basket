import 'package:flutter/material.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/widgets/horizontal_menu_items.dart';
import 'package:rs_books/widgets/vertical_menu_items.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final void Function() onTap;
  const SideMenuItem({Key? key, required this.itemName, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
      return VerticalMenuItem(itemName: itemName, onTap: onTap);
  }
}
