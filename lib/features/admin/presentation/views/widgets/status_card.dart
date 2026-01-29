import 'package:flutter/widgets.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({super.key, required this.title, required this.color});
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(40),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        spacing: 4,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
