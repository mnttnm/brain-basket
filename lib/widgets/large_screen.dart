import 'package:flutter/material.dart';
import 'package:rs_books/helpers/local_navigator.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: localNavigator(),
      ),
    );
  }
}
