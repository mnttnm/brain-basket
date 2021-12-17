import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/controllers/address_controller.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/models/address_model.dart';
import 'package:rs_books/styled_widgets/buttons/styled_buttons.dart';
import 'package:rs_books/styled_widgets/styled_spacers.dart';
import 'package:rs_books/styles.dart';

class BBTextFormField extends StatelessWidget {
  final AddressModel model;
  final String label;
  final String? initialValue;
  final void Function(String?) onSavedFn;
  final bool isRequired;

  const BBTextFormField({
    Key? key,
    required this.model,
    required this.label,
    this.initialValue,
    required this.onSavedFn,
    this.isRequired = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue ?? "",
      onSaved: onSavedFn,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(label),
        hintText: 'Enter your $label',
      ),
      validator: (String? value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return 'Please enter your $label';
        }
        return null;
      },
    );
  }
}

class AddressForm extends StatefulWidget {
  final void Function(BuildContext context, AddressModel) onFormSubmit;

  const AddressForm({Key? key, required this.onFormSubmit}) : super(key: key);

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AddressModel model = AddressModel();

  @override
  Widget build(BuildContext context) {
    return Consumer<AddressController>(
      builder: (
        BuildContext context,
        AddressController addressController,
        Widget? child,
      ) {
        return Form(
          key: _formKey,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ResponsiveWidget.isSmallestScreen(context) ? 350 : 800,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BBTextFormField(
                  label: 'Name',
                  model: model,
                  initialValue: addressController.currentAddress != null
                      ? addressController.currentAddress!.name
                      : "",
                  onSavedFn: (value) {
                    model.name = value;
                  },
                ),
                VSpace.sm,
                BBTextFormField(
                  model: model,
                  initialValue: addressController.address != null
                      ? addressController.address!.address1
                      : "",
                  onSavedFn: (value) {
                    model.address1 = value;
                  },
                  label: 'Address Line 1',
                ),
                VSpace.sm,
                BBTextFormField(
                  model: model,
                  initialValue: addressController.address != null
                      ? addressController.address!.address2
                      : "",
                  onSavedFn: (value) {
                    model.address2 = value;
                  },
                  label: 'Address line 2',
                  isRequired: false,
                ),
                VSpace.sm,
                BBTextFormField(
                  model: model,
                  initialValue: addressController.address != null
                      ? addressController.address!.pincode
                      : "",
                  onSavedFn: (value) {
                    model.pincode = value;
                  },
                  label: 'Pincode',
                ),
                VSpace.sm,
                BBTextFormField(
                  model: model,
                  initialValue: addressController.address != null
                      ? addressController.address!.contactNo
                      : "",
                  onSavedFn: (value) {
                    model.contactNo = value;
                  },
                  label: 'Contact No',
                ),
                VSpace.sm,
                BBTextFormField(
                  initialValue: addressController.address != null
                      ? addressController.address!.email
                      : "",
                  onSavedFn: (value) {
                    model.email = value;
                  },
                  label: 'Email',
                  model: model,
                  isRequired: false,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: Insets.med),
                    child: PrimaryButton(
                      onPressed: () {
                        // Validate will return true if the form is valid, or false if
                        // the form is invalid.
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          addressController.updateCurrentAddress(model);
                          widget.onFormSubmit(context, model);
                        }
                      },
                      label: 'Place Order',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
