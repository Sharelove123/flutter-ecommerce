import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final int maxLine;
  const CustomTextField({super.key, required this.hintText, required this.controller, required this.maxLine});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
       controller: controller,
       decoration: InputDecoration(
       hintText: hintText,
       filled: true,
       border: InputBorder.none              
     ),
     maxLines: maxLine,
     validator: (value) {
       if(value == null || value.isEmpty){
        return 'Enter your product $hintText';
       }
       return null;
     },
    );
  }
}