import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/constants/controllers.dart';
import 'package:rs_books/controllers/cart_controller.dart';
import 'package:rs_books/data/models.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/styled_widgets/buttons/styled_buttons.dart';
import 'package:rs_books/styled_widgets/styled_spacers.dart';
import 'package:rs_books/themes.dart';

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
                .map(
                  (review) =>
                      ReviewItem(name: review.name, review: review.review),
                )
                .toList(),
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
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        VSpace.sm,
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
            ),
          ),
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
      margin: const EdgeInsets.only(top: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Pricing(
            bookPrice: book.price.toDouble(),
          ),
          PurchaseOptions(
            bookId: book.details.isbn,
            bookName: book.title,
            bookPrice: book.price.toDouble(),
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
        const Text(
          'Price:',
        ),
        VSpace.xs,
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '₹ $bookPrice',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const TextSpan(text: ' '),
              const TextSpan(
                text: '(₹450)',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  decorationThickness: 1.5,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class PurchaseOptions extends StatelessWidget {
  final String bookId;
  final double bookPrice;
  final String bookName;
  const PurchaseOptions({
    Key? key,
    required this.bookId,
    required this.bookPrice,
    required this.bookName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    return Flex(
      direction: ResponsiveWidget.isLargeScreen(context) == true
          ? Axis.horizontal
          : Axis.vertical,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PrimaryButton(
          onPressed: () {
            context.read<CartController>().addToCart(
                  Product(name: bookName, cost: bookPrice, id: bookId),
                );
            menuController.changeActiveItemTo(CartPageRoute);
            context.goNamed(CartPageRoute);
          },
          label: 'Buy Now',
        ),
        if (ResponsiveWidget.isLargeScreen(context) == true)
          HSpace.sm
        else
          VSpace.sm,
        SecondaryButton(
          label: 'Add to Cart',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Item added to the cart",
                  style: TextStyle(
                    color: theme.greyStrong,
                  ),
                ),
                backgroundColor: theme.accent1,
                action: SnackBarAction(
                  textColor: Colors.white,
                  label: 'GO TO CART',
                  onPressed: () {
                    context.goNamed(CartPageRoute);
                  },
                ),
                behavior: SnackBarBehavior.floating,
                width: 400,
              ),
            );
            context.read<CartController>().addToCart(
                  Product(
                    name: bookName,
                    cost: bookPrice,
                    id: bookId,
                  ),
                );
          },
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
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                bookDescription,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Details:',
                  // style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                VSpace.sm,
                SingleChildScrollView(
                  child: GridView.count(
                    physics: const ScrollPhysics(),
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
                        .map(
                          (entry) => BookDetailItem(
                            label: entry.key,
                            value: entry.value as String,
                          ),
                        )
                        .toList(),
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

  IconData getIconForEntry(String entry) {
    switch (entry.toLowerCase()) {
      case "pages":
        return Icons.pages_outlined;
      case "language":
        return Icons.language_outlined;
      case "shipping":
        return Icons.local_shipping_outlined;
      case "publication":
        return Icons.corporate_fare_outlined;
      case "isbn":
        return Icons.code_outlined;
      case "ratings":
        return Icons.star_outline_outlined;
      default:
        return Icons.list_alt;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(getIconForEntry(label)),
              HSpace.xs,
              Text(
                label.toUpperCase(),
              ),
            ],
          ),
          VSpace.xs,
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
        const Text(
          'By:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        HSpace.sm,
        Expanded(
          child: RichText(
            textAlign: TextAlign.left,
            text: const TextSpan(
              text: 'Rohit Agrawal(RA), Shubhkaran (SKC)',
              // style: TextStyle(fontSize: 14, color: secondaryDark),
            ),
          ),
        ),
      ],
    );
  }
}

class BookImageContainer extends StatelessWidget {
  const BookImageContainer({
    Key? key,
    required double imageWidth,
    required double imageHeight,
    required String imagePath,
  })  : _imageWidth = imageWidth,
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
        margin: const EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 4,
              offset: const Offset(1, 10),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
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
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        // color: Colors.black.withAlpha(200),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
