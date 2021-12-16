import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/controllers/cart_controller.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/styled_widgets/styled_spacers.dart';
import 'package:rs_books/styles.dart';
import 'package:rs_books/themes.dart';

class QuantityIconButton extends StatelessWidget {
  final void Function() onPressedFn;
  final IconData iconType;
  const QuantityIconButton({
    Key? key,
    required this.onPressedFn,
    required this.iconType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();

    return IconButton(
      padding: EdgeInsets.all(Insets.xs),
      iconSize: 20,
      constraints: const BoxConstraints(maxHeight: 24),
      onPressed: onPressedFn,
      icon: Icon(iconType),
      hoverColor: theme.accent1,
      splashRadius: 12,
    );
  }
}

class BookQuantityControl extends StatelessWidget {
  final Product product;
  const BookQuantityControl({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    return Consumer<CartController>(
      builder: (BuildContext context, CartController cart, Widget? child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!ResponsiveWidget.isLargeScreen(context)) ...[
              Text(
                'Qty:',
                style: TextStyles.body1.copyWith(
                  color: theme.greyStrong,
                ),
              )
            ],
            QuantityIconButton(
              iconType: Icons.remove,
              onPressedFn: () => context
                  .read<CartController>()
                  .decreaseBookQuantity(product.id),
            ),
            HSpace.xs,
            Text(
              product.quantity.toString(),
              style: const TextStyle(fontSize: 16),
            ),
            HSpace.xs,
            QuantityIconButton(
              iconType: Icons.add,
              onPressedFn: () => context
                  .read<CartController>()
                  .increaseBookQuantity(product.id),
            ),
          ],
        );
      },
    );
  }
}
