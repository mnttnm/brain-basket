import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      // alignment: Alignment.center,
      child: Image.asset(
        'backgrounds/chemistry-2.jpeg',
        width: 1980,
        fit: BoxFit.fill,
        color: Colors.grey.shade400.withOpacity(0.6),
        colorBlendMode: BlendMode.srcATop,
      ),
    );
  }
}
