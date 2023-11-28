enum RouteCalculationType {
  distance(label: "Khoảng cách"),
  duration(label: "Thời gian");

  final String label;

  const RouteCalculationType({required this.label});
}
