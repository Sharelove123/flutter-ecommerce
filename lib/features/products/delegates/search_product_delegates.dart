import 'package:eccomerce/core/common/widgets/errortext.dart';
import 'package:eccomerce/core/common/widgets/loader.dart';
import 'package:eccomerce/features/products/controller/controller.dart';
import 'package:eccomerce/features/products/screens/product_detail_screen.dart';
import 'package:eccomerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/arguments.dart';

class SearchProductDelegate extends SearchDelegate {
  final WidgetRef ref;
  SearchProductDelegate(this.ref);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ref.watch(searchProductProvider(query)).when(
          data: (products) {
            return ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              final product = products[index];
              final docid = product.docId;
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(product.images[0]),
                ),
                title: Text('${product.name}'),
                onTap: () => navigateToproduct(context,product,docid),
              );
            },
          );
          },
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }

  void navigateToproduct(BuildContext context, ProductModel product ,String docid ){
    final arguments = ProductDetailArguments(product: product, docid: docid);
    Navigator.of(context).pushNamed(ProductDetail.routeName,arguments: arguments);
  }
}