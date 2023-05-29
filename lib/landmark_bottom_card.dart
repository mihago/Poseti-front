import 'package:flutter/material.dart';
import 'package:poseti/bottom_card.dart';
import 'package:poseti/positive_button.dart';
import 'package:poseti/theme/custom_theme.dart';

class LandmarkBottomCard extends StatefulWidget {
  final ScrollController controller;
  final String definition;
  final String header;
  final String image;
  final VoidCallback changeIsOpened;

  const LandmarkBottomCard(
      {required this.controller,
      required this.changeIsOpened,
      required this.header,
      required this.definition,
      required this.image,
      super.key});

  @override
  State<LandmarkBottomCard> createState() => _LandmarkBottomCardState();
}

class _LandmarkBottomCardState extends State<LandmarkBottomCard> {
  void d() {
    widget.changeIsOpened();
  }

  @override
  void dispose() {
    d();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomCard(
      child: ListView(
        controller: widget.controller,
        children: [
          const SizedBox(height: 40),
          Center(
              child: Text(
            widget.header,
            style:  TextStyle(fontFamily:'Roboto',
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          )),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 140,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.network(widget.image).image, fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            height: 28,
          ),
          Center(
              child: Padding(padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Text(

                widget.definition,
                style: const TextStyle(fontFamily:'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.3
                ),
              ),)),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: PositiveButton(onPressed: () {
              widget.changeIsOpened();
              Navigator.of(context).pop();
            },text: "Понятно",padding: 20,borderRadius: 50,),
          ),
        ],
      ),
    );
  }
}
