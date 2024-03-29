import 'package:capstone_fa23_customer/core/enums/transaction_status.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

class TransactionListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? description;
  final Widget? icon;
  final TransactionStatus? status;
  final VoidCallback? onTap;
  final bool? isFeedback;
  final bool showTopDivider;
  final bool showBottomDivider;

  const TransactionListTile({
    super.key,
    required this.title,
    this.icon,
    this.status,
    this.onTap,
    this.showBottomDivider = true,
    this.showTopDivider = false,
    this.subtitle,
    this.description,
    this.isFeedback,
  });

  @override
  Widget build(BuildContext context) {
    TransactionStatus? orderStatus;
    orderStatus = status;
    if (isFeedback == false) {
      orderStatus = TransactionStatus.feeback;
    }
    return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: showBottomDivider
                ? const BorderSide(color: DColors.gray6)
                : BorderSide.none,
            top: showTopDivider
                ? const BorderSide(color: DColors.gray6)
                : BorderSide.none,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                // Leading
                if (icon != null) DAvatarCircle(image: icon!, radius: 41),
                SizedBox(width: icon != null ? 16 : 0),
                // Body
                Expanded(
                  child: SizedBox(
                    height: 66,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w600),
                        ),
                        Text(
                          subtitle ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          description ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: DColors.gray3),
                        ),
                      ],
                    ),
                  ),
                ),
                // Trailing
                SizedBox(width: status != null ? 16 : 0),
                orderStatus != null
                    ? Container(
                        width: 65,
                        height: 27,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: orderStatus.backgroundColor,
                        ),
                        child: Center(
                          child: Text(
                            orderStatus.label,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.apply(color: status!.color),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ));
  }
}
