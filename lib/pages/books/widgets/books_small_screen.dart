import 'package:flutter/material.dart';
import 'package:rs_books/models/book_model.dart';
import 'package:rs_books/widgets/book_item_small.dart';

class BooksSmallScreen extends StatefulWidget {
  final List<Book> books;
  const BooksSmallScreen({Key? key, required this.books}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _BooksSmallScreenState createState() => _BooksSmallScreenState();
}

class _BooksSmallScreenState extends State<BooksSmallScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.books
          .map(
            (book) => BookItemSmall(
              book: book,
            ),
          )
          .toList(),
    );
  }
}
