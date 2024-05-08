import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductReviewCard extends ConsumerWidget {
  const ProductReviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        height: size.height/4,
        width: size.width-30,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('7 jun 2019',style: TextStyle(fontSize: 10)),
                Row(
                  children: [
                    Icon(Icons.star,color: Colors.green,),
                    Icon(Icons.star,color: Colors.green),
                    Icon(Icons.star,color: Colors.green),
                    Icon(Icons.star,color: Colors.green),
                    Icon(Icons.star,color: Colors.green)
                  ],
                )
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('review title',style: TextStyle(fontSize: 20)),
                Text('User',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 15,),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left:10.0,right: 10.0,bottom: 5),
                width: size.width-30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.green.shade50,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('review description'),
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}