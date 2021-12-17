import 'package:flutter/material.dart';
import 'package:rs_books/data/models.dart';
import 'package:rs_books/pages/authors/widgets/author_item.dart';
import 'package:rs_books/styles.dart';

class AuthorsSmallScreen extends StatelessWidget {
  final List<Author> authors;
  const AuthorsSmallScreen({Key? key, required this.authors}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _boxWidth = MediaQuery.of(context).size.width - 20;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: Insets.xl,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: authors
              .map(
                (author) => AuthorItem(
                  name: '${author.name} [${author.shortName!.toUpperCase()}]',
                  authorDetails: author.about,
                  containerWidth: _boxWidth,
                  image: 'assets/images/authors/${author.shortName}-image.jpeg',
                  socialLinks: author.socialLinks,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
