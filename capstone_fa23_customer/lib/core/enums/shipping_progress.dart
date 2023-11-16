import 'package:capstone_fa23_customer/core/enums/transaction_status.dart';

enum ShippingProgress {
  created("Đơn hàng đã được tạo", "5-10 Phút",
      "assets/images/contexts/shipping_progress_1.png", 0.1),
  processing("Đơn hàng đang được xử lý", "5-10 Phút",
      "assets/images/contexts/shipping_progress_1.png", 0.2),
  goingToPickup("Shipper đã tới điểm nhận hàng", "5-10 Phút",
      "assets/images/contexts/shipping_progress_1.png", 0.3),
  pickedUp("Shipper đã lấy gói hàng", "5-10 Phút",
      "assets/images/contexts/shipping_progress_1.png", 0.5),
  onGoing("Shipper đang tới địa điểm của bạn", "5-10 Phút",
      "assets/images/contexts/shipping_progress_2.png", 0.7),
  shipped("Đơn hàng đã được giao thành công", "Đã giao hàng",
      "assets/images/contexts/shipping_progress_3.png", 1),
  feedback("", "", "", 1);

  final String message;
  final String description;
  final String image;
  final double percent;

  const ShippingProgress(
      this.message, this.description, this.image, this.percent);

  static ShippingProgress getMapTransactionStatus(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.created:
        return ShippingProgress.created;
      case TransactionStatus.processing:
        return ShippingProgress.processing;
      case TransactionStatus.pickOff:
        return ShippingProgress.pickedUp;
      case TransactionStatus.shipping:
        return ShippingProgress.onGoing;
      case TransactionStatus.delivered:
        return ShippingProgress.shipped;
      default:
        return ShippingProgress.created;
    }
  }
}
