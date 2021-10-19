import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/constants/controllers.dart';
import 'package:rs_books/controllers/cart_controller.dart';
import 'package:rs_books/models/book_model.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/widgets/book_item_small.dart';

class BookItem extends StatelessWidget {
  final Book book;
  final bool showDetails;
  BookItem({Key? key, required this.showDetails, required this.book})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Image image = Image.asset(
      'books/book-${book.details.isbn}/${book.images.front}',
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
            // height: showDetails ? 800 : 400,
            margin: EdgeInsets.only(top: 15, right: 30, bottom: 15),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                    width: 1, color: Colors.black45, style: BorderStyle.solid)),
            child: Column(
              mainAxisSize: MainAxisSize.min, // TODO: why this is needed?
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    book.title.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 22,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'Authors: Rohit Agrawal(RA), Shubhkaran (SKC)',
                    style:
                        TextStyle(fontSize: 14, color: Colors.purple.shade300),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    book.description,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                // Spacer(),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            '₹ ${book.price}',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                      Container(
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                context.read<CartController>().addToCart(
                                    Product(
                                        name: book.title,
                                        cost: 120,
                                        id: this.book.details.isbn));
                                menuController.changeActiveItemTo(CartPageRoute);
                                navigationController.navigateTo(CartPageRoute);
                              },
                              child: Container(
                                width: 120,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(20, 20))),
                                // width: 150,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Buy Now',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                print('adding to the cart: ${book.title}');
                                context
                                    .read<CartController>()
                                    .addToCart(Product(
                                      name: this.book.title,
                                      cost: 120,
                                      id: this.book.details.isbn,
                                    ));
                              },
                              child: Container(
                                width: 120,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.red.shade400,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(20, 20))),
                                padding: EdgeInsets.only(
                                    top: 6, bottom: 6, left: 10, right: 10),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Add to cart',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
                Visibility(
                  child: Flexible(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
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
