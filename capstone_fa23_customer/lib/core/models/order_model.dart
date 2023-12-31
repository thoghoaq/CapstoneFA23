import 'package:capstone_fa23_customer/core/enums/transaction_status.dart';

class Order {
  final String id;
  final int ownerId;
  final int? creatorId;
  final int? driverId;
  final String? driverName;
  final String? driverPhoneNumber;
  final String shippingProvince;
  final String shippingDistrict;
  final String shippingWard;
  final String shippingAddress;
  final String expectedShippingDate;
  final TransactionStatus currentOrderStatus;
  final String? senderName;
  final String? senderPhoneNumber;
  final String? note;
  final bool? isFeedback;

  Order({
    required this.id,
    required this.ownerId,
    this.creatorId,
    required this.driverId,
    required this.driverName,
    required this.driverPhoneNumber,
    required this.shippingProvince,
    required this.shippingDistrict,
    required this.shippingWard,
    required this.shippingAddress,
    required this.expectedShippingDate,
    required this.currentOrderStatus,
    this.isFeedback,
    this.senderName,
    this.senderPhoneNumber,
    this.note,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      ownerId: json['owner']['id'],
      creatorId: json['creatorId'],
      driverId: json['driver']?['id'],
      driverName: json['driver']?['name'],
      driverPhoneNumber: json['driver']?['phoneContact'],
      shippingProvince: json['shippingProvince'],
      shippingDistrict: json['shippingDistrict'],
      shippingWard: json['shippingWard'],
      shippingAddress: json['shippingAddress'],
      expectedShippingDate: json['expectedShippingDate'],
      currentOrderStatus: TransactionStatus.values[json['currentOrderStatus']],
      isFeedback: json['isFeedback'],
    );
  }

  factory Order.fromJsonDetail(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      ownerId: json['owner']['id'],
      creatorId: json['creatorId'],
      driverId: json['driver']?['id'],
      driverName: json['driver']?['name'],
      driverPhoneNumber: json['driver']?['phoneContact'],
      shippingProvince: json['shippingProvince'],
      shippingDistrict: json['shippingDistrict'],
      shippingWard: json['shippingWard'],
      shippingAddress: json['shippingAddress'],
      expectedShippingDate: json['expectedShippingDate'],
      currentOrderStatus: TransactionStatus.values[json['currentOrderStatus']],
      senderName: json['senderName'],
      senderPhoneNumber: json['senderPhoneNumber'],
      note: json['note'],
    );
  }
}
