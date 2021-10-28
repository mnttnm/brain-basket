import 'package:flutter/material.dart';
import 'package:rs_books/pages/authors/authors.dart';
import 'package:rs_books/pages/books/books.dart';
import 'package:rs_books/pages/contact.dart';
import 'package:rs_books/pages/order_success_page.dart';
import 'package:rs_books/pages/payments/payment.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/widgets/cart_page.dart';
import 'package:rs_books/pages/checkout_page.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  print('setting: $settings');
  switch (settings.name) {
    case BooksPageRoute:
      return _getPageRoute(BooksPage(), settings.name!);
    case AuthorsPageRoute:
      return _getPageRoute(AuthorsPage(), settings.name!);
    case ContactPageRoute:
      return _getPageRoute(ContactPage(), settings.name!);
    case CartPageRoute:
      return _getPageRoute(CartPage(), settings.name!);
    case PaymentsPageRoute:
      return _getPageRoute(
          Payment(
            args: settings.arguments,
          ),
          settings.name!);
    case CheckOutPageRoute:
      return _getPageRoute(CheckoutPage(), settings.name!);
    case OrderSuccessPageRoute:
      return _getPageRoute(
          OrderSuccessPage(
            orderID: "123",
          ),
          settings.name!);
        
    default:
      return _getPageRoute(BooksPage(), settings.name!);
  }
}

PageRoute _getPageRoute(Widget child, String routeName) {
  return MaterialPageRoute(
      builder: (context) => child,
      settings: RouteSettings(
        name: routeName,
      ));
}
