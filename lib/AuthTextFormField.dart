
import 'package:flutter/material.dart';
typedef ValidationCallback = Function(String value);
class AuthTextFormField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final String type;
  final TextEditingController controller;
  final bool wasInvalid;


  const AuthTextFormField({required this.labelText,required this.controller,required this.type, required this.icon,super.key, required this.wasInvalid});
String? emailValidator(String? value){
  if (value == null || value.isEmpty) {
    return 'Это поле обязательно для заполнения';
  }else if(!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)){
    return "Некорректный адрес электронной почты";
  }else if(wasInvalid){
    return "Этот адрес уже занят, попробуйте войти";
  }
  return null;
}
String? notEmptyValidator(String? value){
  if (value == null || value.isEmpty) {
    return 'Это поле обязательно для заполнения';
  }
}
  String? passwordValidator(String? value){
    if (value == null || value.isEmpty) {
      return 'Это поле обязательно для заполнения';
    }else if(value.characters.length<6){
      return "Пароль должен иметь хотя бы 6 символов";
    }
    else if(wasInvalid){
      return "Неправильный пароль";
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return   TextFormField(
      controller: controller,
      validator: (value){
      if(type=="email"){
      return emailValidator(value);
    }else if(type=="password"){
       return passwordValidator(value);
    }else if(type=="nick"){
return notEmptyValidator(value);
      }
      return null;
      }
           ,
      obscureText: (type=="password")?true:false,
      decoration:  InputDecoration(

          prefixIcon: Icon(

            icon,
            color: Colors.black,
          ),
          labelText: labelText,
          labelStyle:
          TextStyle(fontFamily:'Roboto',color: Colors.black, fontWeight: FontWeight.w600),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF20ADEA), width: 2)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.black, width: 2))));

  }
}
