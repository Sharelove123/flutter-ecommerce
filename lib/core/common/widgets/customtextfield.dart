import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTextField extends ConsumerWidget {
  final Icon iconName;
  final String hintText;
  final bool Password;
  final TextEditingController controller;
  const CustomTextField({Key? key,required this.iconName, required this.hintText, required this.Password, required this.controller}) : super(key: key);

  
  @override
  Widget build(BuildContext context , WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      width: MediaQuery.of(context).size.width - 20,
      height: 80,
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 50,
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 0, 2),
                    child: TextFormField(
                      controller: controller,
                      obscureText: Password,
                      maxLines: 1,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:hintText
                      ),
                      validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Enter your product $hintText';
                      }
                      return null;
                    },
                    ),
                  ),
                ),
              ),
            ),
          Positioned(
            left: 20,
            child: Card(
              shape: CircleBorder(),
              elevation: 10,
              child: Container(
                width:60,
                height: 60,
                child: iconName,
              ),
            ),
          ),
        ],
      ),
    );
  }
}