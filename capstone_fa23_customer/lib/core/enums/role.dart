enum Role {
  admin("ADMIN"),
  manger("MANAGER"),
  driver("DRIVER"),
  customer("CUSTOMER");

  final String code;
  const Role(this.code);
}
