import 'package:flutter/material.dart';
import 'package:rs_books/constants/style.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/pages/authors/widgets/authors_large_screen.dart';
import 'package:rs_books/pages/authors/widgets/authors_small_screen.dart';

class Author extends StatelessWidget {
  final String name;
  final String image;
  final String authorDetails;
  final double containerWidth;
  const Author(
      {Key? key,
      required this.image,
      required this.authorDetails,
      required this.name,
      required this.containerWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 80,
        ),
        Image.asset( //TODO how best to be represented?
          image,
          width: 300,
          height: 310,
          fit: BoxFit.fill,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          IconButton(onPressed: (){}, icon: Icon(Icons.facebook_outlined, color: Colors.pinkAccent.shade700)),
          IconButton(onPressed: (){}, icon: Icon(Icons.facebook_outlined, color: Colors.blueAccent.shade400,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.facebook_outlined, color: Colors.purpleAccent.shade400))
        ],),
        // SizedBox(height: 10,),
        Container(
            width: 600,
            height: 400,
            padding: EdgeInsets.all(40.0),
            child: Text(
              authorDetails,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  wordSpacing: 5,
                  height: 1.5),
            )),
      ],
    );
  }
}

class AuthorsPage extends StatelessWidget {
  const AuthorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isLargeScreen(context)
        ? AuthorslargeScreen()
        : AuthorsSmallScreen();
  }
}
