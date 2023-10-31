import 'package:capstone_fa23_customer/domain/enums/transaction_status.dart';
import 'package:capstone_fa23_customer/partials/transaction_list_tile.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionPage extends StatelessWidget {
  TransactionPage({super.key});

  final List transactions = [
    {
      "icon": "assets/images/contexts/brand_1.png",
      "title": "JCO Jwalk Mall",
      "subtitle": "Được giao bởi Gofood",
      "description": "20/03/2020",
      "status": TransactionStatus.ongoing,
    },
    {
      "icon": "assets/images/contexts/brand_2.png",
      "title": "KFC Ambarukmo Plaza",
      "subtitle": "Được giao bởi Gofood",
      "description": "20/03/2020",
      "status": TransactionStatus.received,
    },
    {
      "icon": "assets/images/contexts/brand_3.png",
      "title": "Burger King Malioboro Mall",
      "subtitle": "Được giao bởi Gofood",
      "description": "20/03/2020",
      "status": TransactionStatus.canceled,
    },
    {
      "icon": "assets/images/contexts/brand_4.png",
      "title": "Starbuck Ambarukmo Plaza",
      "subtitle": "Được giao bởi Gofood",
      "description": "20/03/2020",
      "status": TransactionStatus.received,
    },
    {
      "icon": "assets/images/contexts/brand_5.png",
      "title": "Warung Penyetan Mcdonalds",
      "subtitle": "Được giao bởi Gofood",
      "description": "20/03/2020",
      "status": TransactionStatus.received,
    },
    {
      "icon": "assets/images/contexts/brand_2.png",
      "title": "KFC Ambarukmo Plaza",
      "subtitle": "Được giao bởi Gofood",
      "description": "20/03/2020",
      "status": TransactionStatus.received,
    },
    {
      "icon": "assets/images/contexts/brand_3.png",
      "title": "Burger King Malioboro Mall",
      "subtitle": "Được giao bởi Gofood",
      "description": "20/03/2020",
      "status": TransactionStatus.canceled,
    },
    {
      "icon": "assets/images/contexts/brand_4.png",
      "title": "Starbuck Ambarukmo Plaza",
      "subtitle": "Được giao bởi Gofood",
      "description": "20/03/2020",
      "status": TransactionStatus.received,
    },
    {
      "icon": "assets/images/contexts/brand_5.png",
      "title": "Warung Penyetan Mcdonalds",
      "subtitle": "Được giao bởi Gofood",
      "description": "20/03/2020",
      "status": TransactionStatus.received,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DAppBar(
        title: 'Giao dịch',
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return TransactionListTile(
            icon: Image.asset(transactions[index]["icon"]),
            title: transactions[index]["title"],
            subtitle: transactions[index]["subtitle"],
            description: transactions[index]["description"],
            status: transactions[index]["status"],
            showBottomDivider: true,
            onTap: () {
              context.push('/transaction/tracking-order');
            },
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
