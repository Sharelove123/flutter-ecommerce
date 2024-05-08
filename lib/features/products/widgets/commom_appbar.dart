import 'package:eccomerce/core/common/widgets/loader.dart';
import 'package:eccomerce/features/cart/controller/cart_controller.dart';
import 'package:eccomerce/features/cart/screens/cart.dart';
import 'package:eccomerce/features/products/screens/product_rating_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductAppBar extends ConsumerWidget {
  final String title;
  final bool productReview;
  const ProductAppBar({
    super.key,
    required this.title,
    required this.productReview,
    });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.green.shade50,
        title: Center(
            child: Text(
            '${title}',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        )),
        actions: [
          ref.watch(cartProductProvider).when(
            data: (data){
              return Stack(
                children: [
                  IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, CartPage.routeName);
                  },
                  icon:const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black,
                  )),
                  Positioned(
                    top: 1,
                    right: 6,
                    child: Text('${data.length}'))
                  ],
                );
              },
            error: (err,sht){
              return  IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, CartPage.routeName);
                  },
                  icon:const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black,
              ));
            },
            loading: ()=>Loader()
          ),
          productReview
          ?SizedBox():   IconButton(
              onPressed: () {
                Navigator.pushNamed(context, ProductReview.routeName);
              },
              icon:const Icon(
                Icons.reviews_outlined,
                color: Colors.black,
              ),
              tooltip: 'product reviews',
              )
        ],
    );

  }
}
