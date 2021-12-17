import 'package:flutter/material.dart';
import 'package:rs_books/models/product_model.dart';

class CartController with ChangeNotifier {
  Map<String, Product> products = {};

  double get total {
    double total = 0.0;
    for (final product in products.values) {
      total = total + (product.cost * product.quantity);
    }
    return total;
  }

  int get booksQuantity {
    int totalQuantity = 0;
    for (final book in products.values.toList()) {
      totalQuantity = totalQuantity + book.quantity;
    }
    return totalQuantity;
  }

  void increaseBookQuantity(String productId) {
    products.update(productId, (value) {
      value.quantity = value.quantity + 1;
      return value;
    });
    notifyListeners();
  }

  void decreaseBookQuantity(String productId) {
    products.update(productId, (value) {
      value.quantity = value.quantity - 1;
      return value;
    });
    if (products[productId]!.quantity == 0) {
      products.remove(productId);
    }
    notifyListeners();
  }

  void addToCart(Product product) {
    products.update(product.id, (value) {
      value.quantity = value.quantity + 1;
      return value;
    },
      ifAbsent: () => products.putIfAbsent(product.id, () => product),
    );
    notifyListeners();
  }

  void clearCart() {
    products.clear();
    notifyListeners();
  }

  void removeFromCart(String productId) {
    products.remove(productId);
    notifyListeners();
  }
}
