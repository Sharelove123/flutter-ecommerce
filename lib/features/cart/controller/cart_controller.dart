import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eccomerce/features/auth/controller/auth_controller.dart';
import 'package:eccomerce/models/product_model.dart';
import 'package:eccomerce/models/order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/utils.dart';
import '../repository/cart_repository.dart';

final cartRemoveProductsListProvider = StateProvider<List<String>>((ref) =>[]);
final cartDataLength = StateProvider<int>((ref) =>0);

final cartProductProvider = StreamProvider((ref){
    final cartController = ref.watch(cartControllerProvider.notifier);
    return cartController.getCartProducts();
});

final cartControllerProvider = StateNotifierProvider<CartController,bool>((ref) {
  final cartRepository = ref.watch(cartRepositoryProvider);
  final cartRemoveProductsList = ref.watch(cartRemoveProductsListProvider);
  return CartController(
    cartrepo:cartRepository,
    removeFromCartLIst: cartRemoveProductsList,
    );
});

class CartController extends StateNotifier<bool>{
  final CartRepository _cartrepo;
  final List<String> removeFromCartLIst;
  CartController({
    required this.removeFromCartLIst,
    required CartRepository cartrepo,
    }): _cartrepo=cartrepo,
        super(false);

  void addProductToCart(BuildContext context,String productId,ProductModel product)async{
    state = true;
    final res = await _cartrepo.addProducttoCart(productId, product);
    state = false;
    res.fold((l) => showSnackBar(context,l.message), (r){
      showSnackBar(context,'product added to cart successfully');
    });
  }


  Stream<List<ProductModel>> getCartProducts(){
    Stream<List<ProductModel>> cartData = _cartrepo.getUserCartProduct();
    return cartData;
  }

  void deleteCartProductInBulk(WidgetRef ref , BuildContext context)async{
    state = true;
    final res = await _cartrepo.deleteCartProductInBulk(removeFromCartLIst);
    showSnackBar(context,'product removed from cart successfully');
    state=false;
    res.fold((l) => showSnackBar(context,l.message), (r){
      ref.watch(cartRemoveProductsListProvider.notifier).update((state){
        List<String> newState = [];
        return newState;
    });
    });
  }

   void deleteCartProduct(WidgetRef ref,BuildContext context,String docid)async{
    state = true;
    final res = await _cartrepo.deleteCartProduct(docid);
    res.fold((l) => showSnackBar(context,l.message), (r){
      ref.watch(cartRemoveProductsListProvider.notifier).update((state){
        List<String> newState = List.from(state);
        newState.remove(docid);
        return newState;
    });
      showSnackBar(context,'product removed from cart successfully');
    });
    state=false;
    }
  
  Future<String?> placeOrder(BuildContext context,WidgetRef ref,String address) async {
    final cartData = ref.read(cartProductProvider).value!;
    String postId = const Uuid().v1();
    double sum = 0;
    for(ProductModel cartItem in cartData){
        sum+=int.parse(cartItem.prize);
    }
    final user = ref.read(userProvider);
    OrderModel order = OrderModel(
      id: postId, 
      products: cartData, 
      address: address, 
      userId: user!.uid,
      orderAt: DateTime.now(),
      status: 0, 
      totalPrice: sum,
    );
    final res = await _cartrepo.placeOrder(order);
    res.fold((l) => showSnackBar(context,l.message), (r){
      showSnackBar(context,' Order Placeing Wait....');
    });
    return order.id;
  }
  

  Query<Object> get querry => _cartrepo.querry;

}