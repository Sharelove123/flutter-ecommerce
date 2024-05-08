import 'package:eccomerce/features/cart/widgets/cartproductcard.dart';
import 'package:eccomerce/features/cart/controller/cart_controller.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/preservescroll.dart';
import '../../../models/product_model.dart';

class CartPage extends ConsumerWidget {
  static const routeName = 'cart-screen';
  const CartPage({super.key});

  void deleteCartProductInBulk(BuildContext context , WidgetRef ref){
    ref.read(cartControllerProvider.notifier).deleteCartProductInBulk(ref,context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final removeFromCart = ref.watch(cartRemoveProductsListProvider);
    final size = MediaQuery.of(context).size;
    return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            height: size.height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0,30.0,0.0,14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('My Cart',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25),),
                      TextButton(
                        onPressed: (){
                          deleteCartProductInBulk(context, ref);
                        }, 
                        child: Text('(Remove ${removeFromCart.length})',style: TextStyle(color: Colors.red)),)
                    ],
                  ),
                ),
                ElevatedButton.icon(
                 onPressed: (){
                  ref.read(cartControllerProvider.notifier).placeOrder(context, ref,'mumbai');
                 },
                 icon: Icon(Icons.shopping_cart_checkout_outlined),
                 label: Text("Checkout")
                ),
                Expanded(
                  child: FirestoreListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 80.0),
                    key: PageStorageKey(ScrollConstant.cartScreenProductViewListviewPreserveScroll),
                    query:ref.read(cartControllerProvider.notifier).querry,
                    itemBuilder: (BuildContext context, snapshot) {
                      final ProductModel product = ProductModel.fromMap(snapshot.data() as Map<String, dynamic>);
                      print("snapshotid ${snapshot.id}");
                      print(" product is $product");
                      return Column(
                        children: [
                          CartProductCard(product,snapshot.id),
                        ],
                      );
                    }),
                ),
              ],
            ),
          )
        );
      }
}