import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/constants/controllers.dart';
import 'package:rs_books/controllers/cart_controller.dart';
import 'package:rs_books/models/book_model.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/styled_widgets/buttons/styled_buttons.dart';
import 'package:rs_books/styled_widgets/styled_spacers.dart';
import 'package:rs_books/styled_widgets/ui_text.dart';
import 'package:rs_books/styles.dart';
import 'package:rs_books/widgets/book_item_small.dart';

class BookItem extends StatelessWidget {
  final Book book;
  final bool showDetails;
  BookItem({Key? key, required this.showDetails, required this.book})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Image image = Image.asset(
      'assets/books/book-${book.details.isbn}/${book.images.front}',
      width: MediaQuery.of(context).size.width / 12 * 2,
    );
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 6,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Container(
              decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
                BoxShadow(
                    blurRadius: 6, color: Colors.black54, offset: Offset(2, 10))
              ]),
              child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  child: image,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(top: 15, right: 30, bottom: 15),
            padding: EdgeInsets.all(Insets.sm),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                    width: 1, color: Colors.black45, style: BorderStyle.solid)),
            child: Column(
              mainAxisSize: MainAxisSize.min, // TODO: why this is needed?
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UiText(
                    text: book.title.toUpperCase(),
                    style: TextStyles.title2.copyWith(fontSize: FontSizes.s24)),
                VSpace.sm,
                UiText(
                    text: 'By: Rohit Agrawal(RA), Shubhkaran (SKC)',
                    style: TextStyles.callout1),
                Container(
                  margin: EdgeInsets.only(top: Insets.sm),
                  padding: EdgeInsets.symmetric(vertical: Insets.xs),
                  child: Text(
                    book.description,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                VSpace(Insets.xl),
                Row(
                  children: [
                    Row(
                      children: [Text('₹ ${book.price}', style: TextStyles.h2)],
                    ),
                    Container(
                      child: Row(
                        children: [
                          RoundedButton(
                            isPrimary: true,
                            label: 'Buy Now',
                            onPressed: () {
                              context.read<CartController>().addToCart(Product(
                                  name: book.title,
                                  cost: 120,
                                  id: this.book.details.isbn));
                              menuController.changeActiveItemTo(CartPageRoute);
                              context.goNamed(CartPageRoute);
                            },
                          ),
                          RoundedButton(
                            label: 'Add to Cart',
                            onPressed: () {
                              context.read<CartController>().addToCart(Product(
                                    name: this.book.title,
                                    cost: 120,
                                    id: this.book.details.isbn,
                                  ));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                Visibility(
                  child: Flexible(
                    child: Column(
                      children: [
                        VSpace(Insets.sm),
                        AdditionalDetails(
                          gridColumnCount: 3,
                          bookDetails: this.book.details,
                          bookDescription: book.description,
                        ),
                        Reviews(reviews: book.reviews!)
                      ],
                    ),
                  ),
                  visible: this.showDetails,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
