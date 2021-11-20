import 'package:flutter/material.dart';
import 'package:rs_books/routing/routes.dart';

class MenuItemIcon extends StatelessWidget {
  final String iconLabel;
  final Color iconColor;
  final double iconSize;
  const MenuItemIcon({
    Key? key,
    required this.iconLabel,
    required this.iconColor,
    this.iconSize = 22,
  }) : super(key: key);

  IconData getIconData(String iconName) {
    switch (iconName) {
      case BooksPageRoute:
        return Icons.book_outlined;
      case AuthorsPageRoute:
        return Icons.person;
      case ContactPageRoute:
        return Icons.phone;
      case CartPageRoute:
        return Icons.shopping_cart;
      default:
        return Icons.exit_to_app;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Icon(getIconData(iconLabel), size: iconSize, color: iconColor);
  }
}
