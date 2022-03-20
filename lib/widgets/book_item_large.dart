import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/models/book_model.dart';
import 'package:rs_books/styled_widgets/styled_spacers.dart';
import 'package:rs_books/styled_widgets/ui_text.dart';
import 'package:rs_books/styles.dart';
import 'package:rs_books/themes.dart';
import 'package:rs_books/widgets/book_listing_widgets.dart';

class BookItemlarge extends StatelessWidget {
  final Book book;
  final bool showDetails;
  const BookItemlarge({Key? key, required this.showDetails, required this.book})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    final Image image = Image.asset(
      'assets/books/book-${book.details.isbn}/${book.images.front}',
      width: MediaQuery.of(context).size.width / 12 * 2,
    );
    return Card(
      margin: EdgeInsets.only(bottom: Insets.sm),
      elevation: 6,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.black54,
                    offset: Offset(2, 10),
                  )
                ],
              ),
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: image,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 15, right: 30, bottom: 15),
              padding: EdgeInsets.all(Insets.sm),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                border: Border.all(
                  color: theme.accent1,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // TODO: why this is needed?
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UiText(
                    text: book.title.toUpperCase(),
                    style: TextStyles.title2.copyWith(fontSize: FontSizes.s24),
                  ),
                  VSpace.sm,
                  UiText(
                    text: 'By: Rohit Agrawal(RA), Shubhkaran (SKC)',
                    style: TextStyles.callout1,
                  ),
                  VSpace.sm,
                  BookActions(
                    book: book,
                  ),
                  Visibility(
                    visible: showDetails,
                    child: Flexible(
                      child: Column(
                        children: [
                          VSpace.sm,
                          AdditionalDetails(
                            gridColumnCount: 3,
                            bookDetails: book.details,
                            bookDescription: book.description,
                          ),
                          if (book.reviews!.isNotEmpty) ...[
                            Reviews(reviews: book.reviews!)
                          ]
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
