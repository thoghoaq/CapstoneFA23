import 'package:capstone_fa23_driver/partials/transaction_list_tile.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

class OrderDetailsModal extends StatelessWidget {
  final dynamic order;
  const OrderDetailsModal({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 627,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          const DSwipeIndicator(),
          TransactionListTile(
            title: order["title"],
            icon: Image.asset(order["icon"]),
            description: order["description"],
            subtitle: order["subtitle"],
            status: order["status"],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: double.infinity,
                  ),
                  Text(
                    "Creamy nachos",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "Thông tin chi tiết",
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ),
          ),
          Text(
            "Mã đơn hàng DX672612",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 32)
        ],
      ),
    );
  }
}
