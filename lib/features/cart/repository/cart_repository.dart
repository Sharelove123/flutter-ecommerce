import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eccomerce/core/constants/firebase_constants.dart';
import 'package:eccomerce/core/type_defs.dart';
import 'package:eccomerce/features/auth/controller/auth_controller.dart';
import 'package:eccomerce/models/product_model.dart';
import 'package:eccomerce/models/order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../../../core/failure.dart';
import '../../../core/providers/firebase_providers.dart';


final cartRepositoryProvider = Provider((ref){
  final  user = ref.watch(userProvider);
  final String userUid = user!.uid;
  return CartRepository(firestore: ref.watch(firestoreProvider),userUid: userUid);
});

class CartRepository{
  final FirebaseFirestore _firestore;
  final String userUid;
  CartRepository({required FirebaseFirestore firestore,required this.userUid}):_firestore=firestore;

  FutureVoid addProducttoCart(String productId,ProductModel product)async{
      try {
        return right(cart.doc(userUid).collection('products').doc(productId).set(product.toMap()));
      }on FirebaseException catch (e) {
        throw e.message!;
      }catch (e){
      return left(Failure(e.toString()));
    }
  }


  //getcartproductslist from this method right now using FlutterFirestoreListview
  Stream<List<ProductModel>> getUserCartProduct(){
    return cart.doc(userUid).collection('products').snapshots().map(
      (event) => event.docs.map(
        (e){
          print(e.data());
          return ProductModel.fromMap(e.data() as Map<String,dynamic>);
        }
      ).toList(),
    );
  }

  FutureVoid deleteCartProductInBulk(List<String> docidsList)async{
    try {
        if(docidsList.length!=0){
          for (String docid in docidsList) {
            cart.doc(userUid).collection('products').doc(docid).delete();
          }
          return right('success');
        }else{
          return left(Failure('Select products to be removed'));
        }
      }on FirebaseException catch (e) {
        throw e.message!;
      }catch (e){
      return left(Failure(e.toString()));
    }
  }

  FutureVoid deleteCartProduct(String docid)async{
    try {
        return right(cart.doc(userUid).collection('products').doc(docid).delete());
      }on FirebaseException catch (e) {
        throw e.message!;
      }catch (e){
      return left(Failure(e.toString()));
   }
  }

  FutureVoid placeOrder(OrderModel orderdata)async{
    try {
      return right(order.add(orderdata.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Query<Object> get querry => cart.doc(userUid).collection('products');
  
  CollectionReference get cart => _firestore.collection(FirebaseConstants.cart);
  CollectionReference get order => _firestore.collection(FirebaseConstants.order);

  //todo
  //delete cartproducts,detailproductpage,seachproduct

}