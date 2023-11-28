import 'package:capstone_fa23_driver/core/enums/transaction_status.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

class TransactionListTile extends StatefulWidget {
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
  State<TransactionListTile> createState() => _TransactionListTileState();
}

class _TransactionListTileState extends State<TransactionListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: widget.showBottomDivider
                ? const BorderSide(color: DColors.gray6)
                : BorderSide.none,
            top: widget.showTopDivider
                ? const BorderSide(color: DColors.gray6)
                : BorderSide.none,
          ),
        ),
        child: InkWell(
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                // Leading
                if (widget.icon != null)
                  DAvatarCircle(image: widget.icon!, radius: 41),
                SizedBox(width: widget.icon != null ? 16 : 0),
                // Body
                Expanded(
                  child: SizedBox(
                    height: 66,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.title,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.subtitle ?? '',
                          style: Theme.of(context).textTheme.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.description ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: DColors.gray3),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                // Trailing
                SizedBox(width: widget.status != null ? 16 : 0),
                widget.status != null
                    ? Container(
                        width: 65,
                        height: 27,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: widget.status!.backgroundColor,
                        ),
                        child: Center(
                          child: Text(
                            widget.status!.label,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.apply(color: widget.status!.color),
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
