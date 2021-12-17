// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/styles.dart';

class CenteredView extends StatelessWidget {
  final Widget? child;
  const CenteredView({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final isMobile = ResponsiveWidget.isSmallestScreen(context);
    return Padding(
      padding: EdgeInsets.all(Insets.med),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isMobile == true
                        ? max(MediaQuery.of(context).size.width * .9, 360)
                        : 1200,),
          child: child,
        ),
      ),
    );
  }
}
