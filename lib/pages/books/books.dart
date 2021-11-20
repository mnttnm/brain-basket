import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rs_books/api/brain_basket_service.dart';
import 'package:rs_books/data/brain_basket.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/pages/books/widgets/books_large_screen.dart';
import 'package:rs_books/pages/books/widgets/books_small_screen.dart';
import 'package:rs_books/widgets/centered_view.dart';
class BooksPage extends StatelessWidget {
  BooksPage({Key? key}) : super(key: key);
  final dataService = BrainBasketDataService();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: dataService.getData(),
            builder: (context, AsyncSnapshot<BrainBasketData> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                return CenteredView(
                  child: Column(children: [
                    Expanded(
                        child: ListView(children: [
                      if (ResponsiveWidget.isLargeScreen(context) ||
                          ResponsiveWidget.isMediumScreen(context))
                        BooksLargeScreen(books: snapshot.data?.books ?? [])
                      else
                        BooksSmallScreen(books: snapshot.data?.books ?? [])
                    ]))
                  ]),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
