import 'package:flutter/material.dart';

class PaymentDetailItem extends StatelessWidget {
  final String label;
  final String value;
  const PaymentDetailItem({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 300,
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Text('$label:',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(
                flex: 2,
                child: Text(
                  value,
                  style: TextStyle(fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                )),
          ],
        ),
      ),
    );
  }
}
