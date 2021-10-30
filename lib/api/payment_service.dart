import 'dart:convert';
import 'dart:js' as js;
import 'package:http/http.dart' as http;
import 'package:rs_books/data/order.dart';

class PayementService {
  final Order orderInfo;
  PayementService(this.orderInfo) {}

  Future<String> createOrder() async {
    String username = 'rzp_test_mmvDFiAwZW0q7S';
    String password = 'UZVtRMbK1OcMvUgvmykFj9vZ';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    var paymentRequestBody = {
      'amount': orderInfo.orderTotal,
      'currency': "INR",
      'receipt': orderInfo.orderId
    };

    try {
      var response = await http.post(
          Uri.parse('https://api.razorpay.com/v1/orders'),
          body: jsonEncode(paymentRequestBody),
          headers: <String, String>{
            'authorization': basicAuth,
            "content-type": "application/json"
          });
      var resObject = jsonDecode(response.body);
      return resObject['id'];
    } catch (e) {
      print(e);
      return "";
    }
  }

  void executeOrder(Order orderInfo, String orderId,
      {required Function() onSuccess,
      Function()? onFailure,
      Function()? onCancel}) async {
    var options = {
      'key': 'rzp_test_mmvDFiAwZW0q7S',
      'amount': orderInfo.orderTotal,
      'currency': "INR",
      'name': "RS Books",
      'description': "Test Transaction",
      'order_id': orderId,
      "prefill": {
        "name": orderInfo.address!.name,
        "email": orderInfo.address!.email!.isNotEmpty
            ? orderInfo.address!.email
            : "${orderInfo.address!.contactNo}@${orderInfo.address!.name}.com",
        "contact": orderInfo.address!.contactNo
      },
      'handler': (response) {
        print('## order success $response');
        onSuccess();
      },
      'ondismiss': () {
        print('## order cancel!');
        if (onCancel != null) onCancel();
      },
    };
    js.context.callMethod('initiatePayment', [js.JsObject.jsify(options)]);
  }
}
