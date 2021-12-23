import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rs_books/constants/controllers.dart';
import 'package:rs_books/pages/authors/authors.dart';
import 'package:rs_books/pages/books/books.dart';
import 'package:rs_books/pages/checkout/checkout_page.dart';
import 'package:rs_books/pages/contact.dart';
import 'package:rs_books/pages/order_success_page.dart';
import 'package:rs_books/pages/payments/payment.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/widgets/cart_page.dart';

List<GoRoute> generateRoute(BuildContext context) {
  return [
    GoRoute(
      path: '/',
      builder: (context, state) {
        menuController.changeActiveItemTo(BooksPageRoute);
        return BooksPage();
      },
    ),
    GoRoute(
      name: BooksPageRoute,
      path: getPathStrForRoute(BooksPageRoute),
      builder: (context, state) {
        menuController.changeActiveItemTo(BooksPageRoute);
        return BooksPage();
      },
    ),
    GoRoute(
      name: ContactPageRoute,
      path: getPathStrForRoute(ContactPageRoute),
      builder: (context, state) {
        menuController.changeActiveItemTo(ContactPageRoute);
        return const ContactPage();
      },
    ),
    GoRoute(
      name: AuthorsPageRoute,
      path: getPathStrForRoute(AuthorsPageRoute),
      builder: (context, state) {
        menuController.changeActiveItemTo(AuthorsPageRoute);
        return AuthorsPage();
      },
    ),
    GoRoute(
      name: CartPageRoute,
      path: getPathStrForRoute(CartPageRoute),
      builder: (context, state) {
        menuController.changeActiveItemTo(CartPageRoute);
        return CartPage();
      },
    ),
    GoRoute(
      name: PaymentsPageRoute,
      path: getPathStrForRoute(PaymentsPageRoute),
      builder: (context, state) {
        return const Payment();
      },
    ),
    GoRoute(
      name: CheckOutPageRoute,
      path: getPathStrForRoute(CheckOutPageRoute),
      builder: (context, state) {
        return const CheckoutPage();
      },
    ),
    GoRoute(
      name: OrderSuccessPageRoute,
      path: getPathStrForRoute(OrderSuccessPageRoute),
      builder: (context, state) {
        return OrderSuccessPage(
          trackingId: state.extra! as String,
        );
      },
    ),
  ];
}
