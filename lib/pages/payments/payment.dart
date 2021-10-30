import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/api/payment_service.dart';
import 'package:rs_books/constants/controllers.dart';
import 'package:rs_books/controllers/cart_controller.dart';
import 'package:rs_books/data/order.dart';
import 'package:rs_books/data/order_dao.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/pages/checkout_page.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/widgets/cart_page.dart';
import 'package:rs_books/widgets/centered_view.dart';

class Payment extends StatelessWidget {
  final dynamic args;
  const Payment({Key? key, required this.args}) : super(key: key);

  void _sendOrder(OrderDao orderDao, Order order) {
    orderDao.saveMessage(order);
  }

  @override
  Widget build(BuildContext context) {
    final orderDao = Provider.of<OrderDao>(context, listen: false);
    final paymentService = PayementService(this.args as Order);

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
                  Align(alignment: Alignment.topLeft, child: Back()),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.purpleAccent.shade100, width: 2)),
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
                        SizedBox(
                          height: 10,
                        ),
                        Flex(
                          direction: ResponsiveWidget.isSmallestScreen(context)
                              ? Axis.vertical
                              : Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (args != null) ...[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Shipping Details:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.purpleAccent.shade100,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 250,
                                    child: Text(
                                      addressController.address.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.pink),
                                    onPressed: () {
                                      navigationController.navigateTo(
                                          CheckOutPageRoute,
                                          args: {'orderAmount': cart.total});
                                    },
                                    child: const Text('Edit Address'),
                                  ),
                                ],
                              )
                            ],
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Order Total',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.purpleAccent.shade100,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
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
                      SizedBox(
                        height: 20,
                      ),
                      Text("Pay here Using Razorpay",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            _sendOrder(orderDao, this.args as Order);
                            String orderId = await paymentService.createOrder();
                            paymentService.executeOrder(
                              this.args,
                              orderId,
                              onSuccess: () {
                                cart.clearCart();
                                addressController.clearAddress();
                                navigationController.navigateTo(
                                    OrderSuccessPageRoute,
                                    args: {'orderId': orderId});
                              },
                              onCancel: () {
                                print('Order Cancelled');
                              },
                              onFailure: () {
                                print("orderFailed");
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Make Payment",
                                style: TextStyle(fontSize: 24)),
                          )),
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
