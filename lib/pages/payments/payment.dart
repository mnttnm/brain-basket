import 'dart:convert';
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rs_books/controllers/cart_controller.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/pages/payments/widgets/payment_detail.dart';
import 'package:rs_books/widgets/cart_page.dart';

class Payment extends StatelessWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
        builder: (BuildContext context, CartController cart, Widget? child) {
      return Container(
          padding: const EdgeInsets.all(10),
          color: Colors.blueGrey.shade50,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(alignment: Alignment.topLeft, child: Back()),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Make Payment",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    Text("₹${cart.total}",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ],
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text("Payment by Bank or UPI transfer",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Flex(
                        direction: ResponsiveWidget.isLargeScreen(context)
                            ? Axis.horizontal
                            : Axis.vertical,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const PaymentDetailItem(
                                  label: "UPI ID", value: "rohit@upi",),
                              const PaymentDetailItem(
                                  label: "Account Name", value: "Rohit Agrawal",),
                              const PaymentDetailItem(
                                  label: "Bank", value: "HDFC Bank, Kota",),
                              const PaymentDetailItem(
                                  label: "Account N o", value: "123456789",),
                              const PaymentDetailItem(
                                  label: "IFSC Code", value: "HDFC0000830",),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                'upi-qr.jpeg',
                                width: 300,
                                height: 300,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "rohit@upi",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              )
                            ],
                          )
                        ],
                      ),
                      Text(
                          "Once the payment is done, share the details using this form",
                          style: Theme.of(context).textTheme.bodyText2),
                    ],
                  ),
                ),
                Divider(height: 2, color: Colors.red),
                Flexible(
                  flex: 1,
                  child: Column(
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
                            print('placing order');
                
                            String username = 'rzp_test_mmvDFiAwZW0q7S';
                            String password = 'UZVtRMbK1OcMvUgvmykFj9vZ';
                            String basicAuth = 'Basic ' +
                                base64Encode(utf8.encode('$username:$password'));
                            print(basicAuth);
                            var paymentRequestBody = {
                              'amount': context
                                  .read<CartController>()
                                  .total, // amount in the smallest currency unit
                              'currency': "INR",
                              'receipt': "book_order_" + DateTime.now().toString()
                            };
                
                            try {
                              var response = await http.post(
                                  Uri.parse('https://api.razorpay.com/v1/orders'),
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
                                'handler': (response) =>
                                    {print(response.toString())},
                                'modal': {
                                  'ondismiss': () {
                                    print("Payment cancelled"); //3
                                  },
                                },
                              };
                              js.context.callMethod('initiatePayment',
                                  [js.JsObject.jsify(options)]);
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Make Payment", style: TextStyle(fontSize: 24)),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ));
    });
  }
}
