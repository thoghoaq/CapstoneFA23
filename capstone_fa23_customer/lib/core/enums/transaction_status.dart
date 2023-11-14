import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

enum TransactionStatus {
  created("Đã tạo", DColors.whiteText, DColors.primary),
  processing("Đang xử lý", DColors.greenPrimary, DColors.softGreen),
  pickOff("Đã lấy hàng", DColors.purple, DColors.softPurple),
  shipping("Đang giao", DColors.greenPrimary, DColors.softGreen),
  delivered("Đã nhận", DColors.greenPrimary, DColors.softGreen),
  deliveryFailed("Giao lỗi", DColors.greenPrimary, DColors.softGreen),
  deleted("Đã xóa", DColors.greenPrimary, DColors.softGreen);

  const TransactionStatus(this.label, this.color, this.backgroundColor);

  final String label;
  final Color color;
  final Color backgroundColor;
}
