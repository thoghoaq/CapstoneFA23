import 'package:capstone_fa23_driver/core/enums/transaction_status.dart';
import 'package:capstone_fa23_driver/modals/ship_cancel_dialog.dart';
import 'package:capstone_fa23_driver/modals/ship_success_dialog.dart';
import 'package:capstone_fa23_driver/partials/address_list_tile.dart';
import 'package:capstone_fa23_driver/partials/contact_list_title.dart';
import 'package:capstone_fa23_driver/partials/goong_map.dart';
import 'package:capstone_fa23_driver/partials/transaction_list_tile.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MapViewPage extends StatefulWidget {
  const MapViewPage({super.key});

  @override
  State<MapViewPage> createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  get _order => {
        "time": "17/8/2016 3:58 PM",
        "title": "JCO Jwalk Mall",
        "subtitle": "Được giao bởi Gofood",
        "code": "198271DX",
        "status": TransactionStatus.created,
        "sender": {
          "name": "Dunkin Donuts Ambarukm..",
          "phone": "+84 123134343",
          "avatar": "assets/images/contexts/brand_1.png",
          "address": "Jwalk Mall, Jl. A. Yani No. 88, Ambarukmo, Yogyakarta",
          "distance": 1.4
        },
        "receiver": {
          "name": "Priscilla Watson",
          "phone": "+84 123134343",
          "avatar": "assets/images/contexts/avatar_1.jpg",
          "address": "54, Lê Văn Việt, Quận 9, Thành phố Hồ Chí Minh",
          "distance": 10.2
        }
      };

  get _receiver => {
        "name": "Priscilla Watson",
        "phone": "+84 123134343",
        "avatar": "assets/images/contexts/avatar_1.jpg"
      };

  double _displayBottomSheetSize = 0.2;

  void cancel() {
    showDialog(
        context: context,
        builder: (BuildContext context) => const ShipCancelDialog());
  }

  void complete() {
    showDialog(
        context: context,
        builder: (BuildContext context) => const ShipSuccessDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DAppBar(title: "Mã đơn ${_order["code"]}"),
      body: Stack(
        children: [
          const GoongMap(),
          NotificationListener<DraggableScrollableNotification>(
            onNotification: (DraggableScrollableNotification dsNotification) {
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
                builder:
                    (BuildContext context, ScrollController scrollController) {
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
                                order: _order,
                                complete: complete,
                                cancel: cancel,
                              ),
                            if (_displayBottomSheetSize == 0.5)
                              _Routing(
                                order: _order,
                                complete: complete,
                                cancel: cancel,
                              ),
                            if (_displayBottomSheetSize == 0.2)
                              _ReceiverContact(receiver: _receiver),
                          ],
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class _RoutingWithContact extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionListTile(
          title: order["title"],
          icon: Image.asset(order["sender"]["avatar"]),
          description: order["time"],
          subtitle: order["subtitle"],
          status: order["status"],
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
                    "Điểm lấy hàng",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  AddressListTile(
                    avatar:
                        SvgPicture.asset("assets/images/icons/location.svg"),
                    title: order["sender"]["name"],
                    address: order["sender"]["address"],
                    subtitle: "Cách bạn ${order["sender"]["distance"]} km",
                    trailing:
                        SvgPicture.asset("assets/images/icons/direction.svg"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ContactListTile(
                      title: order["sender"]["name"],
                      subtitle: order["sender"]["phone"],
                      avatar: Image.asset(order["sender"]["avatar"]),
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
                    "Điểm nhận hàng",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  AddressListTile(
                    avatar:
                        SvgPicture.asset("assets/images/icons/location.svg"),
                    title: order["receiver"]["name"],
                    address: order["receiver"]["address"],
                    subtitle: "Cách bạn ${order["receiver"]["distance"]} km",
                    trailing:
                        SvgPicture.asset("assets/images/icons/direction.svg"),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ContactListTile(
                      title: order["receiver"]["name"],
                      subtitle: order["receiver"]["phone"],
                      avatar: Image.asset(order["receiver"]["avatar"]),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                "Mã đơn hàng ${order["code"]}",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DPrimaryButton.small(
                    text: "Hoàn thành",
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
                "Điểm lấy hàng",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 8,
              ),
              AddressListTile(
                avatar: SvgPicture.asset("assets/images/icons/location.svg"),
                title: order["sender"]["name"],
                address: order["sender"]["address"],
                subtitle: "Cách bạn ${order["sender"]["distance"]} km",
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
                "Điểm nhận hàng",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 8,
              ),
              AddressListTile(
                avatar: SvgPicture.asset("assets/images/icons/location.svg"),
                title: order["receiver"]["name"],
                address: order["receiver"]["address"],
                subtitle: "Cách bạn ${order["receiver"]["distance"]} km",
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
                text: "Hoàn thành",
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
