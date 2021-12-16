import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/constants/controllers.dart';
import 'package:rs_books/controllers/cart_controller.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/styled_widgets/buttons/styled_buttons.dart';
import 'package:rs_books/styled_widgets/styled_spacers.dart';
import 'package:rs_books/styles.dart';
import 'package:rs_books/themes.dart';
import 'package:rs_books/widgets/book_quantity_controller.dart';
import 'package:rs_books/widgets/centered_view.dart';

class CartHeaderItem extends StatelessWidget {
  final String headerLabel;
  const CartHeaderItem({Key? key, required this.headerLabel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    return Padding(
      padding: EdgeInsets.all(Insets.sm),
      child: Text(
        headerLabel.toUpperCase(),
        style: TextStyles.title2.copyWith(
          color: theme.greyMedium,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class CartTable extends StatelessWidget {
  final List<Product> products;
  const CartTable({Key? key, required this.products}) : super(key: key);

  List<TableRow> getCartEntries(List<Product> products, BuildContext context) {
    final AppTheme theme = context.watch();
    final List<TableRow> tableEntries = [];
    tableEntries.add(
      const TableRow(
        children: <Widget>[
          CartHeaderItem(
            headerLabel: 'Product',
          ),
          CartHeaderItem(
            headerLabel: 'Price',
          ),
          CartHeaderItem(
            headerLabel: 'Quantity',
          ),
          CartHeaderItem(
            headerLabel: 'Total',
          ),
        ],
      ),
    );

    for (final product in products) {
      final TableRow rowItem = TableRow(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(
              Insets.sm,
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/books/book-${product.id}/front.jpeg',
                  fit: BoxFit.cover,
                  width: 75,
                  height: 100,
                ),
                HSpace.sm,
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 400,
                  ),
                  child: Text(
                    product.name.toUpperCase(),
                    style: TextStyles.h3,
                  ),
                ),
              ],
            ),
          ),
          Text(
            product.cost.toString(),
            textAlign: TextAlign.center,
            style: TextStyles.title1.copyWith(color: theme.greyStrong),
          ),
          BookQuantityControl(
            product: product,
          ),
          Text(
            '${product.cost * product.quantity}',
            textAlign: TextAlign.center,
            style: TextStyles.title1,
          ),
        ],
      );
      tableEntries.add(rowItem);
    }
    return tableEntries;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Table(
        // border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(4),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FlexColumnWidth(),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: getCartEntries(products, context),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.item,
    required this.theme,
  }) : super(key: key);

  final Product item;
  final AppTheme theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/books/book-${item.id}/front.jpeg',
          fit: BoxFit.cover,
          width: 75,
          height: 100,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VSpace.sm,
            Text(
              item.name.toUpperCase(),
              style: TextStyle(
                color: theme.accent1,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BookQuantityControl(
              product: item,
            ),
            Column(
              children: [
                VSpace.sm,
                Text(
                  '₹ ${item.quantity * item.cost}',
                  style: TextStyles.h3.copyWith(
                    color: theme.greyMedium,
                  ),
                ),
                VSpace.xs,
                Text(
                  '(${item.quantity} x ₹${item.cost})',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    final bool isSmallScreen = ResponsiveWidget.isLargeScreen(context) != true;
    return Scaffold(
      body: Consumer<CartController>(
        builder: (BuildContext context, CartController cart, Widget? child) {
          return cart.products.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "You haven't added any books yet, Please grab some!",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PrimaryButton(
                          onPressed: () {
                            menuController.changeActiveItemTo(BooksPageRoute);
                            context.goNamed(BooksPageRoute);
                          },
                          label: 'Order Books',
                        ),
                      ),
                    ],
                  ),
                )
              : CenteredView(
                  child: Card(
                    margin: EdgeInsets.all(
                      isSmallScreen == true ? Insets.sm : Insets.lg,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                        isSmallScreen == true ? Insets.xs : Insets.med,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          VSpace.xs,
                          Text(
                            'Shopping Cart',
                            style: TextStyles.h3,
                          ),
                          Divider(
                            thickness: 2,
                            color: theme.accent1,
                          ),
                          // const CartHeader(),
                          if (ResponsiveWidget.isLargeScreen(context)) ...[
                            Container(
                              margin: EdgeInsets.all(Insets.med),
                              child: CartTable(
                                products: cart.products.values.toList(),
                              ),
                            ),
                          ] else ...[
                            ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.all(
                                isSmallScreen == true ? Insets.xs : Insets.sm,
                              ),
                              itemCount: cart.products.length,
                              itemBuilder: (BuildContext context, int index) {
                                final productList =
                                    cart.products.values.toList();
                                final item = productList[index];
                                return CartItem(item: item, theme: theme);
                              },
                            )
                          ],
                          VSpace.lg,
                          Padding(
                            padding: EdgeInsets.only(
                              right:
                                  isSmallScreen == true ? Insets.sm : Insets.lg,
                            ),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'SUBTOTAL:',
                                      style: TextStyles.body1,
                                      children: [
                                        TextSpan(
                                          text:
                                              ' ₹ ${context.select((CartController c) => c.total)}',
                                          style: TextStyles.h3,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              // horizontal: Insets.lg,
                              vertical: Insets.sm,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Spacer(),
                                PrimaryButton(
                                  onPressed: () async {
                                    context.read<CartController>().clearCart();
                                  },
                                  label: 'Clear Cart',
                                  backgroundColor: theme.focus.withOpacity(0.7),
                                ),
                                HSpace.sm,
                                PrimaryButton(
                                  onPressed: () {
                                    context.goNamed(CheckOutPageRoute);
                                  },
                                  label: 'Checkout',
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}