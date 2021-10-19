import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/constants/controllers.dart';
import 'package:rs_books/controllers/cart_controller.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/models/book_model.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/widgets/cart_page.dart';

class BookItemSmall extends StatelessWidget {
  final Book book;
  BookItemSmall({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isSmallestScreen = ResponsiveWidget.isSmallestScreen(context);
    final _imageWidth =
        _isSmallestScreen ? MediaQuery.of(context).size.width * .75 : 300.0;
    final _imageHeight = _isSmallestScreen ? _imageWidth * 1.33 : 400.0;

    // return Container(child: const Text('Hello1'),);
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookTitle(title: book.title),
            BookImageContainer(
                imagePath:
                    'books/book-${book.details.isbn}/${book.images.front}',
                imageWidth: _imageWidth,
                imageHeight: _imageHeight),
            BookActions(
              book: book,
            ),
            SizedBox(
              height: 10,
            ),
            Authors(),
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

class Reviews extends StatelessWidget {
  final List<Review> reviews;
  const Reviews({
    Key? key,
    required this.reviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: IntrinsicHeight(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: reviews
                  .map((review) =>
                      ReviewItem(name: review.name, review: review.review))
                  .toList()
              //  [
              //   ReviewItem(
              //       name: 'Sit gubergren',
              //       review:
              //           'Ipsum dolores est dolore diam sadipscing ipsum diam et labore invidunt, invidunt vero sed no sit stet kasd voluptua nonumy, no sed amet sed accusam diam rebum, dolore stet aliquyam.'),
              //   VerticalDivider(
              //     indent: 40,
              //     endIndent: 40,
              //     thickness: 2,
              //   ),
              //   ReviewItem(
              //       name: 'Sit gubergren',
              //       review:
              //           'Ipsum dolores est dolore diam sadipscing ipsum diam et labore invidunt, invidunt vero sed no sit stet kasd voluptua nonumy, no sed amet sed accusam diam rebum, dolore stet aliquyam.'),
              //   VerticalDivider(
              //     indent: 40,
              //     endIndent: 40,
              //     thickness: 2,
              //   ),
              //   ReviewItem(
              //       name: 'Sit gubergren',
              //       review:
              //           'Ipsum dolores est dolore diam sadipscing ipsum diam et labore invidunt, invidunt vero sed no sit stet kasd voluptua nonumy, no sed amet sed accusam diam rebum, dolore stet aliquyam.'),
              //   VerticalDivider(
              //     indent: 40,
              //     endIndent: 40,
              //     thickness: 2,
              //   ),
              //   ReviewItem(
              //       name: 'Sit gubergren',
              //       review:
              //           'Ipsum dolores est dolore diam sadipscing ipsum diam et labore invidunt, invidunt vero sed no sit stet kasd voluptua nonumy, no sed amet sed accusam diam rebum, dolore stet aliquyam.'),
              // ],
              ),
        ),
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    Key? key,
    required this.name,
    required this.review,
  }) : super(key: key);

  final String name;
  final String review;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
              width: 200,
              child: Text(
                name.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              )),
        ),
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              width: 200,
              height: 150,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(review),
                  ],
                ),
              )),
        )
      ],
    );
  }
}

class BookActions extends StatelessWidget {
  final Book book;
  const BookActions({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Pricing(
            bookPrice: this.book.price.toDouble(),
          ),
          PurchaseOptions(
            bookId: this.book.details.isbn,
            bookName: this.book.title,
            bookPrice: this.book.price.toDouble(),
          )
        ],
      ),
    );
  }
}

class Pricing extends StatelessWidget {
  final double bookPrice;
  const Pricing({
    Key? key,
    required this.bookPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price:',
        ),
        SizedBox(
          height: 3,
        ),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: '₹ $bookPrice',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          TextSpan(text: ' '),
          TextSpan(
              text: '(₹450)',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  decorationThickness: 1.5))
        ])),
      ],
    );
  }
}

class PurchaseOptions extends StatelessWidget {
  final String bookId;
  final double bookPrice;
  final String bookName;
  const PurchaseOptions(
      {Key? key,
      required this.bookId,
      required this.bookPrice,
      required this.bookName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 150,
          child: ElevatedButton(
            onPressed: () {
              context.read<CartController>().addToCart(Product(
                  name: this.bookName, cost: bookPrice, id: this.bookId));
              menuController.changeActiveItemTo(CartPageRoute);
              navigationController.navigateTo(CartPageRoute);
            },
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Buy Now'.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 150,
          child: ElevatedButton(
            // style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white), side: MaterialStateBorderSide.resolveWith((states) => BorderSide(color:secondaryDark))),
            onPressed: () {
              print('adding to the cat');
              context.read<CartController>().addToCart(
                  Product(name: bookName, cost: bookPrice, id: bookId));
            },
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Add to Cart'.toUpperCase(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AdditionalDetails extends StatelessWidget {
  final int gridColumnCount;
  final Details bookDetails;
  final String bookDescription;
  const AdditionalDetails({
    Key? key,
    required this.gridColumnCount,
    required this.bookDetails,
    required this.bookDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(bookDescription,
                  style: Theme.of(context).textTheme.subtitle1),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Details:',
                  // style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(
                  height: 8,
                ),
                SingleChildScrollView(
                  child: GridView.count(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      primary: true,
                      mainAxisSpacing: 5,
                      crossAxisCount: ResponsiveWidget.isLargeScreen(context) ||
                              ResponsiveWidget.isMediumScreen(context)
                          ? 3
                          : 2,
                      childAspectRatio: 3,
                      crossAxisSpacing: 5,
                      children: bookDetails
                          .toJson()
                          .entries
                          .map((entry) => BookDetailItem(
                              label: entry.key, value: entry.value))
                          .toList()
                      //  <Widget>[
                      //   BookDetailItem(
                      //       label: 'dimensions',
                      //       value: "10 x 10 x 10 (L x W x H)"),
                      //   BookDetailItem(label: 'weight', value: '350 gm'),
                      //   BookDetailItem(label: 'delivery', value: '3-7 days'),
                      //   BookDetailItem(
                      //       label: 'publication', value: 'Brain Basket'),
                      //   BookDetailItem(label: 'isbn', value: 'b08sdfdsf'),
                      //   BookDetailItem(label: 'ratings', value: '4.7/5'),
                      // ],
                      ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class BookDetailItem extends StatelessWidget {
  final String label;
  final String value;
  const BookDetailItem({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label.toUpperCase(),
            // style: TextStyle(
            //   fontSize: 12,
            //   color: primaryMedium,
            // ),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 14,
                // color: Colors.blueGrey.withOpacity(0.7),
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class Authors extends StatelessWidget {
  const Authors({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Authors:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 10,
        ),
        RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            text: 'Rohit Agrawal(RA), Shubhkaran (SKC)',
            // style: TextStyle(fontSize: 14, color: secondaryDark),
          ),
        ),
      ],
    );
  }
}

class BookImageContainer extends StatelessWidget {
  const BookImageContainer(
      {Key? key,
      required double imageWidth,
      required double imageHeight,
      required String imagePath})
      : _imageWidth = imageWidth,
        _imageHeight = imageHeight,
        _imagePath = imagePath,
        super(key: key);

  final double _imageWidth;
  final double _imageHeight;
  final String _imagePath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 4,
              offset: Offset(1, 10))
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Image.asset(
            _imagePath,
            width: _imageWidth,
            height: _imageHeight,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class BookTitle extends StatelessWidget {
  final String title;
  const BookTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        style: TextStyle(
            fontSize: 20,
            // color: Colors.black.withAlpha(200),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
