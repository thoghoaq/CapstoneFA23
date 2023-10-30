import 'package:capstone_fa23_driver/domain/enums/transaction_status.dart';
import 'package:capstone_fa23_driver/partials/order_list_tile.dart';
import 'package:capstone_fa23_driver/partials/transaction_list_tile.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  OrdersPage({super.key});

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

  TabBar get _tabBar => TabBar(
        tabs: [
          Tab(icon: Icon(Icons.flight)),
          Tab(icon: Icon(Icons.directions_transit)),
          Tab(icon: Icon(Icons.directions_car)),
        ],
      );

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
          _Ongoing(orders: orders),
          _History(transactions: transactions),
        ]),
      ),
    );
  }
}

class _Ongoing extends StatelessWidget {
  const _Ongoing({
    Key? key,
    required this.orders,
  }) : super(key: key);

  final List orders;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: orders.length,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: OrderListTile(
                    order: orders[index],
                  ),
                );
              },
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
            DOutlinedButton.small(
              text: "Tính toán lộ trình",
              onPressed: () {},
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}

class _History extends StatelessWidget {
  const _History({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  final List transactions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return TransactionListTile(
          icon: Image.asset(transactions[index]["icon"]),
          title: transactions[index]["title"],
          subtitle: transactions[index]["subtitle"],
          description: transactions[index]["description"],
          status: transactions[index]["status"],
          showBottomDivider: true,
          onTap: () {},
        );
      },
      itemCount: transactions.length,
      shrinkWrap: true,
    );
  }
}
