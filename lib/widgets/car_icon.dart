import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/controllers/cart_controller.dart';

class CartIcon extends StatelessWidget {
  final Widget icon;

  const CartIcon({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        icon,
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: CircleAvatar(
            radius: 8.0,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            child: Consumer<CartController>(
              builder: (context, cart, child) {
                return Text(
                  cart.booksQuantity.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
