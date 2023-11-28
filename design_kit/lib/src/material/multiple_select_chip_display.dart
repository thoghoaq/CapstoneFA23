import 'package:flutter/material.dart';

class DMultiSelectChipDisplay extends StatefulWidget {
  final List<String> options;
  final List<String> selectedChips;
  const DMultiSelectChipDisplay(
      {Key? key, required this.options, required this.selectedChips})
      : super(key: key);

  @override
  State<DMultiSelectChipDisplay> createState() =>
      _MultiSelectChipDisplayState();
}

class _MultiSelectChipDisplayState extends State<DMultiSelectChipDisplay> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: widget.options.map((String option) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: SizedBox(
            height: 40,
            child: FilterChip(
              label: Text(option,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.w500,
                      )),
              backgroundColor: Theme.of(context).colorScheme.surface,
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              showCheckmark: false,
              selectedColor: Theme.of(context).colorScheme.primary,
              selected: widget.selectedChips.contains(option),
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    widget.selectedChips.add(option);
                  } else {
                    widget.selectedChips.remove(option);
                  }
                });
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
