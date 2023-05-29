import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:poseti/bottom_card.dart';
import 'package:poseti/landmark_tile.dart';
import 'package:poseti/landmark_with_distance.dart';
import 'package:poseti/positive_button.dart';

import 'landmark_bottom_card.dart';
import 'landmark_request.dart';

class LandmarkSuggestons extends StatefulWidget {
  final ScrollController controller;
  final VoidCallback changeIsOpened;
  final List<LandmarkWithDistance> landmarks;

  const LandmarkSuggestons(
      {required this.controller,
      required this.changeIsOpened,
      required this.landmarks,
      super.key});

  @override
  State<LandmarkSuggestons> createState() => _LandmarkSuggestonsState();
}

class _LandmarkSuggestonsState extends State<LandmarkSuggestons> {
  void d() {
    widget.changeIsOpened();
  }

  @override
  void dispose() {
    d();
    super.dispose();
  }
  Widget makeDismissible(Widget child) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => widget.changeIsOpened,
        child: GestureDetector(onTap: () {}, child: child));
  }
void showLandmark(int i){
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius:
          BorderRadius.vertical(top: Radius.circular(20))),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return makeDismissible(DraggableScrollableSheet(
          initialChildSize: 0.3,
          minChildSize: 0.3,
          maxChildSize: 1,
          builder: (BuildContext context,
              ScrollController scrollController) {
            return LandmarkBottomCard(
                changeIsOpened: widget.changeIsOpened,
                controller: scrollController,
                header: widget.landmarks[i].landmarkInfo.name,
                definition: widget.landmarks[i].landmarkInfo.description,
                image: widget.landmarks[i].landmarkInfo.image);
          },
        ));
      });
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
            "Достопримечательности рядом",
            style: const TextStyle(fontFamily:'Roboto',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          )),
          SizedBox(height: 16),

           ListView.builder(

              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: widget.landmarks.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(onTap:()=>showLandmark(index),child: LandmarkTile(landmark: widget.landmarks[index]));
              },

              ),


          SizedBox(
            height: 28,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),

            child: PositiveButton(onPressed: () {
              widget.changeIsOpened();
              Navigator.of(context).pop();
            },text: "Понятно",padding: 20,borderRadius: 50,)
          ),
        ],
      ),
    );

  }
}
