import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rs_books/constants/style.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/widgets/car_icon.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = BooksPageRoute.obs;
  var hoverItem = "".obs;

  void changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  void onHover(String itemName) {
    if (isActive(itemName) != true) {
      hoverItem.value = itemName;
    }
  }

  bool isActive(String itemName) {
    return activeItem.value == itemName;
  }

  bool isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case BooksPageRoute:
        return _customIcon(Icons.book_outlined, itemName);
      case AuthorsPageRoute:
        return _customIcon(Icons.person, itemName);
      case ContactPageRoute:
        return _customIcon(Icons.phone, itemName);
      case CartPageRoute:
        return CartIcon(
            icon: _customIcon(Icons.shopping_cart, itemName, size: 32));
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName, {double? size = 22}) {
    if (isActive(itemName) == true) return Icon(icon, size: size, color: dark);
    return Icon(
      icon,
      color: isHovering(itemName) == true ? dark : lightGrey,
      size: size,
    );
  }
}
