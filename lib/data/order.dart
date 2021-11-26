import 'package:rs_books/models/address_model.dart';

class Order {
  final String orderId;
  final DateTime orderCreationTime;
  final AddressModel? address;
  final double orderTotal;

  // DocumentReference? reference;

  Order(
      {required this.orderId,
      required this.orderCreationTime,
      this.address,
      required this.orderTotal,
  });

  factory Order.fromJson(Map<dynamic, dynamic> json) => Order(
      orderId: json['orderID'] as String,
      orderCreationTime: DateTime.parse(json['date'] as String),
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
        orderTotal: json['orderTotal'] as double,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'orderId': orderId,
        'orderCreationTime': orderCreationTime.toString(),
        'address': address?.toJson(),
        'orderTotal': orderTotal
      };
}
