import 'package:capstone_fa23_driver/core/enums/transaction_status.dart';

class Order {
  final String id;
  final int ownerId;
  final String? ownerName;
  final String? ownerPhoneContact;
  final int? creatorId;
  final int driverId;
  final String driverName;
  final String driverPhoneNumber;
  final String shippingProvince;
  final String shippingDistrict;
  final String shippingWard;
  final String shippingAddress;
  final String expectedShippingDate;
  TransactionStatus currentOrderStatus;
  final String? senderName;
  final String? senderPhoneNumber;
  final String? note;
  double? lat;
  double? lng;
  int? priority;
  final String? recipientName;
  int? distanceFromYou;
  int? durationFromYou;
  bool? isWatingOrderSelected;

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
    this.senderName,
    this.senderPhoneNumber,
    this.note,
    this.ownerName,
    this.ownerPhoneContact,
    this.lat,
    this.lng,
    this.recipientName,
    this.distanceFromYou,
    this.durationFromYou,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      ownerId: json['owner']['id'],
      ownerName: json['owner']['name'],
      ownerPhoneContact: json['owner']['phoneContact'],
      creatorId: json['creatorId'],
      driverId: json['driver']['id'],
      driverName: json['driver']['name'],
      driverPhoneNumber: json['driver']['phoneContact'],
      shippingProvince: json['shippingProvince'],
      shippingDistrict: json['shippingDistrict'],
      shippingWard: json['shippingWard'],
      shippingAddress: json['shippingAddress'],
      expectedShippingDate: json['expectedShippingDate'],
      currentOrderStatus: TransactionStatus.values[json['currentOrderStatus']],
    );
  }

  factory Order.fromJsonDetail(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      ownerId: json['owner']['id'],
      ownerName: json['owner']['name'],
      ownerPhoneContact: json['owner']['phoneContact'],
      creatorId: json['creatorId'],
      driverId: json['driver']['id'],
      driverName: json['driver']['name'],
      driverPhoneNumber: json['driver']['phoneContact'],
      shippingProvince: json['shippingProvince'],
      shippingDistrict: json['shippingDistrict'],
      shippingWard: json['shippingWard'],
      shippingAddress: json['shippingAddress'],
      expectedShippingDate: json['expectedShippingDate'],
      currentOrderStatus: TransactionStatus.values[json['currentOrderStatus']],
      senderName: json['senderName'],
      senderPhoneNumber: json['senderPhoneNumber'],
      note: json['note'],
      lat: json['lat'] != null ? double.parse(json['lat'].toString()) : null,
      lng: json['lng'] != null ? double.parse(json['lng'].toString()) : null,
      recipientName: json['recipientName'],
    );
  }

  Map<String, dynamic> detailToJson() {
    return {
      'id': id,
      'ownerId': ownerId,
      'creatorId': creatorId,
      'driverId': driverId,
      'driverName': driverName,
      'driverPhoneNumber': driverPhoneNumber,
      'shippingProvince': shippingProvince,
      'shippingDistrict': shippingDistrict,
      'shippingWard': shippingWard,
      'shippingAddress': shippingAddress,
      'expectedShippingDate': expectedShippingDate,
      'currentOrderStatus': currentOrderStatus.index,
      'senderName': senderName,
      'senderPhoneNumber': senderPhoneNumber,
      'note': note,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerId': ownerId,
      'creatorId': creatorId,
      'driverId': driverId,
      'driverName': driverName,
      'driverPhoneNumber': driverPhoneNumber,
      'shippingProvince': shippingProvince,
      'shippingDistrict': shippingDistrict,
      'shippingWard': shippingWard,
      'shippingAddress': shippingAddress,
      'expectedShippingDate': expectedShippingDate,
      'currentOrderStatus': currentOrderStatus.index,
      'ownerName': ownerName,
      'ownerPhoneContact': ownerPhoneContact,
      'isWatingOrderSelected': isWatingOrderSelected ?? false,
    };
  }
}
