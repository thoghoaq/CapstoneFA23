enum RouteCalculationType {
  distance(label: "Khoảng cách"),
  duration(label: "Thời gian"),
  random(label: "Ngẫu nhiên");

  final String label;

  const RouteCalculationType({required this.label});
}
