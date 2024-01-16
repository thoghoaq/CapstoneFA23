import 'package:capstone_fa23_driver/core/enums/route_calculation_type.dart';
import 'package:capstone_fa23_driver/core/enums/transaction_status.dart';
import 'package:capstone_fa23_driver/helpers/datetime_helper.dart';
import 'package:capstone_fa23_driver/helpers/location_helper.dart';
import 'package:capstone_fa23_driver/modals/route_calculation_type_dialog.dart';
import 'package:capstone_fa23_driver/partials/order_list_tile.dart';
import 'package:capstone_fa23_driver/partials/transaction_list_tile.dart';
import 'package:capstone_fa23_driver/providers/orders_provider.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
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

  bool isLoadMore = false;
  bool historyIsLoadMore = false;
  bool isWaitingOrderLoadMore = false;
  bool isCalculatingRoutes = false;
  int ordersPage = 1;
  final int ordersSize = 10;
  int historyPage = 1;
  final int historySize = 10;
  int waitingOrdersPage = 1;
  final int waitingOrdersSize = 10;

  String? duration;
  RouteCalculationType? type;

  Future loadMore() async {
    if (!isLoadMore) {
      setState(() {
        isLoadMore = true;
      });
    }
    await context
        .read<OrderProvider>()
        .getListOrders(page: ordersPage + 1, size: ordersSize);
    setState(() {
      ordersPage++;
      isLoadMore = false;
    });
  }

  Future waitingOrdersLoadMore() async {
    if (!isWaitingOrderLoadMore) {
      setState(() {
        isWaitingOrderLoadMore = true;
      });
    }
    await context.read<OrderProvider>().getListWatingOrders(
        page: waitingOrdersPage + 1, size: waitingOrdersSize);
    setState(() {
      waitingOrdersPage++;
      isWaitingOrderLoadMore = false;
    });
  }

  Future historyLoadMore() async {
    if (!historyIsLoadMore) {
      setState(() {
        historyIsLoadMore = true;
      });
    }
    await context
        .read<OrderProvider>()
        .getHistory(page: historyPage + 1, size: historySize);
    setState(() {
      historyPage++;
      historyIsLoadMore = false;
    });
  }

  void resetOrderPage() {
    setState(() {
      ordersPage = 1;
    });
    resetRoutes();
  }

  void resetWatingOrderPage() {
    setState(() {
      waitingOrdersPage = 1;
    });
    resetRoutes();
  }

  void resetHistoryPage() {
    setState(() {
      historyPage = 1;
    });
  }

  void calculateRoutes(RouteCalculationType? calculationType) async {
    try {
      context.pop(); // Remove diaglog
      setState(() {
        isCalculatingRoutes = true;
      });
      var currentLocation = await LocationHelper().getCurrentLocation();
      if (mounted) {
        var dura = await context
            .read<OrderProvider>()
            .calculateRoutes(currentLocation, calculationType);
        setState(() {
          duration = dura;
          type = calculationType;
        });
      }
    } catch (e) {
      rethrow;
    } finally {
      setState(() {
        isCalculatingRoutes = false;
      });
    }
  }

  void resetRoutes() {
    setState(() {
      duration = null;
      type = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                      text: "Đang chờ",
                      height: 40,
                    ),
                    Tab(
                      text: "Đang giao",
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
              if (provider.waitingOrder.isEmpty) {
                provider.getListWatingOrders();
                if (provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
              return Stack(
                children: [
                  LazyLoadScrollView(
                    onEndOfPage: () => waitingOrdersLoadMore(),
                    scrollOffset: 100,
                    child: _Waiting(
                        provider: provider,
                        isLoadMore: isWaitingOrderLoadMore,
                        calculateRoutes: calculateRoutes,
                        reset: resetWatingOrderPage,
                        orders: provider.waitingOrder
                            .map((order) => order.toJson())
                            .toList()),
                  ),
                  if (isCalculatingRoutes) const RoutesCalculateOverlay(),
                ],
              );
            },
          ),
          Consumer<OrderProvider>(
            builder: (context, provider, child) {
              if (provider.orders.isEmpty) {
                provider.getListOrders();
                if (provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }

              return Stack(
                children: [
                  LazyLoadScrollView(
                    onEndOfPage: () => loadMore(),
                    scrollOffset: 100,
                    child: _Ongoing(
                        provider: provider,
                        isLoadMore: isLoadMore,
                        calculateRoutes: calculateRoutes,
                        reset: resetOrderPage,
                        duration: duration,
                        type: type,
                        orders: provider.orders
                            .map((order) => order.toJson())
                            .toList()),
                  ),
                  if (isCalculatingRoutes) const RoutesCalculateOverlay(),
                ],
              );
            },
          ),
          Consumer<OrderProvider>(builder: (context, provider, child) {
            if (provider.history.isEmpty) {
              provider.getHistory();
              if (provider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
            return LazyLoadScrollView(
                onEndOfPage: () => historyLoadMore(),
                scrollOffset: 100,
                child: _History(
                  provider: provider,
                  reset: resetHistoryPage,
                  isLoadMore: historyIsLoadMore,
                ));
          })
        ]),
      ),
    );
  }
}

class RoutesCalculateOverlay extends StatelessWidget {
  const RoutesCalculateOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Đang tính toán lộ trình...",
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.apply(color: DColors.whiteText),
          ),
        ],
      ),
    );
  }
}

class _Ongoing extends StatefulWidget {
  const _Ongoing({
    Key? key,
    required this.orders,
    required this.provider,
    required this.isLoadMore,
    required this.calculateRoutes,
    required this.reset,
    required this.duration,
    required this.type,
  }) : super(key: key);

  final List orders;
  final OrderProvider provider;
  final bool isLoadMore;
  final Function(RouteCalculationType?) calculateRoutes;
  final Function reset;
  final String? duration;
  final RouteCalculationType? type;

  @override
  State<_Ongoing> createState() => _OngoingState();
}

class _OngoingState extends State<_Ongoing> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: RefreshIndicator(
        onRefresh: () async {
          await widget.provider.getListOrders();
          widget.reset();
        },
        child: ListView(children: [
          if (widget.type != null && widget.duration != null)
            Padding(
              padding: const EdgeInsets.only(top: 16, left: 16),
              child: Column(
                children: [
                  Text(
                    "Lộ trình gợi ý theo: ${widget.type?.label}",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    "Tổng thời gian: ${widget.duration}",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ),
          Column(
            children: [
              ListView.builder(
                itemCount: widget.orders.length + 1,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                itemBuilder: (context, index) {
                  if (index == widget.orders.length) {
                    return Visibility(
                        visible: widget.isLoadMore,
                        child:
                            const Center(child: CircularProgressIndicator()));
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: OrderListTile(
                      order: widget.orders[index],
                      index: index + 1,
                      onTap: () {
                        context.push(
                            "/orders/map-view/${widget.orders[index]["id"]}");
                      },
                    ),
                  );
                },
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
              if (!(widget.type != null && widget.duration != null))
                if (widget.orders.isNotEmpty)
                  DOutlinedButton.small(
                    text: "Tính toán lộ trình",
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return RouteCalculationTypeDialog(
                            calculateRoutes: widget.calculateRoutes,
                          );
                        },
                      );
                    },
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

class _Waiting extends StatefulWidget {
  const _Waiting({
    Key? key,
    required this.orders,
    required this.provider,
    required this.isLoadMore,
    required this.calculateRoutes,
    required this.reset,
  }) : super(key: key);

  final List orders;
  final OrderProvider provider;
  final bool isLoadMore;
  final Function(RouteCalculationType?) calculateRoutes;
  final Function reset;

  @override
  State<_Waiting> createState() => _WaitingState();
}

class _WaitingState extends State<_Waiting> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.provider.waitingOrder.any((element) {
      return element.isWatingOrderSelected == true;
    });
    bool isSelectedAll = widget.provider.waitingOrder.every((element) {
      return element.isWatingOrderSelected == true;
    });
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              await widget.provider.getListWatingOrders();
              widget.reset();
            },
            child: ListView(children: [
              Column(
                children: [
                  ListView.builder(
                    itemCount: widget.orders.length + 1,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    itemBuilder: (context, index) {
                      if (index == widget.orders.length) {
                        return Visibility(
                            visible: widget.isLoadMore,
                            child: const Center(
                                child: CircularProgressIndicator()));
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: InkWell(
                          onTap: () => widget.provider.toggleSelectWaitingOrder(
                              widget.orders[index]["id"]),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    widget.orders[index]
                                            ["isWatingOrderSelected"]
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 24,
                                  ),
                                ),
                                Expanded(
                                  child: OrderListTile(
                                    order: widget.orders[index],
                                    index: index + 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                  const SizedBox(
                    height: 48,
                  )
                ],
              ),
            ]),
          ),
          if (widget.provider.waitingOrder.isNotEmpty)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 36,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isSelected)
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: DPrimaryButton.xsmall(
                              text: "Lấy hàng",
                              onPressed: () {
                                widget.provider.pickUpWaitingOrders();
                                widget.reset();
                              }),
                        ),
                      isSelectedAll
                          ? DOutlinedButton.small(
                              text: " Bỏ chọn tất cả",
                              onPressed: () =>
                                  widget.provider.unSelectAllWaitingOrders(),
                            )
                          : DOutlinedButton.xsmall(
                              text: "Chọn tất cả",
                              onPressed: () =>
                                  widget.provider.selectAllWaitingOrders(),
                            )
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _History extends StatefulWidget {
  const _History({
    Key? key,
    required this.provider,
    required this.isLoadMore,
    required this.reset,
  }) : super(key: key);

  final OrderProvider provider;
  final bool isLoadMore;
  final Function reset;

  @override
  State<_History> createState() => _HistoryState();
}

class _HistoryState extends State<_History> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await widget.provider.getHistory();
        widget.reset();
      },
      child: ListView(children: [
        Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 16, right: 16),
              child: Consumer<OrderProvider>(
                builder: (context, provider, child) {
                  return GestureDetector(
                    onTap: () => provider.sortOrders(),
                    child: provider.sort == "+"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Tăng dần",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.apply(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                              ),
                              const Icon(
                                  Icons.keyboard_double_arrow_up_rounded),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Giảm dần",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.apply(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                              ),
                              const Icon(
                                  Icons.keyboard_double_arrow_down_rounded),
                            ],
                          ),
                  );
                },
              ),
            )),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            if (index == widget.provider.history.length) {
              return Visibility(
                  visible: widget.isLoadMore,
                  child: const Center(child: CircularProgressIndicator()));
            }
            return TransactionListTile(
              title:
                  "${widget.provider.history[index].ownerName} - ${widget.provider.history[index].ownerPhoneContact}",
              subtitle:
                  "${widget.provider.history[index].shippingAddress}, ${widget.provider.history[index].shippingDistrict}, ${widget.provider.history[index].shippingWard}, ${widget.provider.history[index].shippingProvince}",
              description: DateTimeHelper.getDate(
                  widget.provider.history[index].expectedShippingDate),
              status: widget.provider.history[index].currentOrderStatus,
              showBottomDivider: true,
              onTap: () {},
            );
          },
          itemCount: widget.provider.history.length + 1,
        ),
      ]),
    );
  }
}
