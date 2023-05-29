import 'package:flutter/material.dart';

class BottomCard extends StatelessWidget {
  final Widget child;

  const BottomCard(
      {required this.child,
      super.key});

@override

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16), //TODO:Здесь менять отступы

         child:child,



    );
  }
}
