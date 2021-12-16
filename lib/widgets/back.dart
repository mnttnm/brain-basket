import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/themes.dart';

class Back extends StatelessWidget {
  const Back({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    return InkWell(
      child: Text(
        '<  Back',
        style: TextStyle(fontSize: 18, color: theme.accent1),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
