// To parse this JSON data, do
//
//     final book = bookFromMap(jsonString);

import 'dart:convert';

ShipRocketOrder bookFromMap(String str) =>
    ShipRocketOrder.fromMap(json.decode(str));
String bookToMap(ShipRocketOrder data) => json.encode(data.toMap());

class ShipRocketOrder {
  ShipRocketOrder({
    this.mode = "Surface",
    required this.orderId,
    required this.orderDate,
    required this.pickupLocation,
    required this.billingCustomerName,
    required this.billingCustomerLastName,
    required this.billingAddress,
    required this.billingCity,
    required this.billingPincode,
    required this.billingState,
    required this.billingCountry,
    required this.billingEmail,
    required this.billingPhone,
    required this.shippingIsBilling,
    required this.orderItems,
    required this.paymentMethod,
    required this.subTotal,
    required this.length,
    required this.breadth,
    required this.height,
    required this.weight,
  });

  final String mode;
  final String orderId;
  final String orderDate;
  final String pickupLocation;
  final String billingCustomerName;
  final String billingCustomerLastName;
  final String billingAddress;
  final String billingCity;
  final String billingPincode;
  final String billingState;
  final String billingCountry;
  final String billingEmail;
  final String billingPhone;
  final bool shippingIsBilling;
  final List<OrderItem> orderItems;
  final String paymentMethod;
  final int subTotal;
  final int length;
  final int breadth;
  final int height;
  final double weight;

  factory ShipRocketOrder.fromMap(Map<String, dynamic> json) => ShipRocketOrder(
        mode: json["mode"],
        orderId: json["order_id"],
        orderDate: json["order_date"],
        pickupLocation: json["pickup_location"],
        billingCustomerName: json["billing_customer_name"],
        billingCustomerLastName: json['billing_last_name'],
        billingAddress: json["billing_address"],
        billingCity: json["billing_city"],
        billingPincode: json["billing_pincode"],
        billingState: json["billing_state"],
        billingCountry: json["billing_country"],
        billingEmail: json["billing_email"],
        billingPhone: json["billing_phone"],
        shippingIsBilling: json["shipping_is_billing"],
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromMap(x))),
        paymentMethod: json["payment_method"],
        subTotal: json["sub_total"],
        length: json["length"],
        breadth: json["breadth"],
        height: json["height"],
        weight: json["weight"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "mode": mode,
        "order_id": orderId,
        "order_date": orderDate,
        "pickup_location": pickupLocation,
        "billing_customer_name": billingCustomerName,
        "billing_last_name": billingCustomerLastName,
        "billing_address": billingAddress,
        "billing_city": billingCity,
        "billing_pincode": billingPincode,
        "billing_state": billingState,
        "billing_country": billingCountry,
        "billing_email": billingEmail,
        "billing_phone": billingPhone,
        "shipping_is_billing": shippingIsBilling,
        "order_items": List<dynamic>.from(orderItems.map((x) => x.toMap())),
        "payment_method": paymentMethod,
        "sub_total": subTotal,
        "length": length,
        "breadth": breadth,
        "height": height,
        "weight": weight,
      };
}

class OrderItem {
  OrderItem({
    required this.name,
    required this.sku,
    required this.units,
    required this.sellingPrice,
  });

  final String name;
  final String sku;
  final int units;
  final int sellingPrice;

  factory OrderItem.fromMap(Map<String, dynamic> json) => OrderItem(
        name: json["name"],
        sku: json["sku"],
        units: json["units"],
        sellingPrice: json["selling_price"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "sku": sku,
        "units": units,
        "selling_price": sellingPrice,
      };
}
