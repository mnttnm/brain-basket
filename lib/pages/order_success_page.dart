import 'package:flutter/material.dart';
import 'package:rs_books/widgets/centered_view.dart';

class OrderSuccessPage extends StatelessWidget {
  final dynamic args;
  late String orderId;
  OrderSuccessPage({Key? key, required this.args}) : super(key: key) {
    this.orderId = this.args['orderId'];
  }

  @override
  Widget build(BuildContext context) {
    return CenteredView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Order Successful!!",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade400),
            ),
            SizedBox(
              height: 5,
            ),
            Wrap(
              children: [
                Text(
                  "Your order has been placed successfuly, you will receive further details on your contact no. Please note your order id ",
                  style: TextStyle(fontSize: 16),
                ),
                SelectableText(
                  "$orderId",
                  enableInteractiveSelection: true,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  ", use it for all the future references to the order.",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
