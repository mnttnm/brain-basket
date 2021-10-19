import 'package:flutter/material.dart';
import 'package:rs_books/constants/style.dart';

class CenteredView extends StatelessWidget {
  final Widget? child;
  const CenteredView({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 600 ? true : false;
    print(
        'width x heigh ${MediaQuery.of(context).size.width} x ${MediaQuery.of(context).size.height}');
    return Container(
      decoration: BoxDecoration(gradient: bckgradnt),
      padding: EdgeInsets.symmetric(
          horizontal: isMobile == true ? 0 : 0, vertical: 5),
      alignment: Alignment.center, //Todo how is this working?
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isMobile == true ? 600 : 1200),
        child: child,
      ),
    );
  }
}
