import 'package:flutter/material.dart';

class ArrowWidget extends StatelessWidget {
  final void Function()? onTap;
  final bool isLeftArrow;
  final bool isArrowsActive;
  const ArrowWidget({
    super.key,
    required this.isArrowsActive,
    this.onTap,
    this.isLeftArrow = true,
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isArrowsActive
          // ? () => context.read<TrackerCubit>().previousPerson()
          ? onTap
          : null,
      child: Icon(
        isLeftArrow ? Icons.chevron_left : Icons.chevron_right,
        key: const Key('gesture1'),
        color: isArrowsActive ? Colors.blue : Colors.grey,
      ),
    );
  }
}
