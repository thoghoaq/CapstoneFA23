class Account {
  final String name;
  final DateTime birthDay;
  final String province;
  final String district;
  final String ward;
  final String address;
  final String phoneContact;

  Account({
    required this.name,
    required this.birthDay,
    required this.province,
    required this.district,
    required this.ward,
    required this.address,
    required this.phoneContact,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      name: json['name'],
      birthDay: DateTime.parse(json['birthDay']),
      province: json['province'],
      district: json['district'],
      ward: json['ward'],
      address: json['address'],
      phoneContact: json['phoneContact'],
    );
  }

  factory Account.mock() {
    return Account(
      name: "Nguyễn Văn A",
      birthDay: DateTime(1999, 1, 1),
      province: "Hà Nội",
      district: "Hoàn Kiếm",
      ward: "Tràng Tiền",
      address: "Số 1, Tràng Tiền, Hoàn Kiếm, Hà Nội",
      phoneContact: "0123456789",
    );
  }
}
