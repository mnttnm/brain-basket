import 'package:flutter/widgets.dart';
import 'package:rs_books/constants/controllers.dart';
import 'package:rs_books/routing/router.dart';
import 'package:rs_books/routing/routes.dart';

Navigator localNavigator() => Navigator(
      initialRoute: BooksPageRoute,
      onGenerateRoute: generateRoute,
      key: navigationController.navigationKey,
    );
