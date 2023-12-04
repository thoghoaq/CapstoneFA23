import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

enum TransactionStatus {
  created("Đã tạo", DColors.gray1, DColors.gray5, "Xử lý"),
  processing("Đang xử lý", DColors.orange, DColors.softOrange, "Lấy hàng"),
  pickOff("Đã lấy hàng", DColors.primary, DColors.softGreen, "Đi giao"),
  shipping("Đang giao", DColors.greenPrimary, DColors.softGreen, "Giao hàng"),
  delivered("Đã giao", DColors.defaultText, DColors.whiteText, "Hoàn thành"),
  deliveryFailed("Giao lỗi", DColors.purple, DColors.softPurple, "Chi tiết"),
  deleted("Đã xóa", DColors.defaultText, DColors.whiteText, "Chi tiết");

  const TransactionStatus(
      this.label, this.color, this.backgroundColor, this.buttonLabel);

  final String label;
  final Color color;
  final Color backgroundColor;
  final String buttonLabel;

  static bool isProcessing(TransactionStatus status) {
    return status == TransactionStatus.created ||
        status == TransactionStatus.processing;
  }

  static bool isOngoing(TransactionStatus status) {
    return status == TransactionStatus.pickOff ||
        status == TransactionStatus.shipping;
  }

  static bool isCompleted(TransactionStatus status) {
    return status == TransactionStatus.deliveryFailed ||
        status == TransactionStatus.delivered ||
        status == TransactionStatus.deleted;
  }
}
