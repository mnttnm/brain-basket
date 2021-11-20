import 'package:flutter/material.dart';
import 'package:rs_books/styles.dart';

class SmallScreen extends StatelessWidget {
  final Widget child;
  const SmallScreen({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Insets.xs),
        child: child,
      ),
    );
  }
}
