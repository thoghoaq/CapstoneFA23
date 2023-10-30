import 'package:capstone_fa23_customer/domain/enums/shipping_progress.dart';
import 'package:capstone_fa23_customer/partials/contact_list_title.dart';
import 'package:capstone_fa23_customer/partials/progress_line.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

class TrackingOrderPage extends StatelessWidget {
  const TrackingOrderPage({super.key});

  String get _orderName => "Đơn hàng 182718";
  ShippingProgress get _status => ShippingProgress.goingToPickup;
  get _order => {
        "icon": "assets/images/contexts/brand_1.png",
        "title": "JCO Jwalk Mall",
        "subtitle": "Được giao bởi Gofood",
        "description": "20/03/2020",
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DAppBar(
        title: _orderName,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const DIconCircle(
                icon: Icon(
              Icons.notifications,
              size: 16,
            )),
            color: Theme.of(context).colorScheme.background,
          ),
        ],
      ),
      body: Column(children: [
        const SizedBox(
          height: 16,
        ),
        ContactListTile(
          avatar: Image.asset("assets/images/contexts/avatar_2.png"),
          title: "Armayoga (Tài xế)",
          subtitle: "BMW 2020 DB",
        ),
        Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(width: 231, child: Image.asset(_status.image)),
            const SizedBox(height: 16),
            Text(
              _status.message,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            Text(
              _status.description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ]),
        ),
        ProgressLine(
          percent: _status.percent,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              if (_order["icon"] != null)
                DAvatarCircle(image: Image.asset(_order["icon"]), radius: 41),
              SizedBox(width: _order["icon"] != null ? 16 : 0),
              Expanded(
                child: SizedBox(
                  height: 66,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        _order["title"],
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        _order["subtitle"] ?? '',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Text(
                        _order["description"] ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: DColors.gray3),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 75,
                height: 27,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: DColors.softGreen,
                ),
                child: Center(
                  child: Text(
                    "20-30 Phút",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.apply(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              )
            ],
          ),
        ),
        DOutlinedButton.small(
          text: "Xem chi tiết",
          onPressed: () {},
        ),
        const SizedBox(height: 32),
      ]),
    );
  }
}
