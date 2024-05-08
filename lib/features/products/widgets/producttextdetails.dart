import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter{
  
  @override
  void paint(Canvas canvas, Size size) {
    
    

  // Layer 1
  
  Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;
     
         
    Path path_0 = Path();
    path_0.moveTo(size.width*0.0018182,size.height);
    path_0.lineTo(size.width*-0.0005455,size.height*0.0191917);
    path_0.quadraticBezierTo(size.width*-0.0035818,size.height*-0.0010167,size.width*0.0491455,size.height*-0.0016417);
    path_0.cubicTo(size.width*0.1073273,size.height*-0.0016417,size.width*0.2161273,size.height*0.0004583,size.width*0.2738545,size.height*0.0006667);
    path_0.cubicTo(size.width*0.4421091,size.height*0.0011500,size.width*0.3016000,size.height*0.1345917,size.width*0.4192545,size.height*0.1158500);
    path_0.cubicTo(size.width*0.4960727,size.height*0.1156417,size.width*0.6165091,size.height*0.1137000,size.width*0.6933273,size.height*0.1134917);
    path_0.cubicTo(size.width*0.8109818,size.height*0.1380083,size.width*0.7007091,size.height*0.0013250,size.width*0.8178182,size.height*-0.0013750);
    path_0.cubicTo(size.width*0.8769091,size.height*-0.0013750,size.width*0.8936727,size.height*-0.0010500,size.width*0.9527636,size.height*-0.0010500);
    path_0.quadraticBezierTo(size.width*1.0073091,size.height*-0.0008417,size.width*1.0023818,size.height*0.0286667);
    path_0.lineTo(size.width*1.0018182,size.height);

    canvas.drawPath(path_0, paint_fill_0);
  

  // Layer 1
  
  Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;
     
         
    
    canvas.drawPath(path_0, paint_stroke_0);
  
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}











