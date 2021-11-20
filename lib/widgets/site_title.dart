import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:rs_books/themes.dart';
import 'package:rs_books/widgets/custom_text.dart';

class SiteTitle extends StatelessWidget {
  final String siteTitle;
  final Color? color;
  const SiteTitle({Key? key, required this.siteTitle, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    return CustomText(
      text: "Brain Basket",
      size: 20,
      weight: FontWeight.bold,
      color: color ?? theme.accent1,
    );
  }
}
