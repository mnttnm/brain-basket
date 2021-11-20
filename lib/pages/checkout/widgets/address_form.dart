import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/controllers/address_controller.dart';
import 'package:rs_books/models/address_model.dart';

class AddressForm extends StatefulWidget {
  final void Function(BuildContext context, AddressModel) onFormSubmit;

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
                    widget.onFormSubmit(context, model);
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
