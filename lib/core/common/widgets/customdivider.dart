import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final String data;
  const CustomDivider({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width:width,
      height:60,
      child:IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Container(height: 1.0,color: Colors.green,width:width/4),
            SizedBox(width: 4,),
            Text(data),
            SizedBox(width: 4,),
            Container(height: 1.0,color: Colors.green,width: width/4,),
          ]
        ),
      )
    );
  }
}