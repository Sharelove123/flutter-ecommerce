// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:eccomerce/models/arguments.dart';
import 'package:flutter/material.dart';
import '../../../features/products/screens/product_detail_screen.dart';
import '../../../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final String docid;
  final VoidCallback addProductToCart;
  final double width;
  const ProductCard({
    Key? key,
    required this.product,
    required this.addProductToCart,
    required this.docid, 
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
        final arguments = ProductDetailArguments(product: product, docid: docid);
        Navigator.of(context).pushNamed(ProductDetail.routeName,arguments: arguments);
      },
      child: Container(
          width: width,
          margin: EdgeInsets.only(left: 12),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white, 
             )
            ],
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.3),
                Colors.transparent
              ],
              begin: Alignment.topLeft,
              end: Alignment(0.1, 0.0)
              )
          ),
    
          child: Center(
            child: Column(
              children: [
                Center(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: EdgeInsets.only(top: 10),
                        height: 200,
                        width: width-40,
                        color: Colors.white.withOpacity(0.01),
                        child: Card(
                          elevation: 8,
                          shadowColor: Colors.white.withOpacity(0.1),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: Image.network(product.images[0]),
                        ),
                      ),
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(19.0,8,19.0,0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text( product.name.substring(0, 5)+"..",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 25,color: Colors.black,)),
                          SizedBox(height: 2,),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text('\$'+product.prize,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 18,color: Colors.red.shade400),),
                          )
                        ],
                      ),
                      Container(
                        height: 60,
                        width: 60,
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(color: Colors.black,shape: BoxShape.circle),
                              child: IconButton(splashRadius: 25,iconSize: 10,onPressed:addProductToCart,icon: const Icon(Icons.add,color: Colors.white,size: 20,))
                            ),
                          )
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
      ),
    );
  }
}
