import 'package:flutter/material.dart';

import '../authors.dart';

class AuthorsSmallScreen extends StatelessWidget {
  const AuthorsSmallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _boxWidth = MediaQuery.of(context).size.width - 20;
    return SingleChildScrollView(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Author(
          image: 'assets/images/authors/rohit-image.jpeg',
          name: 'Rohit Agrawal(RA)',
          authorDetails:
              "Rohit Agrawal, the author, is Joint Director and HOD In Organic Chemistry department, Nucleus Kota (Exp. 10 years) popularly known as RA Sir. His teaching impact on students is not for a year but for a life time. According to students, he possesses some magical intuitive ability to visualize the mechanism of every chemical reaction. He has developed his own tools to deliver the subject in very easy manner.  He believes that \"LEARNING is an opportunity to grow emotionally, mentally and spiritually, and so it's better done by enjoying.\" He is the mentor of AIR 10,12,18,19,27 and many more in IIT-JEE.",
          containerWidth: _boxWidth,
        ),
        Author(
          image: 'assets/images/authors/skc-image.jpeg',
          name: 'Shubh Karan Chaudhary(SKC)',
          authorDetails:
              "I am not going to change the world but I guarantee that i will spark the brains that will change the world” asserts brand name of kota,  Shubhkaran Choudhary (SKC Sir), #1 educator on Unacademy, Ex. Vice president Sarottam Kota (Exp. 12 years). A genius of organic chemistry, a versatile personality with the teaching experience of more than a decade. His inspirational and enthusiastic teaching style helps swell the ranks of achievements among the medical aspirants. He is also the mentor of Rishav Raj (AIR 6), Somal Agrawal (AIR 9) and so many students",
          containerWidth: _boxWidth,
        ),
      ]),
    );
  }
}
