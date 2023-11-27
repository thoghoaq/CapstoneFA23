import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

enum TransactionStatus {
  created("Đã tạo", DColors.gray1, DColors.gray5),
  processing("Đang xử lý", DColors.orange, DColors.softOrange),
  pickOff("Đã lấy hàng", DColors.primary, DColors.softGreen),
  shipping("Đang giao", DColors.greenPrimary, DColors.softGreen),
  delivered("Đã giao", DColors.defaultText, DColors.whiteText),
  deliveryFailed("Giao lỗi", DColors.purple, DColors.softPurple),
  deleted("Đã xóa", DColors.defaultText, DColors.whiteText);

  const TransactionStatus(this.label, this.color, this.backgroundColor);

  final String label;
  final Color color;
  final Color backgroundColor;

  static bool isOngoing(TransactionStatus status) {
    return status == TransactionStatus.processing ||
        status == TransactionStatus.pickOff ||
        status == TransactionStatus.shipping;
  }

  static bool isCompleted(TransactionStatus status) {
    return status == TransactionStatus.deliveryFailed ||
        status == TransactionStatus.delivered ||
        status == TransactionStatus.deleted;
  }
}
