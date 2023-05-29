import 'package:flutter/material.dart';

class PositiveButton extends StatelessWidget {
  final String text;
  final double padding;
  final double borderRadius;
  final VoidCallback onPressed;
  const PositiveButton({required this.text,required this.onPressed, super.key, required this.padding, required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return  Container(width: MediaQuery.of(context).size.width,padding:EdgeInsets.fromLTRB(padding, 0, padding, 0),child:

      ElevatedButton(


              onPressed: onPressed,
              style: ElevatedButton.styleFrom(

                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
                  padding: const EdgeInsets.all(16),
                  backgroundColor: const Color(0XFF51D275),
                  foregroundColor: const Color(0XFFFFFFFF)),
              child: Text(text,style: TextStyle(fontFamily:'Roboto',fontSize: 16),)),


    );

  }
}
