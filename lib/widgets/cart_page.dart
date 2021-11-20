import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/constants/controllers.dart';
import 'package:rs_books/controllers/cart_controller.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/themes.dart';
import 'package:rs_books/widgets/centered_view.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    return Scaffold(body: Consumer<CartController>(
      builder: (BuildContext context, CartController cart, Widget? child) {
        return cart.products.length <= 0
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'You haven\'t added any books yet, Please grab some!',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          menuController.changeActiveItemTo(BooksPageRoute);
                          context.goNamed(BooksPageRoute);
                        },
                        child: const Text('Order Books')),
                  )
                ],
              ))
            : CenteredView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Back(),
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: theme.accent1)),
                          child: ListView.builder(
                            padding: EdgeInsets.all(10),
                            itemCount: cart.products.length,
                            itemBuilder: (BuildContext context, int index) {
                              final productList = cart.products.values.toList();
                              if (cart.products.isEmpty) {
                                return Text('no products in cart');
                              }
                              final item = productList[index];
                              return ListTile(
                                  title: Text(
                                    item.name.toUpperCase(),
                                    style: TextStyle(
                                        color: theme.accent1,
                                        fontSize: 18),
                                  ),
                                  subtitle: BookQuantityControl(
                                    product: item,
                                  ),
                                  trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            '(${item.quantity} x ${item.cost})'),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text('${item.quantity * item.cost}',
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    Colors.blueAccent.shade100))
                                      ]));
                            },
                          ),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Total:',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  children: [
                                    TextSpan(
                                        text:
                                            '${context.select((CartController c) => c.total)}',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: theme.accent1,
                                        ))
                                  ])
                            ])),
                            Spacer(),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(12)),
                                onPressed: () async {
                                  context.read<CartController>().clearCart();
                                },
                                child: const Text(
                                  'Clear Cart',
                                  style: TextStyle(fontSize: 18),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(12)),
                                onPressed: () {
                                  context.goNamed(CheckOutPageRoute);
                                },
                                child: const Text('Checkout',
                                    style: TextStyle(fontSize: 18))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    ));
  }
}

class Back extends StatelessWidget {
  const Back({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    return InkWell(
      child: Text('<  Back',
          style: TextStyle(fontSize: 18, color: theme.accent1)),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}

class BookQuantityControl extends StatelessWidget {
  final Product product;
  BookQuantityControl({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
        builder: (BuildContext context, CartController cart, Widget? child) {
      return Row(
        children: <Widget>[
          product.quantity != 0
              ? new IconButton(
                  icon: new Icon(Icons.remove),
                  onPressed: () => context
                      .read<CartController>()
                      .decreaseBookQuantity(product.id))
              : new Container(),
          new Text(product.quantity.toString()),
          new IconButton(
              icon: new Icon(Icons.add),
              onPressed: () => context
                  .read<CartController>()
                  .increaseBookQuantity(product.id))
        ],
      );
    });
  }
}
