import 'dart:convert';
import 'package:http/http.dart';
import 'package:rs_books/config/config_handler.dart';
import 'package:rs_books/controllers/cart_controller.dart';
import 'package:rs_books/data/models.dart';
import 'package:rs_books/data/order.dart';

class ShipOrder {
  final serverUrl = ConfigHandler().serverUrl;
  Future<Map<String, String>> getStateAndCityFromPinCode(String pinCode) async {
    final request = Request(
      'GET',
      Uri.parse('$serverUrl/pincode/$pinCode'),
    );
    final StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(await response.stream.bytesToString());
      return {
        "city": jsonResponse['city'] as String,
        "state": jsonResponse['state'] as String
      };
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

  Future createQuickShipment(
    Order order,
    CartController cart,
    Map<String, dynamic> paymentInfo,
  ) async {
    final request =
        Request('POST', Uri.parse('$serverUrl/shipment/create'));
    final headers = {
      'Content-Type': 'application/json',
    };

    request.headers.addAll(headers);

    final cityState = await getStateAndCityFromPinCode(order.address!.pincode!);
    request.body = json.encode({
      "shiprocket_order_info": srOrderToJson(
        ShipRocketOrder(
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
          weight: 0.49,
        ),
      ),
      "payment_info": json.encode(paymentInfo),
    });
    final StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(await response.stream.bytesToString());
      final trackingUrl = jsonResponse['tracking_url'];
      return trackingUrl;
    } else {
      // print(response.reasonPhrase);
    }
  }
}
