import 'package:flutter/material.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/models/book_model.dart';
import 'package:rs_books/styled_widgets/styled_spacers.dart';
import 'package:rs_books/styles.dart';
import 'package:rs_books/widgets/book_listing_widgets.dart';

class BookItemSmall extends StatelessWidget {
  final Book book;
  const BookItemSmall({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isSmallestScreen = ResponsiveWidget.isSmallestScreen(context);
    final _imageWidth =
        _isSmallestScreen ? MediaQuery.of(context).size.width * .75 : 300.0;
    final _imageHeight = _isSmallestScreen ? _imageWidth * 1.33 : 400.0;
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(Insets.med),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookTitle(title: book.title),
            BookImageContainer(
              imagePath:
                  'assets/books/book-${book.details.isbn}/${book.images.front}',
              imageWidth: _imageWidth,
              imageHeight: _imageHeight,
            ),
            BookActions(
              book: book,
            ),
            VSpace.sm,
            const Authors(),
            AdditionalDetails(
              gridColumnCount: 2,
              bookDetails: book.details,
              bookDescription: book.description,
            ),
            Reviews(reviews: book.reviews!)
          ],
        ),
      ),
    );
  }
}
