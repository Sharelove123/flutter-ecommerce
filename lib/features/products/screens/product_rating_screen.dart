import 'package:eccomerce/features/products/widgets/commom_appbar.dart';
import 'package:eccomerce/features/products/widgets/product_review_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductReview extends ConsumerWidget {
  static const routeName = 'product-review-screen';
  const ProductReview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity,50),
        child: ProductAppBar(title:'Reviews',productReview: true,)
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductReviewCard()
          ],
        )
      ),
    );
  }
}