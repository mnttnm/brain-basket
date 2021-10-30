import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/constants/controllers.dart';
import 'package:rs_books/data/order.dart';
import 'package:rs_books/models/address_model.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/widgets/cart_page.dart';
import 'package:rs_books/widgets/centered_view.dart';

class AddressController with ChangeNotifier {
  AddressModel? currentAddress;

  void updateCurrentAddress(AddressModel address) {
    currentAddress = address;
    notifyListeners();
  }

  void clearAddress() {
    currentAddress = null;
  }

  AddressModel? get address {
    return currentAddress;
  }
}

class AddressForm extends StatefulWidget {
  final void Function(AddressModel) onFormSubmit;

  AddressForm({Key? key, required this.onFormSubmit}) : super(key: key);

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AddressModel model = AddressModel();

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressController>(builder: (BuildContext context,
        AddressController addressController, Widget? child) {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              onSaved: (value) {
                model.name = value!;
              },
              initialValue: addressController.currentAddress != null
                  ? addressController.currentAddress!.name
                  : "",
              decoration: const InputDecoration(
                  label: const Text('Name'), hintText: 'Enter your name'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: addressController.address != null
                  ? addressController.address!.address1
                  : "",
              onSaved: (value) {
                model.address1 = value!;
              },
              decoration: const InputDecoration(
                  label: const Text('Address Line 1'),
                  hintText: 'Address Line 1'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: addressController.address != null
                  ? addressController.address!.address2
                  : "",
              onSaved: (value) {
                model.address2 = value!;
              },
              key: Key('address_line_2'),
              decoration: const InputDecoration(
                  label: const Text('Address line 2'),
                  hintText: 'Address Line 2'),
            ),
            TextFormField(
              initialValue: addressController.address != null
                  ? addressController.address!.pincode
                  : "",
              onSaved: (value) {
                model.pincode = value!;
              },
              decoration: const InputDecoration(
                  label: const Text('Pincode'), hintText: 'Enter your pincode'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your pin code';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: addressController.address != null
                  ? addressController.address!.contactNo
                  : "",
              onSaved: (value) {
                model.contactNo = value!;
              },
              decoration: const InputDecoration(
                  label: const Text('Contact No'), hintText: 'Mobile No'),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your mobile phone no';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: addressController.address != null
                  ? addressController.address!.email
                  : "",
              onSaved: (value) {
                model.email = value!;
              },
              decoration: const InputDecoration(
                  label: const Text('Email'), hintText: 'xyz@gmail.com'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    addressController.updateCurrentAddress(model);
                    widget.onFormSubmit(model);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Place Order',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class CheckoutPage extends StatelessWidget {
  final dynamic args;
  const CheckoutPage({Key? key, required this.args}) : super(key: key);

  Order createOrder(AddressModel address, double orderAmount) {
    String orderId = '';
    DateTime orderTime = DateTime.now();
    Order order = Order(
        orderId: orderId,
        orderCreationTime: orderTime,
        orderTotal: orderAmount,
        address: address);
    return order;
  }

  void onCheckout(AddressModel model) {
    navigationController.navigateTo(PaymentsPageRoute,
        args: createOrder(model, this.args['orderAmount']));
  }

  @override
  Widget build(BuildContext context) {
    return CenteredView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Back(),
          Text(
            "Shipping Details",
            style: TextStyle(
                fontSize: 18,
                color: Colors.purple.shade300,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          const Text(
            'Please fill the below form with the complete information about the shipping address and contact deatils.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              constraints: BoxConstraints(maxWidth: 800),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple.shade300, width: 2)),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddressForm(
                    onFormSubmit: onCheckout,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
