import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/styled_widgets/styled_spacers.dart';
import 'package:rs_books/themes.dart';
import 'package:rs_books/widgets/centered_view.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderSuccessPage extends StatelessWidget {
  final String trackingId;
  const OrderSuccessPage({Key? key, required this.trackingId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    return CenteredView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Order Successful!!",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: theme.accent1,
            ),
          ),
          VSpace.xs,
          Wrap(
            children: [
              const Text(
                "Your order has been placed successfuly, you will receive further details on your contact no.You can track your order at",
                style: TextStyle(fontSize: 16),
              ),
              TextButton(
                onPressed: () {
                  launch(trackingId);
                },
                child: Text(
                  trackingId,
                  style: TextStyle(
                    color: theme.accent1,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
