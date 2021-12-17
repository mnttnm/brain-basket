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
    return CenteredView(
      child: FutureBuilder(
        future: dataService.getData(),
        builder: (context, AsyncSnapshot<BrainBasketData> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return ListView(
              children: [
                if (ResponsiveWidget.isSmallestScreen(context))
                  BooksSmallScreen(books: snapshot.data?.books ?? [])
                else
                  BooksLargeScreen(books: snapshot.data?.books ?? [])
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
