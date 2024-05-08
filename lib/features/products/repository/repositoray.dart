import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eccomerce/core/constants/firebase_constants.dart';
import 'package:eccomerce/core/providers/firebase_providers.dart';
import 'package:eccomerce/core/type_defs.dart';
import 'package:eccomerce/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import '../../../core/failure.dart';


final productRepositoryProvider = Provider((ref){
  return ProductRepository(firestore: ref.watch(firestoreProvider));
});

class ProductRepository{
  final FirebaseFirestore _firestore;

  ProductRepository({required FirebaseFirestore firestore}):_firestore=firestore;
 
  FutureVoid addProduct(ProductModel product)async{
    try{
        return right(products.doc(product.docId).set(product.toMap()));
      } on FirebaseException catch (e) {
        throw e.message!;
      }catch (e){
          return left(Failure(e.toString()));
      }
  }



  
  Query<Object?> get_product_by_category (String category) {
     if(category=='All'){
      return products.orderBy('time');
     }
     return products.where('category',isEqualTo: category);
  } 
  

  Stream<List<ProductModel>> searchProduct(String query) {
    return products
        .where(
          'name',
          isGreaterThanOrEqualTo: query.isEmpty ? 0 : query,
          isLessThan: query.isEmpty
              ? null
              : query.substring(0, query.length - 1) +
                  String.fromCharCode(
                    query.codeUnitAt(query.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map((event) {
      List<ProductModel> products = [];
      //List<String> docid = [];
      for (var community in event.docs) {
        products.add(ProductModel.fromMap(community.data() as Map<String, dynamic>));
       //docid.add((community.id as String));
      }
     // SearchProductResult searchdata = SearchProductResult(products: products,docid: docid);
      return products;
    });
  }

  

  CollectionReference get products => _firestore.collection(FirebaseConstants.products);
  CollectionReference get reviews => _firestore.collection(FirebaseConstants.reviews);

}