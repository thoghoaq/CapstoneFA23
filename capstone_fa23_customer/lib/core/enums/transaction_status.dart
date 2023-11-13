import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

enum TransactionStatus {
  ongoing("Đang tới", DColors.whiteText, DColors.primary),
  received("Đã nhận", DColors.greenPrimary, DColors.softGreen),
  canceled("Đã hủy", DColors.purple, DColors.softPurple);

  const TransactionStatus(this.label, this.color, this.backgroundColor);

  final String label;
  final Color color;
  final Color backgroundColor;
}
