import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/models/address_model.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/styled_widgets/styled_spacers.dart';
import 'package:rs_books/styles.dart';
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
    final AppTheme theme = context.watch();
    return CenteredView(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(
              ResponsiveWidget.isSmallScreen(context) ? Insets.sm : Insets.med),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back(),
                Text(
                  "Shipping Details",
                  style: TextStyles.h3,
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 800,
                  ),
                  child: Divider(
                    thickness: 2,
                    color: theme.accent1,
                  ),
                ), 
                VSpace.sm,
                Text(
                  'Please fill the below form with the complete information about the shipping address and contact deatils.',
                  style: TextStyles.body1,
                ),
                VSpace.med,
                Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  padding: EdgeInsets.all(Insets.lg),
                  child: AddressForm(
                    onFormSubmit: onCheckout,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
