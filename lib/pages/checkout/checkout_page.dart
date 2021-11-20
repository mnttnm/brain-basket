import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/src/provider.dart';
import 'package:rs_books/models/address_model.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/themes.dart';
import 'package:rs_books/widgets/centered_view.dart';

import 'widgets/address_form.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  void onCheckout(BuildContext context, AddressModel model) {
    context.goNamed(PaymentsPageRoute);
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    return CenteredView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back(),
          Text(
            "Shipping Details",
            style: TextStyle(
                fontSize: 18,
                color: theme.accent1,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          const Text(
            'Please fill the below form with the complete information about the shipping address and contact deatils.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(maxWidth: 800),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: theme.accent1.withOpacity(0.9), width: 2)),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddressForm(
                    onFormSubmit: onCheckout,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
