import 'package:capstone_fa23_customer/domain/enums/transaction_status.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

class TransactionListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? description;
  final Widget? icon;
  final TransactionStatus? status;
  final VoidCallback? onTap;
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
  });

  @override
  Widget build(BuildContext context) {
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
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          description ?? '',
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
                status != null
                    ? Container(
                        width: 65,
                        height: 27,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: status!.backgroundColor,
                        ),
                        child: Center(
                          child: Text(
                            status!.label,
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
