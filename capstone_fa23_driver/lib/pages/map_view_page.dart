import 'package:capstone_fa23_driver/core/models/order_model.dart';
import 'package:capstone_fa23_driver/helpers/datetime_helper.dart';
import 'package:capstone_fa23_driver/helpers/location_helper.dart';
import 'package:capstone_fa23_driver/modals/ship_cancel_dialog.dart';
import 'package:capstone_fa23_driver/modals/ship_success_dialog.dart';
import 'package:capstone_fa23_driver/partials/address_list_tile.dart';
import 'package:capstone_fa23_driver/partials/contact_list_title.dart';
import 'package:capstone_fa23_driver/partials/goong_map.dart';
import 'package:capstone_fa23_driver/partials/transaction_list_tile.dart';
import 'package:capstone_fa23_driver/providers/orders_provider.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapViewPage extends StatefulWidget {
  const MapViewPage({super.key, required this.id});

  final String id;

  @override
  State<MapViewPage> createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  double _displayBottomSheetSize = 0.2;
  int? distance;
  LatLng? currentLocation;
  Order? nextOrder;
  bool? isLoading = false;
  late Map<String, dynamic> order;

  Future<Order?> initOrderPage() async {
    setState(() {
      isLoading = true;
    });
    var order = await context.read<OrderProvider>().getOrder(widget.id);
    currentLocation = await LocationHelper().getCurrentLocation();
    // ignore: use_build_context_synchronously
    nextOrder = await context.read<OrderProvider>().getDataOfNextOrder();
    var orderStr = {
      "time": DateTimeHelper.getDate(order.expectedShippingDate),
      "title": order.id,
      "subtitle": "Được tạo bởi ${order.recipientName}",
      "code": order.id,
      "status": order.currentOrderStatus,
      "sender": {
        "name": order.senderName,
        "phone": order.senderPhoneNumber,
        "avatar": "assets/images/contexts/avatar_2.png",
        "address": order.senderPhoneNumber,
      },
      "receiver": {
        "name": order.ownerName,
        "phone": order.ownerPhoneContact,
        "avatar": "assets/images/contexts/avatar_1.jpg",
        "address":
            "${order.shippingAddress}, ${order.shippingWard}, ${order.shippingDistrict}, ${order.shippingProvince}",
        "distance": order.distanceFromYou,
      },
      "lat": order.lat,
      "lng": order.lng,
    };
    setState(() {
      this.order = orderStr;
      isLoading = false;
    });
    return order;
  }

  @override
  void initState() {
    initOrderPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DAppBar(title: "Mã đơn ${widget.id}"),
        body: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  GoongMap(
                    startPoints: currentLocation!,
                    endPoints: LatLng(order["lat"], order["lng"]),
                  ),
                  NotificationListener<DraggableScrollableNotification>(
                    onNotification:
                        (DraggableScrollableNotification dsNotification) {
                      if (dsNotification.extent <= 0.3) {
                        setState(() {
                          _displayBottomSheetSize = 0.2;
                        });
                      } else if (dsNotification.extent <= 0.6) {
                        setState(() {
                          _displayBottomSheetSize = 0.5;
                        });
                      } else {
                        setState(() {
                          _displayBottomSheetSize = 1;
                        });
                      }
                      return true;
                    },
                    child: DraggableScrollableSheet(
                        expand: true,
                        maxChildSize: 1,
                        minChildSize: 0.2,
                        initialChildSize: 0.2,
                        snap: true,
                        snapSizes: const [0.2, 0.5, 1],
                        builder: (BuildContext context,
                            ScrollController scrollController) {
                          return Container(
                            height: 700,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(8),
                              ),
                            ),
                            child: ListView(
                              controller: scrollController,
                              children: [
                                Column(
                                  children: [
                                    const DSwipeIndicator(),
                                    if (_displayBottomSheetSize == 1)
                                      _RoutingWithContact(
                                        order: order,
                                        complete: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  ShipSuccessDialog(
                                                    orderId: widget.id,
                                                  ));
                                        },
                                        cancel: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  const ShipCancelDialog());
                                        },
                                      ),
                                    if (_displayBottomSheetSize == 0.5)
                                      _Routing(
                                        order: order,
                                        complete: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  ShipSuccessDialog(
                                                    orderId: widget.id,
                                                  ));
                                        },
                                        cancel: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  const ShipCancelDialog());
                                        },
                                      ),
                                    if (_displayBottomSheetSize == 0.2)
                                      _ReceiverContact(receiver: {
                                        "name": order["receiver"]["name"],
                                        "phone": order["receiver"]["phone"],
                                        "avatar":
                                            "assets/images/contexts/avatar_1.jpg"
                                      }),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ));
  }
}

class _RoutingWithContact extends StatefulWidget {
  const _RoutingWithContact({
    Key? key,
    required this.order,
    required this.cancel,
    required this.complete,
  }) : super(key: key);

  final dynamic order;
  final VoidCallback cancel;
  final VoidCallback complete;

  @override
  State<_RoutingWithContact> createState() => _RoutingWithContactState();
}

class _RoutingWithContactState extends State<_RoutingWithContact> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionListTile(
          title: widget.order["title"],
          icon: Image.asset(widget.order["sender"]["avatar"]),
          description: widget.order["time"],
          subtitle: widget.order["subtitle"],
          status: widget.order["status"],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Người gửi",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ContactListTile(
                      title: widget.order["sender"]["name"] ?? "Unknown",
                      subtitle: widget.order["sender"]["phone"] ?? "Unknown",
                      avatar: Image.asset(widget.order["sender"]["avatar"]),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Divider(
                color: Theme.of(context).colorScheme.surface,
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Điểm giao hàng",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  AddressListTile(
                    avatar:
                        SvgPicture.asset("assets/images/icons/location.svg"),
                    title: widget.order["receiver"]["name"],
                    address: widget.order["receiver"]["address"],
                    subtitle: widget.order["receiver"]["distance"] != null
                        ? "Cách bạn ${widget.order["receiver"]["distance"]} km"
                        : null,
                    trailing:
                        SvgPicture.asset("assets/images/icons/direction.svg"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ContactListTile(
                      title: widget.order["receiver"]["name"],
                      subtitle: widget.order["receiver"]["phone"],
                      avatar: Image.asset(widget.order["receiver"]["avatar"]),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 36,
                  ),
                  Text(
                    "Mã đơn hàng ${widget.order["code"]}",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DPrimaryButton.small(
                        text: widget.order["status"].buttonLabel,
                        onPressed: () {
                          widget.complete();
                        },
                      ),
                      DOutlinedButton.small(
                        text: "Hủy",
                        onPressed: () {
                          widget.cancel();
                        },
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _Routing extends StatelessWidget {
  const _Routing({
    Key? key,
    required this.order,
    required this.complete,
    required this.cancel,
  }) : super(key: key);

  final dynamic order;
  final VoidCallback complete;
  final VoidCallback cancel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Người gửi",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 8,
              ),
              AddressListTile(
                avatar: DAvatarCircle(
                    image: Image.asset("assets/images/contexts/avatar_2.png"),
                    radius: 32),
                title: order["sender"]["name"] ?? "Unknown",
                address: order["sender"]["address"] ?? "Unknown",
                // subtitle: "Cách bạn ${order["sender"]["distance"]} km",
                trailing: SvgPicture.asset("assets/images/icons/direction.svg"),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Điểm giao hàng",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 8,
              ),
              AddressListTile(
                avatar: SvgPicture.asset("assets/images/icons/location.svg"),
                title: order["receiver"]["name"],
                address: order["receiver"]["address"],
                subtitle: order["receiver"]["distance"] != null
                    ? "Cách bạn ${order["receiver"]["distance"]} km"
                    : null,
                trailing: SvgPicture.asset("assets/images/icons/direction.svg"),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DPrimaryButton.small(
                text: order["status"].buttonLabel,
                onPressed: () {
                  complete();
                },
              ),
              DOutlinedButton.small(
                text: "Hủy",
                onPressed: () {
                  cancel();
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

class _ReceiverContact extends StatelessWidget {
  const _ReceiverContact({
    Key? key,
    required receiver,
  })  : _receiver = receiver,
        super(key: key);

  final dynamic _receiver;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ContactListTile(
        title: _receiver["name"],
        subtitle: _receiver["phone"],
        avatar: Image.asset(_receiver["avatar"]),
      ),
    );
  }
}
