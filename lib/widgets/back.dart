import 'package:flutter/material.dart';
import 'package:rs_books/styles.dart';

class Back extends StatelessWidget {
  const Back({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        '<  Back',
        style: TextStyles.h3,
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
