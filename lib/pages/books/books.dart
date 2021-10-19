import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/models/book_model.dart';
import 'package:rs_books/pages/books/widgets/books_large_screen.dart';
import 'package:rs_books/pages/books/widgets/books_small_screen.dart';
import 'package:rs_books/widgets/centered_view.dart';

List<Book> parseJson(String booksJson) {
  final parsed = jsonDecode(booksJson)['books'].cast<Map<String, dynamic>>();
  return parsed.map<Book>((booksJson) => Book.fromJson(booksJson)).toList();
}

Future<List<Book>> parseBooks() async {
  String booksJson = await loadBooksAssets();
  return compute(parseJson, booksJson);
}

Future<String> loadBooksAssets() async {
  return await rootBundle.loadString('assets/resources/books.json');
}

class BooksPage extends StatelessWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Book>>(
            future: parseBooks(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('error ${snapshot.error}');
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
                        BooksLargeScreen(books: snapshot.data!)
                      else
                        BooksSmallScreen(books: snapshot.data!)
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
