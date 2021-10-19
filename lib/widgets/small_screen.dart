import 'package:flutter/material.dart';
import 'package:rs_books/helpers/local_navigator.dart';

class SmallScreen extends StatelessWidget {
  const SmallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:5.0),
        child: localNavigator(),
      ),
    );
  }
}
