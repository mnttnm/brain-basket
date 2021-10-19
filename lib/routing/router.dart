import 'package:flutter/material.dart';
import 'package:rs_books/pages/authors/authors.dart';
import 'package:rs_books/pages/books/books.dart';
import 'package:rs_books/pages/contact.dart';
import 'package:rs_books/pages/payments/payment.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/widgets/cart_page.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case BooksPageRoute:
      return _getPageRoute(BooksPage());
    case AuthorsPageRoute:
      return _getPageRoute(AuthorsPage());
    case ContactPageRoute:
      return _getPageRoute(ContactPage());
    case CartPageRoute:
      return _getPageRoute(CartPage());
    case PaymentsPageRoute:
      return _getPageRoute(Payment());
    default:
      return _getPageRoute(BooksPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
