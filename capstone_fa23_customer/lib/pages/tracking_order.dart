import 'package:capstone_fa23_customer/core/enums/shipping_progress.dart';
import 'package:capstone_fa23_customer/core/enums/transaction_status.dart';
import 'package:capstone_fa23_customer/partials/modals/order_details.dart';
import 'package:capstone_fa23_customer/partials/contact_list_title.dart';
import 'package:capstone_fa23_customer/partials/progress_line.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TrackingOrderPage extends StatelessWidget {
  const TrackingOrderPage({super.key});

  String get _orderName => "Đơn hàng 182718";
  ShippingProgress get _status => ShippingProgress.onGoing;
  get _order => {
        "icon": "assets/images/contexts/brand_1.png",
        "title": "JCO Jwalk Mall",
        "subtitle": "Được giao bởi Gofood",
        "description": "20/03/2020",
        "status": TransactionStatus.ongoing,
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
        if (_status == ShippingProgress.feedback)
          Expanded(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              DAvatarCircle(
                  image: Image.asset("assets/images/contexts/avatar_2.png"),
                  radius: 115),
              const SizedBox(height: 16),
              Text(
                "Để lại đánh giá của bạn về shipper",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              RatingBar.builder(
                initialRating: 5,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: DColors.yellow,
                ),
                glow: false,
                unratedColor: DColors.gray4,
                onRatingUpdate: (rating) {},
              ),
            ]),
          )
        else
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
              ],
            ),
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
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return OrderDetailsModal(
                  order: _order,
                );
              },
              isScrollControlled: true,
            );
          },
        ),
        const SizedBox(height: 32),
      ]),
    );
  }
}
