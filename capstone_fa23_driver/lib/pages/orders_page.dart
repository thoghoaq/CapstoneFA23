import 'package:capstone_fa23_driver/core/enums/transaction_status.dart';
import 'package:capstone_fa23_driver/helpers/datetime_helper.dart';
import 'package:capstone_fa23_driver/partials/order_list_tile.dart';
import 'package:capstone_fa23_driver/partials/transaction_list_tile.dart';
import 'package:capstone_fa23_driver/providers/orders_provider.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  OrdersPage({super.key});

  final List transactions = [
    {
      "icon": "assets/images/contexts/brand_1.png",
      "title": "JCO Jwalk Mall",
      "subtitle": "Được giao bởi Gofood",
      "description": "20/03/2020",
      "status": TransactionStatus.created,
    },
    {
      "icon": "assets/images/contexts/brand_2.png",
      "title": "KFC Ambarukmo Plaza",
      "subtitle": "Được giao bởi Gofood",
      "description": "20/03/2020",
      "status": TransactionStatus.deleted,
    },
    {
      "icon": "assets/images/contexts/brand_3.png",
      "title": "Burger King Malioboro Mall",
      "subtitle": "Được giao bởi Gofood",
      "description": "20/03/2020",
      "status": TransactionStatus.delivered,
    },
    {
      "icon": "assets/images/contexts/brand_4.png",
      "title": "Starbuck Ambarukmo Plaza",
      "subtitle": "Được giao bởi Gofood",
      "description": "20/03/2020",
      "status": TransactionStatus.deliveryFailed,
    },
    {
      "icon": "assets/images/contexts/brand_5.png",
      "title": "Warung Penyetan Mcdonalds",
      "subtitle": "Được giao bởi Gofood",
      "description": "20/03/2020",
      "status": TransactionStatus.pickOff,
    },
    {
      "icon": "assets/images/contexts/brand_2.png",
      "title": "KFC Ambarukmo Plaza",
      "subtitle": "Được giao bởi Gofood",
      "description": "20/03/2020",
      "status": TransactionStatus.processing,
    },
    {
      "icon": "assets/images/contexts/brand_3.png",
      "title": "Burger King Malioboro Mall",
      "subtitle": "Được giao bởi Gofood",
      "description": "20/03/2020",
      "status": TransactionStatus.shipping,
    },
    {
      "icon": "assets/images/contexts/brand_4.png",
      "title": "Starbuck Ambarukmo Plaza",
      "subtitle": "Được giao bởi Gofood",
      "description": "20/03/2020",
      "status": TransactionStatus.delivered,
    },
    {
      "icon": "assets/images/contexts/brand_5.png",
      "title": "Warung Penyetan Mcdonalds",
      "subtitle": "Được giao bởi Gofood",
      "description": "20/03/2020",
      "status": TransactionStatus.delivered,
    },
  ];

  final List orders = [
    {
      "time": "17/8/2016 3:58 PM",
      "title": "JCO Jwalk Mall",
      "subtitle": "Được giao bởi Gofood",
      "code": "198271DX",
      "status": "ĐANG GIAO",
    },
    {
      "time": "17/8/2016 3:58 PM",
      "title": "KFC Ambarukmo Plaza",
      "subtitle": "Được giao bởi Gofood",
      "code": "138571GC",
      "status": "ĐANG GIAO",
    },
    {
      "time": "17/8/2016 3:58 PM",
      "title": "KFC Ambarukmo Plaza",
      "subtitle": "Được giao bởi Gofood",
      "code": "138571GC",
      "status": "ĐANG GIAO",
    },
    {
      "time": "17/8/2016 3:58 PM",
      "title": "KFC Ambarukmo Plaza",
      "subtitle": "Được giao bởi Gofood",
      "code": "138571GC",
      "status": "ĐANG GIAO",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Đơn hàng",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.background,
          toolbarHeight: 87,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TabBar(
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                  indicator: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Theme.of(context).colorScheme.background,
                  unselectedLabelStyle: Theme.of(context).textTheme.bodyLarge,
                  unselectedLabelColor: DColors.gray3,
                  tabs: const [
                    Tab(
                      text: "Đang diễn ra",
                      height: 40,
                    ),
                    Tab(
                      text: "Lịch sử",
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(children: [
          Consumer<OrderProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                provider.getListOrders();
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return _Ongoing(
                  provider: provider,
                  orders:
                      provider.orders.map((order) => order.toJson()).toList());
            },
          ),
          Consumer<OrderProvider>(builder: (context, provider, child) {
            if (provider.isLoading) {
              provider.getListOrders();
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return _History(provider: provider);
          })
        ]),
      ),
    );
  }
}

class _Ongoing extends StatelessWidget {
  const _Ongoing({
    Key? key,
    required this.orders,
    required this.provider,
  }) : super(key: key);

  final List orders;
  final OrderProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: RefreshIndicator(
        onRefresh: () => provider.getListOrders(),
        child: ListView(children: [
          Column(
            children: [
              ListView.builder(
                itemCount: orders.length,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: OrderListTile(
                      order: orders[index],
                      onTap: () {
                        context.push("/orders/map-view");
                      },
                    ),
                  );
                },
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
              if (orders.isNotEmpty)
                DOutlinedButton.small(
                  text: "Tính toán lộ trình",
                  onPressed: () {},
                ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ]),
      ),
    );
  }
}

class _History extends StatelessWidget {
  const _History({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final OrderProvider provider;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => provider.getListOrders(),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return TransactionListTile(
            title:
                "${provider.history[index].ownerName} - ${provider.history[index].ownerPhoneContact}",
            subtitle:
                "${provider.history[index].shippingAddress}, ${provider.history[index].shippingDistrict}, ${provider.history[index].shippingWard}, ${provider.history[index].shippingProvince}",
            description: DateTimeHelper.getDate(
                provider.history[index].expectedShippingDate),
            status: provider.history[index].currentOrderStatus,
            showBottomDivider: true,
            onTap: () {},
          );
        },
        itemCount: provider.history.length,
      ),
    );
  }
}
