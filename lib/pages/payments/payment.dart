import 'dart:convert';
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rs_books/constants/controllers.dart';
import 'package:rs_books/controllers/cart_controller.dart';
import 'package:rs_books/data/order.dart';
import 'package:rs_books/data/order_dao.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/models/address_model.dart';
import 'package:rs_books/pages/checkout_page.dart';
import 'package:rs_books/pages/payments/widgets/payment_detail.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/widgets/cart_page.dart';
import 'package:rs_books/widgets/centered_view.dart';

class Payment extends StatelessWidget {
  final Object? args;
  const Payment({Key? key, this.args}) : super(key: key);

  void _sendOrder(OrderDao orderDao) {
    final order = Order(
      orderCreationTime: DateTime.now(),
      orderTotal: 400,
      orderId: "12345",
      address: AddressModel(
          address1: "sdf",
          address2: "sdfadf",
          contactNo: "7022601039",
          email: "mohit@gmail.com",
          name: "mohit tater",
          pincode: "313205"),
    );
    orderDao.saveMessage(order);
  }

  @override
  Widget build(BuildContext context) {
    final orderDao = Provider.of<OrderDao>(context, listen: false);

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
                                      navigationController
                                          .navigateTo(CheckOutPageRoute);
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
                  // Flexible(
                  //   flex: 2,
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       SizedBox(
                  //         height: 10,
                  //       ),
                  //       Text("Payment by Bank or UPI transfer",
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.bold, fontSize: 20)),
                  //       SizedBox(
                  //         height: 10,
                  //       ),
                  //       SizedBox(
                  //         height: 12,
                  //       ),
                  //       Flex(
                  //         direction: ResponsiveWidget.isLargeScreen(context)
                  //             ? Axis.horizontal
                  //             : Axis.vertical,
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         children: [
                  //           Column(
                  //             children: [
                  //               const PaymentDetailItem(
                  //                 label: "UPI ID",
                  //                 value: "rohit@upi",
                  //               ),
                  //               const PaymentDetailItem(
                  //                 label: "Account Name",
                  //                 value: "Rohit Agrawal",
                  //               ),
                  //               const PaymentDetailItem(
                  //                 label: "Bank",
                  //                 value: "HDFC Bank, Kota",
                  //               ),
                  //               const PaymentDetailItem(
                  //                 label: "Account N o",
                  //                 value: "123456789",
                  //               ),
                  //               const PaymentDetailItem(
                  //                 label: "IFSC Code",
                  //                 value: "HDFC0000830",
                  //               ),
                  //             ],
                  //           ),
                  //           Column(
                  //             children: [
                  //               Image.asset(
                  //                 'assets/upi-qr.jpeg',
                  //                 width: 300,
                  //                 height: 300,
                  //               ),
                  //               SizedBox(
                  //                 height: 10,
                  //               ),
                  //               Text(
                  //                 "rohit@upi",
                  //                 style: TextStyle(
                  //                     fontWeight: FontWeight.bold,
                  //                     fontSize: 22),
                  //               )
                  //             ],
                  //           )
                  //         ],
                  //       ),
                  //       SizedBox(
                  //         height: 10,
                  //       ),
                  //       Text(
                  //           "Please enter the transaction ID and complete the order",
                  //           style: TextStyle(fontSize: 16)),
                  //       SizedBox(
                  //         height: 10,
                  //       ),
                  //       Row(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           SizedBox(
                  //             width: 300,
                  //             child: Padding(
                  //               padding: const EdgeInsets.symmetric(
                  //                   horizontal: 8, vertical: 8),
                  //               child: TextField(
                  //                 decoration: const InputDecoration(
                  //                     labelText: 'Enter your transacion ID',
                  //                     border: OutlineInputBorder(),
                  //                     hintText: 'Transaction ID'),
                  //               ),
                  //             ),
                  //           ),
                  //           ElevatedButton(
                  //             onPressed: () {
                  //               _sendOrder(orderDao);
                  //               navigationController
                  //                   .navigateTo(OrderSuccessPageRoute);
                  //             },
                  //             child: Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: const Text(
                  //                 "Complete Order",
                  //                 style: TextStyle(fontSize: 16),
                  //               ),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Divider(height: 2, color: Colors.red),
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
                            String username = 'rzp_test_mmvDFiAwZW0q7S';
                            String password = 'UZVtRMbK1OcMvUgvmykFj9vZ';
                            String basicAuth = 'Basic ' +
                                base64Encode(
                                    utf8.encode('$username:$password'));
                            print(basicAuth);
                            var paymentRequestBody = {
                              'amount': context
                                  .read<CartController>()
                                  .total, // amount in the smallest currency unit
                              'currency': "INR",
                              'receipt':
                                  "book_order_" + DateTime.now().toString()
                            };

                            try {
                              var response = await http.post(
                                  Uri.parse(
                                      'https://api.razorpay.com/v1/orders'),
                                  body: jsonEncode(paymentRequestBody),
                                  headers: <String, String>{
                                    'authorization': basicAuth,
                                    "content-type": "application/json"
                                  });
                              print(response.statusCode);
                              var resObject = jsonDecode(response.body);
                              print(resObject);
                              var options = {
                                'key': 'rzp_test_mmvDFiAwZW0q7S',
                                'amount': context.read<CartController>().total,
                                'currency': "INR",
                                'name': "RS Books",
                                'description': "Test Transaction",
                                'order_id': resObject['id'],
                                "prefill": {
                                  "name": "Mohit Tater",
                                  "email": "mohit@example.com",
                                  "contact": "9999009999"
                                },
                                'handler': (response) {
                                  cart.clearCart();
                                  addressController.clearAddress();
                                  navigationController.navigateTo(
                                      OrderSuccessPageRoute,
                                      args: {'orderId': resObject['id']});
                                },
                                'ondismiss': () {},
                              };
                              js.context.callMethod('initiatePayment',
                                  [js.JsObject.jsify(options)]);
                            } catch (e) {
                              print(e);
                            }
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
