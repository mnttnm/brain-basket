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
import 'package:rs_books/widgets/centered_view.dart';

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
    return CenteredView(
      child: SingleChildScrollView(
        child: FutureBuilder<List<String>>(
          future: parseInstructions(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VSpace.med,
                    Text(
                      "Please Note:",
                      style: TextStyles.h3,
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
                        ResponsiveWidget.isSmallestScreen(context)
                            ? Insets.sm
                            : Insets.lg,
                      ),
                      constraints:
                          const BoxConstraints(maxWidth: 700, minWidth: 360),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: snapshot.data!
                            .map<Widget>(
                              (instruction) => Padding(
                                padding: EdgeInsets.all(
                                  Insets.sm,
                                ),
                                child: Text(
                                  '-> $instruction',
                                  style: TextStyles.body2.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    VSpace.lg,
                    Container(
                      margin: EdgeInsets.only(
                        top: Insets.med,
                      ),
                      width: 700,
                      padding: EdgeInsets.all(
                        Insets.lg,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.phone_enabled_outlined,
                              color: Color.fromARGB(255, 236, 224, 234),
                              size: 64,
                            ),
                            VSpace.lg,
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
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            VSpace.lg,
                          ],
                        ),
                      ),
                    ),
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
        ),
      ),
    );
  }
}
