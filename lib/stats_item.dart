import 'package:flutter/material.dart';
class StatsItem extends StatelessWidget {
  final String definition;
  final String index;
  const StatsItem({Key? key, required this.definition, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,mainAxisSize: MainAxisSize.max,children: [
      Flexible(child: Text(definition)),
      Text(index,style: const TextStyle(fontFamily:'Roboto',fontSize: 24,fontWeight: FontWeight.w600,color: Color(0xFF51D275)),)
    ],);
  }
}
