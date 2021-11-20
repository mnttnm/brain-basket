import 'package:flutter/material.dart';
import 'package:rs_books/models/address_model.dart';

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
