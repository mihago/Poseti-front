import 'package:flutter/material.dart';

class BotNavItem extends StatelessWidget {
  final String title;
  final IconData icondata;
  final bool isSelected;
  final ValueChanged<int> onChanged;
  final int index;
  const BotNavItem(
      {required this.title,
        required this.icondata,
        required this.isSelected,
        required this.onChanged,
        required this.index,
        super.key});
  Color getColor(bool isSelected) {
    if (isSelected) return Colors.white;
    return Color(0xFFF06B20);
  }

  Color getBColor(bool isSelected) {
    if (!isSelected) return Colors.white;
    return Color(0xFFF06B20);
  }

  void _handleTap() {
    onChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: _handleTap,
        child: Container(
          color: getBColor(isSelected),
          child: Column(
            children: [
              const SizedBox(height: 6.0),
              Icon(
                icondata,
                color: getColor(isSelected),
                size: 24,
              ),
              const SizedBox(height: 2.0),
              Text(title, style: TextStyle(fontFamily:'Roboto',color: getColor(isSelected))),
            ],
          ),
        ),
      ),
    );
  }
}