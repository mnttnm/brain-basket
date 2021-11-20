import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:rs_books/routing/router.dart';
import 'package:rs_books/routing/routes.dart';

dynamic getRouter(BuildContext context) {
  final GoRouter _router = GoRouter(
      routes: generateRoute(context),
      errorPageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: const Center(
        child: Text("Error Page"),
            ),
          ),
      initialLocation: '/$BooksPageRoute',
  );

  return MaterialApp.router(
    routeInformationParser: _router.routeInformationParser,
    routerDelegate: _router.routerDelegate,
  );
}
