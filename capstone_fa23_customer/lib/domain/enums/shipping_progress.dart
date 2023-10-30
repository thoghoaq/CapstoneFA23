enum ShippingProgress {
  goingToPickup("Shipper đã tới điểm nhận hàng", "5-10 Phút",
      "assets/images/contexts/shipping_progress_1.png", 0.3),
  pickedUp("Shipper đã lấy gói hàng", "5-10 Phút",
      "assets/images/contexts/shipping_progress_1.png", 0.5),
  onGoing("Shipper đang tới địa điểm của bạn", "5-10 Phút",
      "assets/images/contexts/shipping_progress_2.png", 0.7),
  shipped("Đơn hàng đã được giao thành công", "Đã giao hàng",
      "assets/images/contexts/shipping_progress_3.png", 1);

  final String message;
  final String description;
  final String image;
  final double percent;

  const ShippingProgress(
      this.message, this.description, this.image, this.percent);
}
