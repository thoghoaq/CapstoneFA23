import 'package:capstone_fa23_driver/core/enums/route_calculation_type.dart';
import 'package:design_kit/material.dart';
import 'package:flutter/material.dart';

class RouteCalculationTypeDialog extends StatefulWidget {
  const RouteCalculationTypeDialog(
      {super.key, required this.calculateRoutes, this.callbackAction});

  final Function(RouteCalculationType?) calculateRoutes;
  final CallbackAction? callbackAction;

  @override
  State<RouteCalculationTypeDialog> createState() =>
      _RouteCalculationTypeDialogState();
}

class _RouteCalculationTypeDialogState
    extends State<RouteCalculationTypeDialog> {
  RouteCalculationType? selectedType = RouteCalculationType.distance;

  void handleClick(RouteCalculationType? value) {
    setState(() {
      selectedType = value;
    });
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
          const SizedBox(height: 16),
          Text(
            'Chọn kiểu tính toán lộ trình',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Radio(
                value: RouteCalculationType.distance,
                groupValue: selectedType,
                onChanged: (value) => handleClick(value),
              ),
              GestureDetector(
                onTap: () => handleClick(RouteCalculationType.distance),
                child: Text(
                  RouteCalculationType.distance.label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: RouteCalculationType.duration,
                groupValue: selectedType,
                onChanged: (value) => handleClick(value),
              ),
              GestureDetector(
                onTap: () => handleClick(RouteCalculationType.duration),
                child: Text(
                  RouteCalculationType.duration.label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: RouteCalculationType.random,
                groupValue: selectedType,
                onChanged: (value) => handleClick(value),
              ),
              GestureDetector(
                onTap: () => handleClick(RouteCalculationType.random),
                child: Text(
                  RouteCalculationType.random.label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsOverflowAlignment: OverflowBarAlignment.center,
      actionsOverflowButtonSpacing: 8,
      actions: [
        DOutlinedButton.small(
          text: "Tính toán lộ trình",
          onPressed: () async {
            await widget.calculateRoutes(selectedType);
          },
        ),
      ],
    );
  }
}
