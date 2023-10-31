import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ShipSuccessDialog extends StatelessWidget {
  const ShipSuccessDialog({super.key});

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
            'Giao thành công',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Tiếp tục lộ trình của bạn ?',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: DColors.gray3,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/images/icons/location.svg"),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("554, 12B Amasado",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  Text("Cách bạn 10.2 km",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
          onPressed: () {
            context.pop();
            context.go("/orders/map-view");
          },
          text: "Chấp nhận",
        ),
        DOutlinedButton.small(
          onPressed: () {
            context.pop();
            context.go("/home");
          },
          text: "Trở về trang chủ",
        ),
      ],
    );
  }
}
