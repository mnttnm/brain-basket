import 'package:flutter/material.dart';
import 'package:rs_books/models/author_model.dart';
import 'package:rs_books/pages/authors/widgets/author_item.dart';

class AuthorslargeScreen extends StatelessWidget {
  final List<Author> authors;
  const AuthorslargeScreen({Key? key, required this.authors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _boxWidth = MediaQuery.of(context).size.width / 3;
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: authors
            .map((author) => AuthorItem(
                  name: 'author.name ${author.shortName!.toUpperCase()}}',
                  authorDetails: author.about,
                  containerWidth: _boxWidth,
                  image: 'assets/images/authors/${author.shortName}-image.jpeg',
                  socialLinks: author.socialLinks,
                ),
          )
          .toList(),
    );
  }
}
