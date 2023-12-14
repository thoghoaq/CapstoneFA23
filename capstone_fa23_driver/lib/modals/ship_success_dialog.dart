import 'package:capstone_fa23_driver/core/models/order_model.dart';
import 'package:capstone_fa23_driver/core/models/traffic_model.dart';
import 'package:capstone_fa23_driver/providers/orders_provider.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ShipSuccessDialog extends StatefulWidget {
  const ShipSuccessDialog({super.key});

  @override
  State<ShipSuccessDialog> createState() => _ShipSuccessDialogState();
}

class _ShipSuccessDialogState extends State<ShipSuccessDialog> {
  String? nextUrl;

  Order? nextOrder;
  TrafficModel? traffic;

  void getNextLocation() async {
    var next = context.read<OrderProvider>().getNextOrder();
    setState(() {
      if (next != null) {
        nextUrl = "/orders/map-view/${next.id}";
        nextOrder = next;
      }
    });
    await getDistance();
  }

  getDistance() async {
    if (nextOrder == null && nextOrder?.lat != null && nextOrder?.lng != null) {
      var traffic = await context
          .read<OrderProvider>()
          .traffic(LatLng(nextOrder?.lat as double, nextOrder?.lng as double));
      setState(() {
        this.traffic = traffic;
      });
    }
  }

  @override
  void initState() {
    getNextLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/images/contexts/ship_success.svg"),
          const SizedBox(height: 16),
          Text(
            'Giao hàng',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 16),
          if (nextOrder != null)
            Text(
              'Tiếp tục lộ trình của bạn ?',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: DColors.gray3,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          if (nextOrder != null) const SizedBox(height: 16),
          if (nextOrder != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/icons/location.svg"),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nextOrder?.shippingAddress ?? "",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    if (traffic != null)
                      Text("Cách bạn ${traffic?.distance} km",
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: DColors.gray2,
                                    fontWeight: FontWeight.w500,
                                  ))
                  ],
                ),
              ],
            )
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsOverflowAlignment: OverflowBarAlignment.center,
      actionsOverflowButtonSpacing: 8,
      actions: [
        DPrimaryButton.small(
          onPressed: () async {
            await context.read<OrderProvider>().completeOrder();
            if (context.mounted) {
              context.pop();
              context.go(nextUrl ?? "/orders");
            }
          },
          text: "Chấp nhận",
        ),
        DOutlinedButton.small(
          onPressed: () {
            context.pop();
            context.go("/orders");
          },
          text: "Trở về trang chủ",
        ),
      ],
    );
  }
}
