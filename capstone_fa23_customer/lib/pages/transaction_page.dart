import 'package:capstone_fa23_customer/helpers/datetime_helper.dart';
import 'package:capstone_fa23_customer/partials/transaction_list_tile.dart';
import 'package:capstone_fa23_customer/providers/orders_provider.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DAppBar(
        title: 'Giao dịch',
      ),
      body: Consumer<OrderProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            provider.getListOrders();
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return TransactionListTile(
                // icon: Image.asset(transactions[index]["icon"]),
                title:
                    "${provider.orders[index].shippingDistrict}, ${provider.orders[index].shippingWard}, ${provider.orders[index].shippingProvince}",
                subtitle: provider.orders[index].shippingAddress,
                description: DateTimeHelper.getDateTime(
                    provider.orders[index].expectedShippingDate),
                status: provider.orders[index].currentOrderStatus,
                showBottomDivider: true,
                onTap: () {
                  context.push('/home/tracking-order',
                      extra: provider.orders[index].id);
                },
              );
            },
            itemCount: provider.orders.length,
          );
        },
      ),
    );
  }
}
