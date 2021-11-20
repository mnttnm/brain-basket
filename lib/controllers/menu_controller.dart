import 'package:get/get.dart';
import 'package:rs_books/routing/routes.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  final activeItem = BooksPageRoute.obs;
  final hoverItem = "".obs;

  // ignore: use_setters_to_change_properties
  void changeActiveItemTo(String itemName) => activeItem.value = itemName;

  void onHover(String itemName) {
    if (isActive(itemName) != true) {
      hoverItem.value = itemName;
    }
  }

  bool isActive(String itemName) {
    return activeItem.value == itemName;
  }

  bool isHovering(String itemName) => hoverItem.value == itemName;
}
