import 'package:flutter/material.dart';
import 'package:furious_red_dragon/constants.dart';
import 'package:furious_red_dragon/components/buttons.dart';

class CustomPopup extends StatelessWidget {
  final String message;
  final IconData iconData;
  final Color backgroundColor;

  const CustomPopup({
    super.key,
    required this.message,
    required this.iconData,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            color: Colors.black,
          ),
          const SizedBox(width: 8),
          kBigGap,
          Text(
            message,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          kBigGap,
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.info, size: 25, color: Colors.black)),
        ],
      ),
    );
  }
}
