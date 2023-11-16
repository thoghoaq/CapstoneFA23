import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

enum TransactionStatus {
  created("Đã tạo", DColors.gray1, DColors.gray5),
  processing("Đang xử lý", DColors.orange, DColors.softOrange),
  pickOff("Đã lấy hàng", DColors.primary, DColors.softGreen),
  shipping("Đang giao", DColors.greenPrimary, DColors.softGreen),
  delivered("Đã nhận", DColors.defaultText, DColors.whiteText),
  deliveryFailed("Giao lỗi", DColors.purple, DColors.softPurple),
  deleted("Đã xóa", DColors.defaultText, DColors.whiteText);

  const TransactionStatus(this.label, this.color, this.backgroundColor);

  final String label;
  final Color color;
  final Color backgroundColor;
}
