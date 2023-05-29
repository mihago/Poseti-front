import 'package:flutter/material.dart';

class NormalButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double padding;

  const NormalButton({required this.text,required this.onPressed,required this.padding, super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(width: MediaQuery.of(context).size.width,padding:EdgeInsets.fromLTRB(padding, 0, padding, 0),child:


          OutlinedButton(


              onPressed: onPressed,


              child: Text(text,style: TextStyle(fontFamily:'Roboto',fontSize: 16),),
              style: OutlinedButton.styleFrom(

                  padding: EdgeInsets.all(16),
                  side: BorderSide(width:1),



                  foregroundColor: Color(0XFF000000))),


    );
  }
}
