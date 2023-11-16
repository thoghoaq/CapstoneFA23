import 'package:capstone_fa23_customer/core/enums/transaction_status.dart';

class Order {
  final String id;
  final int ownerId;
  final int creatorId;
  final int driverId;
  final String shippingProvince;
  final String shippingDistrict;
  final String shippingWard;
  final String shippingAddress;
  final String expectedShippingDate;
  final TransactionStatus currentOrderStatus;

  Order({
    required this.id,
    required this.ownerId,
    required this.creatorId,
    required this.driverId,
    required this.shippingProvince,
    required this.shippingDistrict,
    required this.shippingWard,
    required this.shippingAddress,
    required this.expectedShippingDate,
    required this.currentOrderStatus,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      ownerId: json['owner']['id'],
      creatorId: json['creatorId'],
      driverId: json['driver']['id'],
      shippingProvince: json['shippingProvince'],
      shippingDistrict: json['shippingDistrict'],
      shippingWard: json['shippingWard'],
      shippingAddress: json['shippingAddress'],
      expectedShippingDate: json['expectedShippingDate'],
      currentOrderStatus: TransactionStatus.values[json['currentOrderStatus']],
    );
  }
}
