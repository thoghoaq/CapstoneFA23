enum Role {
  admin("ADMIN"),
  manger("MANAGER"),
  customer("CUSTOMER"),
  driver("DRIVER");

  final String code;
  const Role(this.code);
}
