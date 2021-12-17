import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/styles.dart';
import 'package:rs_books/themes.dart';

class SiteTitle extends StatelessWidget {
  final String siteTitle;
  final Color? color;
  const SiteTitle({Key? key, required this.siteTitle, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    return Text(
      siteTitle,
      style: TextStyles.h2.copyWith(
        color: color ?? theme.accent1,
      ),
    );
  }
}
