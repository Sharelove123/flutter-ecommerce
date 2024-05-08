import 'package:flutter/material.dart';

class ProductIcons extends StatelessWidget {
  final VoidCallback fun;
  final IconData icon;
  final bool left;
  const ProductIcons({super.key, required this.fun, required this.icon, required this.left});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      margin:left
        ?EdgeInsets.only(left: 10)
        :EdgeInsets.only(right: 10)
      ,
      decoration: BoxDecoration(
        border:Border.all(color: Colors.orangeAccent,
        ),
        shape: BoxShape.circle
      ),
      child: IconButton(
        onPressed: (){fun;}, 
        icon: Icon(icon,color: Colors.black,size: 30,)
        ),
    );
  }
}