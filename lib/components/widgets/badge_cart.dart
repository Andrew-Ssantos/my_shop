import 'package:flutter/material.dart';

class BadgeCart extends StatelessWidget {
  final Widget child;
  final String value;
  final Color? color;

  const BadgeCart({
    required this.child,
    required this.value,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          right: 5,
          top: 3,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color ?? Theme.of(context).colorScheme.secondary,
            ),
            constraints: const BoxConstraints(
              minHeight: 15,
              minWidth: 15,
            ),
            child: Text(
              textAlign: TextAlign.center,
              value,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
