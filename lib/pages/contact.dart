import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/src/provider.dart';
import 'package:rs_books/themes.dart';

List<String> parseJson(String instructionJson) {
  final parsedObject =
      jsonDecode(instructionJson)["support-instructions"] as List;
  return parsedObject.map<String>((e) => e.toString()).toList();
}

Future<List<String>> parseInstructions() async {
  String instructionJson = await loadInstructionJson();
  return compute(parseJson, instructionJson);
}

Future<String> loadInstructionJson() async {
  final String jsonStr =
      await rootBundle.loadString('assets/resources/support-instructions.json');
  return jsonStr;
}

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    return FutureBuilder<List<String>>(
      future: parseInstructions(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  "Please Note:",
                  style: TextStyle(
                    fontSize: 24,
                    color: theme.accent1
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: theme.accent1.withOpacity(0.9), width: 2)),
                  padding: EdgeInsets.all(20),
                  constraints: BoxConstraints(maxWidth: 700),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: snapshot.data!
                        .map<Widget>((instruction) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '-> $instruction',
                                style:
                                    TextStyle(fontSize: 20, letterSpacing: 1.2),
                              ),
                        ))
                        .toList(),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                      color: theme.accent1.withOpacity(0.9),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(1, 1),
                          blurRadius: 2,
                          color: Color.fromARGB(255, 247, 228, 231),
                        ),
                      ]),
                  child: Align(
                    alignment: Alignment.center,
                    widthFactor: 1,
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
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold)),
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
                ),
                Spacer(),
              ],
            ),
          );
        } else {
          print(snapshot.error);
          return const Center(
            child: const Text("Error"),
          );
        }
      },
    );
  }
}
