import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/data/order.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/styled_widgets/buttons/styled_buttons.dart';
import 'package:rs_books/styled_widgets/styled_spacers.dart';
import 'package:rs_books/styles.dart';
import 'package:rs_books/themes.dart';
import 'package:rs_books/widgets/centered_view.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderSuccessInfo {
  final String trackingId;
  final String contactNo;

  OrderSuccessInfo(this.trackingId, this.contactNo);
}

class OrderSuccessPage extends StatelessWidget {
  final OrderSuccessInfo orderInfo;
  const OrderSuccessPage({Key? key, required this.orderInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    return CenteredView(
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: theme.accent1.withOpacity(0.9),
              width: 2,
            ),
          ),
          padding: EdgeInsets.all(
            ResponsiveWidget.isSmallestScreen(context) == true
                ? Insets.sm
                : Insets.xl,
          ),
          constraints: const BoxConstraints(maxWidth: 700, minWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Order Successful !!",
                style: TextStyles.h2.copyWith(color: theme.accent1),
              ),
              VSpace.xs,
              Text(
                "You will receive further updates on your contact no ${orderInfo.contactNo}",
                style: const TextStyle(fontSize: 16),
              ),
              VSpace.med,
              Text(
                "Tracking link",
                style: TextStyles.h3.copyWith(color: theme.accent1),
              ),
              Link(
                orderInfo.trackingId,
                onPressed: () {
                  launch(orderInfo.trackingId);
                },
                style: TextStyle(color: Colors.blueAccent.shade400),
              )
            ],
          ),
        ),
      ),
    );
  }
}
