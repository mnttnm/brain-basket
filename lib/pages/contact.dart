import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(24.0),
        decoration: BoxDecoration(
            color: Colors.deepPurple.shade300,
            // border:
            //     Border.all(color: Colors.deepPurpleAccent.shade200, width: 4),
            borderRadius: BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                blurRadius: 2,
                color: Color.fromARGB(255, 247, 228, 231),
              ),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.phone_enabled_outlined,
              color: Color.fromARGB(255, 236, 224, 234),
              size: 64,
            ),
            const SizedBox(
              height: 24,
            ),
            RichText(
              text: const TextSpan(
                text: 'Contact ',
                children: [
                  TextSpan(
                      text: '+91-9024489556',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: ' for help and support!',
                  ),
                ],
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 236, 224, 234),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
