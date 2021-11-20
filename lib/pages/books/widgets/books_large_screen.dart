import 'package:flutter/material.dart';
import 'package:rs_books/models/book_model.dart';
import 'package:rs_books/widgets/book_item_large.dart';
import 'package:rs_books/widgets/centered_view.dart';

class BooksLargeScreen extends StatefulWidget {
  final List<Book> books;
  const BooksLargeScreen({Key? key, required this.books}) : super(key: key);
  @override
  _BooksLargeScreenState createState() => _BooksLargeScreenState();
}

class _BooksLargeScreenState extends State<BooksLargeScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.books.length == 1 ? CenteredView(
        child: BookItem(book: widget.books[0], showDetails: true),
          )
        :
    SingleChildScrollView(
      child: Column(
       children: widget.books
                  .map((book) => BookItem(book: book, showDetails: true))
                  .toList(),
            ),
    );
  }
}
