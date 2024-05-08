import 'package:eccomerce/core/enums/enums.dart';
import 'package:eccomerce/features/home/controller/home_controller.dart';
import 'package:eccomerce/features/products/screens/addproduct_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavBar extends ConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: 80,
      child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(         
                width: size.width,
                height: 80,
                child: Stack(
                  children: [
                    CustomPaint(
                      size: Size(size.width, 80),
                      painter: BNBCustomePainter(),
                    ),
                    Center(
                      heightFactor: 0.6,
                      child: FloatingActionButton(
                        onPressed: (){},
                        backgroundColor: Colors.white,
                        child: IconButton(icon:Icon(Icons.add),color: Colors.black,onPressed: () {
                                Navigator.pushNamed(context, AddProduct.routeName);
                            }
                          ),
                        elevation: 0.1,
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(onPressed: (){go_to_home(ref,0);}, icon: Icon(Icons.home_outlined,color: Colors.black38,)),
                          IconButton(onPressed: (){go_to_home(ref,1);}, icon: Icon(Icons.shopping_cart_outlined,color: Colors.black38,)),
                          Container(width: size.width*.20,),
                          IconButton(onPressed: (){go_to_home(ref,2);}, icon: Icon(Icons.settings_outlined,color: Colors.black38)),
                          IconButton(onPressed: (){go_to_home(ref, 3);}, icon: Icon(Icons.person_outline_outlined,color: Colors.black38)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ], // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  void go_to_home(WidgetRef ref,int index){
    ref.read(homecontrollerProvider.notifier).changeScreen(ScreenType.values[index]);
  }  
}

class BNBCustomePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * .20, 0, size.width * .35, 0);
    path.quadraticBezierTo(size.width * .40, 0, size.width * .40, 20);
    path.arcToPoint(Offset(size.width * .60, 20),
        radius: Radius.circular(10.0), clockwise: false);

    path.quadraticBezierTo(size.width * .60, 0, size.width * .65, 0);
    path.quadraticBezierTo(size.width * .80, 0, size.width , 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawShadow(path, Colors.black, 5, true);
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}