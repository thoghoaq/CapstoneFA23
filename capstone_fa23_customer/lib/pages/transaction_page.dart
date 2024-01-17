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
          return RefreshIndicator(
            onRefresh: () => provider.getListOrders(),
            child: provider.orders.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return TransactionListTile(
                        // icon: Image.asset(transactions[index]["icon"]),
                        title:
                            "Đơn hàng giao bởi ${provider.orders[index].driverName}",
                        subtitle:
                            "${provider.orders[index].shippingAddress}, ${provider.orders[index].shippingDistrict}, ${provider.orders[index].shippingWard}, ${provider.orders[index].shippingProvince}",
                        description:
                            "Ngày nhận dự kiến: ${DateTimeHelper.getDateTime(provider.orders[index].expectedShippingDate)}",
                        status: provider.orders[index].currentOrderStatus,
                        showBottomDivider: true,
                        onTap: () {
                          var isFeedback =
                              provider.orders[index].isFeedback == true
                                  ? 'true'
                                  : 'false';
                          context.push(
                              '/home/tracking-order/${provider.orders[index].id}',
                              extra: isFeedback);
                        },
                      );
                    },
                    itemCount: provider.orders.length,
                  )
                : ListView(
                    children: const [
                      Center(
                        child: Text("Bạn chưa có đơn hàng nào"),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
