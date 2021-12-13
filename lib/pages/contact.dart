import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/styled_widgets/styled_spacers.dart';
import 'package:rs_books/styles.dart';
import 'package:rs_books/themes.dart';

List<String> parseJson(String instructionJson) {
  final parsedObject =
      jsonDecode(instructionJson)["support-instructions"] as List;
  return parsedObject.map<String>((e) => e.toString()).toList();
}

Future<List<String>> parseInstructions() async {
  final String instructionJson = await loadInstructionJson();
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
    final bool isSmallScreen = ResponsiveWidget.isSmallScreen(context) == true;
    return FutureBuilder<List<String>>(
      future: parseInstructions(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding:
                EdgeInsets.all(isSmallScreen == true ? Insets.xs : Insets.sm),
            child: Column(
              children: [
                const Spacer(),
                Text(
                  "Please Note:",
                  style: TextStyle(
                    fontSize: 24,
                    color: theme.accent1,
                  ),
                ),
                VSpace.sm,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: theme.accent1.withOpacity(0.9),
                      width: 2,
                    ),
                  ),
                  padding: EdgeInsets.all(
                    isSmallScreen == true ? Insets.xs : Insets.med,
                  ),
                  constraints:
                      const BoxConstraints(maxWidth: 700, minWidth: 360),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: snapshot.data!
                        .map<Widget>(
                          (instruction) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '-> $instruction',
                              style: const TextStyle(
                                fontSize: 20,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.all(
                    isSmallScreen == true ? Insets.xs : Insets.med,
                  ),
                  decoration: BoxDecoration(
                    color: theme.accent1.withOpacity(0.9),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(1, 1),
                        blurRadius: 2,
                        color: Color.fromARGB(255, 247, 228, 231),
                      ),
                    ],
                  ),
                  child: Align(
                    widthFactor: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
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
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                const Spacer(),
              ],
            ),
          );
        } else {
          // print(snapshot.error);
          return const Center(
            child: Text("Error"),
          );
        }
      },
    );
  }
}
