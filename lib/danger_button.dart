import 'package:flutter/material.dart';

class DangerButton extends StatelessWidget {
  final String text;
  final double padding;
  final VoidCallback onPressed;

  const DangerButton({required this.text, super.key, required this.padding, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  Container(width: MediaQuery.of(context).size.width,padding:EdgeInsets.fromLTRB(padding, 0, padding, 0),child:


        ElevatedButton(


              onPressed: onPressed,
              style: ElevatedButton.styleFrom(

                  padding: EdgeInsets.all(16),
                  backgroundColor: Color(0XEEF23030),
                  foregroundColor: Color(0XFFFFFFFF)),
              child: Text(text)),


    );

  }
}
