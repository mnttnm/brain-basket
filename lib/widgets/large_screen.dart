import 'package:flutter/material.dart';
import 'package:rs_books/styles.dart';

class LargeScreen extends StatelessWidget {
  final Widget child;
  const LargeScreen({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Insets.lg),
            child: child,
      ),
    );
  }
}
