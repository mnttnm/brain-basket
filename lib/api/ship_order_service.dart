import 'dart:convert';
import 'package:http/http.dart';
import 'package:rs_books/controllers/cart_controller.dart';
import 'package:rs_books/data/models.dart';
import 'package:rs_books/data/order.dart';

const shiprocket_urls = {
  'login_url': 'https://apiv2.shiprocket.in/v1/external/auth/login',
  'create_order': 'https://apiv2.shiprocket.in/v1/external/orders/create/adhoc',
  'generate_awb': 'https://apiv2.shiprocket.in/v1/external/courier/assign/awb',
  'generate_pickup':
      'https://apiv2.shiprocket.in/v1/external/courier/generate/pickup',
  'create_and_ship':
      'https://apiv2.shiprocket.in/v1/external/shipments/create/forward-shipment',
};

class ShipOrder {
  Future _generateToken() async {
    var headers = {'Content-Type': 'application/json'};
    var request = Request('POST', Uri.parse(shiprocket_urls['login_url']!));

    //TODO: Security, avoid order creation from the network tab?
    request.body = json.encode(
        // TODO: How to store this info?
        {"email": "mohittater.iiita@gmail.com", "password": "Zqi2T#AK#hH4g7!"});
    request.headers.addAll(headers);
    StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseJson = json.decode(await response.stream.bytesToString());
      return responseJson['token'];
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<Map<String, String>> getStateAndCityFromPinCode(String pinCode) async {
    var request = Request(
        'GET', Uri.parse('https://api.postalpincode.in/pincode/${pinCode}'));
    StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(await response.stream.bytesToString());
      final cityState = {'city': '', 'state': ''};
      if (jsonResponse[0]['Status'] == 'Success') {
        cityState['city'] =
            jsonResponse[0]['PostOffice'][0]['District'] as String;
        cityState['state'] =
            jsonResponse[0]['PostOffice'][0]['State'] as String;
      }
      return cityState;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  List<OrderItem> _createOrderItem(CartController cart) {
    final orderItemList = <OrderItem>[];

    cart.products.forEach((key, value) {
      final orderItem = OrderItem(
        name: value.name,
        sku: value.id,
        units: value.quantity,
        sellingPrice: value.cost.toInt(),
      );
      orderItemList.add(orderItem);
    });

    return orderItemList;
  }

  Future createQuickShipment(Order order, CartController cart) async {
    var request =
        Request('POST', Uri.parse(shiprocket_urls['create_and_ship']!));

    final token = await _generateToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };

    request.headers.addAll(headers);

    final cityState = await getStateAndCityFromPinCode(order.address!.pincode!);
    request.body = bookToMap(ShipRocketOrder(
        mode: "Surface",
        orderId: order.orderId,
        orderDate: order.orderCreationTime.toString(),
        pickupLocation: "Rohit",
        billingCustomerName: order.address!.name!,
        billingCustomerLastName: order.address!.name ?? "",
        billingAddress: order.address!.address1!,
        billingCity: cityState['city'] ?? "na",
        billingState: cityState['state'] ?? "na",
        billingPincode: order.address!.pincode!,
        billingCountry: "India",
        billingEmail: order.address!.email!,
        billingPhone: order.address!.contactNo!,
        shippingIsBilling: true,
        orderItems: _createOrderItem(cart),
        paymentMethod: "Prepaid",
        subTotal: order.orderTotal.toInt(),
        length: 20,
        breadth: 10,
        height: 5,
        weight: 0.49));
    StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(await response.stream.bytesToString());
      final awb_code = jsonResponse['payload']['awb_code'];
      print(
          'Order created sucessfully, track at https://shiprocket.co/tracking/${awb_code}');
    } else {
      print(response.reasonPhrase);
    }
  }

  Future placeOrder(Order order, CartController cart) async {
    print('Creating shiprocket order');
    var request = Request('POST', Uri.parse(shiprocket_urls['create_order']!));

    final token = await _generateToken();
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };

    request.headers.addAll(headers);

    request.body = bookToMap(ShipRocketOrder(
        orderId: order.orderId,
        orderDate: order.orderCreationTime.toString(),
        pickupLocation: "Rohit",
        billingCustomerName: order.address!.name!,
        billingCustomerLastName: order.address!.name!,
        billingAddress: order.address!.address1!,
        billingCity: "Udaipur",
        billingPincode: order.address!.pincode!,
        billingState: "Rajasthan",
        billingCountry: "India",
        billingEmail: order.address!.email!,
        billingPhone: order.address!.contactNo!,
        shippingIsBilling: true,
        orderItems: _createOrderItem(cart),
        paymentMethod: "Prepaid",
        subTotal: order.orderTotal.toInt(),
        length: 20,
        breadth: 10,
        height: 5,
        weight: 0.49));
    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(await response.stream.bytesToString());
      // print(jsonResponse['order_id']);
      // print(jsonResponse['shipment_id']);
    } else {
      print(response.reasonPhrase);
    }
  }
}
