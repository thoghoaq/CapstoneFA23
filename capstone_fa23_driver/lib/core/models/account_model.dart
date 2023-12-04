class Profile {
  final String? name;
  final String? birthDay;
  final String? province;
  final String? district;
  final String? ward;
  final String? address;
  final String? phoneContact;

  Profile({
    this.name,
    this.birthDay,
    this.province,
    this.district,
    this.ward,
    this.address,
    this.phoneContact,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      birthDay: json['birthDay'],
      province: json['province'],
      district: json['district'],
      ward: json['ward'],
      address: json['address'],
      phoneContact: json['phoneContact'],
    );
  }

  factory Profile.mock() {
    return Profile(
      name: "Nguyễn Văn A",
      birthDay: "01/01/2001",
      province: "Hà Nội",
      district: "Hoàn Kiếm",
      ward: "Tràng Tiền",
      address: "Số 1, Tràng Tiền, Hoàn Kiếm, Hà Nội",
      phoneContact: "0123456789",
    );
  }
}
