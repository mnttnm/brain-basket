import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/api/payment_service.dart';
import 'package:rs_books/api/ship_order_service.dart';
import 'package:rs_books/controllers/address_controller.dart';
import 'package:rs_books/controllers/cart_controller.dart';
import 'package:rs_books/data/order.dart';
import 'package:rs_books/data/order_dao.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/models/address_model.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/styled_widgets/styled_spacers.dart';
import 'package:rs_books/styles.dart';
import 'package:rs_books/themes.dart';
import 'package:rs_books/widgets/centered_view.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool errorHappend = false;
  void _sendOrder(OrderDao orderDao, Order order) {
    orderDao.saveMessage(order);
  }

  Order _createOrder(String orderId, double orderTotal, AddressModel address) {
    final orderCreationTime = DateTime.now();
    final Order order = Order(
      orderId: orderId,
      orderCreationTime: orderCreationTime,
      orderTotal: orderTotal,
      address: address,
    );
    return order;
  }

  @override
  Widget build(BuildContext context) {
    final orderDao = Provider.of<OrderDao>(context, listen: false);
    final paymentService = PayementService();
    final shipOrderService = ShipOrder();
    final AppTheme theme = context.watch();

    return Consumer<CartController>(
        builder: (BuildContext context, CartController cart, Widget? child) {
      return Consumer<AddressController>(builder: (BuildContext context,
          AddressController addressController, Widget? child) {
        return CenteredView(
          child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Align(alignment: Alignment.topLeft, child: Back()),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: theme.accent1.withOpacity(0.9), width: 2)),
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    constraints: BoxConstraints(
                        maxWidth: ResponsiveWidget.isSmallestScreen(context)
                            ? 300
                            : 700),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            'Order Summary',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        VSpace(Insets.sm),
                        Flex(
                          direction: ResponsiveWidget.isSmallestScreen(context)
                              ? Axis.vertical
                              : Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Shipping Details:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: theme.accent1,
                                  ),
                                ),
                                VSpace(Insets.xs),
                                SizedBox(
                                  width: 250,
                                  child: Text(
                                    addressController.address.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                VSpace(Insets.xs),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: theme.accent1),
                                  onPressed: () {
                                    context.goNamed(CheckOutPageRoute);
                                  },
                                  child: const Text('Edit Address'),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Order Total',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: theme.accent1,
                                  ),
                                ),
                                VSpace(Insets.xs),
                                SizedBox(
                                  child: Text(
                                    '${cart.total}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      VSpace(Insets.lg),
                      Text("Pay here Using Razorpay",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      VSpace(Insets.lg),
                      ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              errorHappend = false;
                            });
                            final receiptId = '#' +
                                addressController.currentAddress!.contactNo! +
                                DateTime.now().microsecond.toString();
                            String orderId = await paymentService.createOrder(
                              cart.total,
                              receiptId,
                            );
                            if (!orderId.isEmpty) {
                              final order = _createOrder(
                                orderId,
                                cart.total,
                                addressController.currentAddress!,
                              );
                              _sendOrder(orderDao, order);
                              paymentService.executeOrder(
                                order,
                                onSuccess: () async {
                                  context.goNamed(OrderSuccessPageRoute,
                                      extra: orderId);
                                  await shipOrderService.createQuickShipment(
                                      order, cart);
                                  cart.clearCart();
                                },
                                onCancel: () {
                                  print('Order Cancelled');
                                },
                                onFailure: () {
                                  setState(() {
                                    errorHappend = true;
                                  });
                                },
                              );
                            } else {
                              setState(() {
                                errorHappend = true;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Make Payment",
                                style: TextStyle(fontSize: 24)),
                          )),
                      VSpace(Insets.sm),
                      Visibility(
                          visible: errorHappend,
                          child: const Text(
                            "Order failed, Please try again!",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ))
                    ],
                  ),
                  Spacer(),
                ],
              )),
        );
      });
    });
  }
}
