class AddressModel {
  String? name;
  String? address1;
  String? address2;
  String? pincode;
  String? contactNo;
  String? email;

  AddressModel(
      {this.name,
      this.address1,
      this.address2,
      this.pincode,
      this.contactNo,
      this.email});

  Map<String, dynamic> toJson() => {
        "name": name,
        "address1": address1,
        "address2": address2,
        "pincode": pincode,
        "contactNo": contactNo,
        "email": email,
      };

  factory AddressModel.fromJson(Map<dynamic, dynamic> json) => AddressModel(
      name: json['name'],
      address1: json['address1'],
      address2: json['address2'],
      pincode: json['pincode'],
      contactNo: json['contatctNo'],
      email: json['email']);

  String toString() {
    return '$name,\n$address1,$address2,$pincode\n$contactNo, $email';
  }
}
