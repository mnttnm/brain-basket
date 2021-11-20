import 'package:flutter/material.dart';
import 'package:rs_books/api/brain_basket_service.dart';
import 'package:rs_books/data/brain_basket.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/pages/authors/widgets/authors_large_screen.dart';
import 'package:rs_books/pages/authors/widgets/authors_small_screen.dart';

class AuthorsPage extends StatelessWidget {
  AuthorsPage({Key? key}) : super(key: key);
  final dataService = BrainBasketDataService();

  @override
  Widget build(BuildContext context) {
      return FutureBuilder(
        future: dataService.getData(),
        builder: (context, AsyncSnapshot<BrainBasketData> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return ResponsiveWidget.isLargeScreen(context)
                ? AuthorslargeScreen(authors: snapshot.data?.authors ?? [])
                : AuthorsSmallScreen(authors: snapshot.data?.authors ?? []);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
    );
  }
}
