import 'dart:convert';
import 'dart:js' as js;
import 'package:http/http.dart' as http;
import 'package:rs_books/data/order.dart';

class PayementService {
  PayementService();

  Future<String> createOrder(double orderTotal, String orderId) async {
    const String username = 'rzp_test_mmvDFiAwZW0q7S';
    const String password = 'UZVtRMbK1OcMvUgvmykFj9vZ';
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final paymentRequestBody = {
      'amount': orderTotal * 100, // convert to current subunit
      'currency': "INR",
      'receipt': orderId,
      'partial_payment': false
    };

    try {
      final response = await http.post(
        Uri.parse('https://api.razorpay.com/v1/orders'),
        body: jsonEncode(paymentRequestBody),
        headers: <String, String>{
          'authorization': basicAuth,
          "content-type": "application/json"
        },
      );
      final resObject = jsonDecode(response.body);
      return resObject['id'] as String;
    } catch (e) {
      return "";
    }
  }

  void executeOrder(
    Order orderInfo, {
    required Function() onSuccess,
    Function()? onFailure,
    Function()? onCancel,
  }) {
    final options = {
      'key': 'rzp_test_mmvDFiAwZW0q7S',
      'amount':
          orderInfo.orderTotal * 100, // amount converted to currency subunit
      'currency': "INR",
      'name': "RS Books",
      'description': "Test Transaction",
      'order_id': orderInfo.orderId,
      "prefill": {
        "name": orderInfo.address!.name,
        "email": orderInfo.address!.email!.isNotEmpty
            ? orderInfo.address!.email
            : "${orderInfo.address!.contactNo}@${orderInfo.address!.name}.com",
        "contact": orderInfo.address!.contactNo,
        "method": "upi"
      },
      'modal': {
        'ondismiss': () {
          if (onCancel != null) onCancel();
        },
      },
      'handler': (response) {
        if (response['razorpay_order_id'].toString().isNotEmpty) {
          onSuccess();
        } else {
          onFailure!();
        }
      },
    };
    js.context.callMethod('initiatePayment', [js.JsObject.jsify(options)]);
  }
}
