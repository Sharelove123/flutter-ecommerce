// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:eccomerce/models/product_model.dart';

class SearchProductResult {
  List<ProductModel> products;
  List<String> docid;
  SearchProductResult({
    required this.products,
    required this.docid,
  });

}
