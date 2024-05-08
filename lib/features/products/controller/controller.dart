import 'dart:io';
import 'package:eccomerce/features/auth/controller/auth_controller.dart';
import 'package:eccomerce/features/products/repository/repositoray.dart';
import 'package:eccomerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/providers/storage_repository_provider.dart';
import '../../../core/utils.dart';

final searchProductProvider = StreamProvider.family((ref, String query) {
  return ref.watch(productControllerProvider.notifier).searchProduct(query);
});

final productControllerProvider = StateNotifierProvider<ProductController,bool>((ref) {
  final productRepository = ref.watch(productRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return ProductController(
    productsrepo:productRepository,
    storageRepository: storageRepository,
    );
});

class ProductController extends StateNotifier<bool>{
  final ProductRepository _productsrepo;
  final StorageRepository _storageRepository;
  ProductController({
    required ProductRepository productsrepo,
    required StorageRepository storageRepository,
    }): _productsrepo=productsrepo,
        _storageRepository = storageRepository,
        super(false);

  void add_products(
    BuildContext context,
    WidgetRef ref,
    String name,
    String description,
    String category,
    List<File> images,
    String prize,
    String size,
    String? author,
    int? quantity,
    DateTime? time,
  )async{
    state = true;
    List<String> images_links=[];
    final user = ref.read(userProvider);
    for (var file in images) {
        String postId = const Uuid().v1();
        print('post id is ===>> $postId');
        final imageRes = await _storageRepository.storeFile(
            path: 'products/${user!.uid}',
            id: postId,
            file: file,
          );
          imageRes.fold((l) => showSnackBar(context,l.message), (r) => images_links.add(r));
        }
      print('image_liks are  ==>> $images_links');
      String productId = const Uuid().v1();
      print('product id are  ==>> $productId');
      ProductModel product = ProductModel(
        docId:productId,
        name: name, 
        description: description,
        category:category,
        images: images_links,
        prize: prize,
        size: size,
        author: user!.uid,
        quantity: quantity??1,
        time: DateTime.now()
        );
      final res = await _productsrepo.addProduct(product);
      state = false;
      res.fold((l) => showSnackBar(context,l.message), (r){
        showSnackBar(context,'product add successfully');
        Navigator.of(context).pop();
      });
  }

 

  get_product_by_category(String category){
     return _productsrepo.get_product_by_category(category);
  }


   Stream<List<ProductModel>> searchProduct(String query) {
    return _productsrepo.searchProduct(query);
  }

}