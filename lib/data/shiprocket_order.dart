import 'dart:convert';

ShipRocketOrder srOrderFromMap(String str) =>
    ShipRocketOrder.fromMap(json.decode(str) as Map<String, dynamic>);
String srOrderToMap(ShipRocketOrder data) => json.encode(data.toMap());

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
        mode: json["mode"] as String,
        orderId: json["order_id"] as String,
        orderDate: json["order_date"] as String,
        pickupLocation: json["pickup_location"] as String,
        billingCustomerName: json["billing_customer_name"] as String,
        billingCustomerLastName: json['billing_last_name'] as String,
        billingAddress: json["billing_address"] as String,
        billingCity: json["billing_city"] as String,
        billingPincode: json["billing_pincode"] as String,
        billingState: json["billing_state"] as String,
        billingCountry: json["billing_country"] as String,
        billingEmail: json["billing_email"] as String,
        billingPhone: json["billing_phone"] as String,
        shippingIsBilling: json["shipping_is_billing"] as bool,
        orderItems: List<OrderItem>.from(
            (json["order_items"] as List<Map<String, dynamic>>)
              .map((x) => OrderItem.fromMap(x)),
        ),
        paymentMethod: json["payment_method"] as String,
        subTotal: json["sub_total"] as int,
        length: json["length"] as int,
        breadth: json["breadth"] as int,
        height: json["height"] as int,
        weight: json["weight"] as double, 
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
        name: json["name"] as String,
        sku: json["sku"] as String,
        units: json["units"] as int,
        sellingPrice: json["selling_price"] as int,
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "sku": sku,
        "units": units,
        "selling_price": sellingPrice,
      };
}
