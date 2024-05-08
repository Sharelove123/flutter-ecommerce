import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eccomerce/core/constants/firebase_constants.dart';
import 'package:eccomerce/core/providers/firebase_providers.dart';
import 'package:eccomerce/core/type_defs.dart';
import 'package:eccomerce/models/order.dart';
import 'package:eccomerce/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../../../core/failure.dart';

final dashBoardRepositoryProvider = Provider((ref){
  return DashBoardRepository(firestore: ref.watch(firestoreProvider));
});

class DashBoardRepository{
  final FirebaseFirestore _firestore;

  DashBoardRepository({required FirebaseFirestore firestore}):_firestore=firestore;
 
  
  //seller function


  Stream<List<ProductModel>> get_seller_products(String uid){
    return _products.where('author',isEqualTo: uid).snapshots()
      .map((event) => event.docs
        .map((e) => ProductModel.fromMap(e.data() as Map<String,dynamic>)
      ).toList()
    );
  }

  //customer functions

  Stream<List<OrderModel>> get_orders_by_uid(String uid){
    return _order.where('userId',isEqualTo: uid).snapshots()
      .map((event) => event.docs
        .map((e) => OrderModel.fromMap(e.data() as Map<String,dynamic>)
      ).toList()
    );
  }

  CollectionReference get _products => _firestore.collection(FirebaseConstants.products);
  CollectionReference get _order => _firestore.collection(FirebaseConstants.order);
  CollectionReference get _reviews => _firestore.collection(FirebaseConstants.reviews);
}