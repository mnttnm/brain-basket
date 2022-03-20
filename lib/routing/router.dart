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
      pageBuilder: (context, state) {
        menuController.changeActiveItemTo(BooksPageRoute);
        return MaterialPage<void>(
          key: state.pageKey,
          child: BooksPage(),
        );
      },
    ),
    GoRoute(
      name: BooksPageRoute,
      path: getPathStrForRoute(BooksPageRoute),
      pageBuilder: (context, state) {
        menuController.changeActiveItemTo(BooksPageRoute);
        return MaterialPage<void>(
          key: state.pageKey,
          child: BooksPage(),
        );
      },
    ),
    GoRoute(
      name: ContactPageRoute,
      path: getPathStrForRoute(ContactPageRoute),
      pageBuilder: (context, state) {
        menuController.changeActiveItemTo(ContactPageRoute);
        return MaterialPage<void>(
          key: state.pageKey,
          child: const ContactPage(),
        );
      },
    ),
    GoRoute(
      name: AuthorsPageRoute,
      path: getPathStrForRoute(AuthorsPageRoute),
      pageBuilder: (context, state) {
        menuController.changeActiveItemTo(AuthorsPageRoute);
        return MaterialPage<void>(
          key: state.pageKey,
          child: AuthorsPage(),
        );
      },
    ),
    GoRoute(
      name: CartPageRoute,
      path: getPathStrForRoute(CartPageRoute),
      pageBuilder: (context, state) {
        menuController.changeActiveItemTo(CartPageRoute);
        return MaterialPage<void>(
          key: state.pageKey,
          child: CartPage(),
        );
      },
    ),
    GoRoute(
      name: PaymentsPageRoute,
      path: getPathStrForRoute(PaymentsPageRoute),
      pageBuilder: (context, state) =>
          MaterialPage<void>(key: state.pageKey, child: const Payment()),
    ),
    GoRoute(
      name: CheckOutPageRoute,
      path: getPathStrForRoute(CheckOutPageRoute),
      pageBuilder: (context, state) =>
          MaterialPage<void>(key: state.pageKey, child: const CheckoutPage()),
    ),
    GoRoute(
      name: OrderSuccessPageRoute,
      path: getPathStrForRoute(OrderSuccessPageRoute),
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: OrderSuccessPage(
          orderInfo: state.extra! as OrderSuccessInfo,
        ),
      ),
    ),
  ];
}
