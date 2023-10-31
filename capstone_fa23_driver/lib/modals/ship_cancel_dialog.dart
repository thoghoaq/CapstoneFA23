import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ShipCancelDialog extends StatefulWidget {
  const ShipCancelDialog({super.key});

  @override
  State<ShipCancelDialog> createState() => _ShipCancelDialogState();
}

class _ShipCancelDialogState extends State<ShipCancelDialog> {
  final List<String> _commonReason = [
    "Không gọi được",
    "Trả về kho",
    "Trời mưa",
    "Khách không nhận đơn",
    "Khách gửi nhầm địa chỉ"
  ];
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("assets/images/contexts/ship_cancel.svg"),
            const SizedBox(height: 16),
            Text(
              'Hủy đơn hàng ?',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Hãy để lại một vài lý do',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: DColors.gray3,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsOverflowAlignment: OverflowBarAlignment.center,
      actionsOverflowButtonSpacing: 10,
      actions: [
        DMultiSelectChipDisplay(
          options: _commonReason,
        ),
        SizedBox(
          height: 80,
          child: DTextBox(
            hintText: "Lý do khác",
            controller: controller,
            maxLines: 2,
          ),
        ),
        DOutlinedButton.small(
          onPressed: () {
            context.pop();
            context.go("/orders");
          },
          text: "Hủy",
        ),
      ],
    );
  }
}
