import 'package:eccomerce/features/products/widgets/commom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/producttextdetails.dart';
import '../../../models/product_model.dart';

class ProductDetail extends ConsumerStatefulWidget {
  static const routeName = 'product-detail-screen';
  final ProductModel product;
  final String docid;
  const ProductDetail({super.key, required this.product, required this.docid});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductDetailState();
  }

  class _ProductDetailState extends ConsumerState<ProductDetail> {
  int counter = 0;

  void handleCounter(String opperand){
    setState(() {
      if(opperand=='minus'){
        if(counter!=0){
          counter = counter -1;
        }else{
          counter = counter;
        }
      }else{
        counter = counter + 1;
      } 
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final WIDTH = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: PreferredSize(preferredSize: Size(double.infinity,50), child: ProductAppBar(title:'Detail',productReview: false,)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                color: Colors.green.shade50,
                height: size.height / 3,
                child: Image.network(widget.product.images[0], height: size.height / 2)),
            Container(
              height: size.height / 2 + 50,
              color: Colors.transparent,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: CustomPaint(
                      size: Size(
                          WIDTH,
                          (WIDTH * 2.1818181818181817)
                              .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                      painter: RPSCustomPainter(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(left: 50),
                      width: WIDTH / 2.8,
                      height: 44,
                      color: Colors.transparent,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        elevation: 10.0,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.all(3),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.purple.shade50),
                                child: IconButton(
                                  onPressed: () {
                                    handleCounter('minus');
                                  },
                                  icon: Icon(Icons.remove),
                                  splashRadius: 15.0,
                                  color: Colors.white,
                                  padding: EdgeInsets.only(bottom: 1),
                                ),
                              ),
                              Text(
                                '${counter}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 20.0),
                              ),
                              Container(
                                  margin: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      handleCounter('Add');
                                    },
                                    icon: Icon(Icons.add),
                                    splashRadius: 15.0,
                                    color: Colors.white,
                                    iconSize: 14,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(top: 5, bottom: 4,left: 10,right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textDirection: TextDirection.ltr,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${widget.product.name}',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 30,color: Colors.amber[800]),
                          ),
                          SizedBox(height:8),
                          Text(
                            '\$${widget.product.prize}',
                            textAlign: TextAlign.start,
                            textDirection: TextDirection.ltr,
                            
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20,color: Color.fromRGBO(87, 87, 87,1),),
                          ),
                          SizedBox(height:8),
                          Text(
                            '4.4',
                            textAlign: TextAlign.start,
                            textDirection: TextDirection.ltr,
                            
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20,color: Colors.red,),
                          ),
                          SizedBox(height:22),
                          Text(
                            'Description',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 26,color: Colors.green),
                          ),
                          SizedBox(height:4),
                          Container(
                            height: 260,
                            width: WIDTH-20,
                            decoration: BoxDecoration(
                                border: Border.all(width: 2.0,color: Colors.orange),
                                borderRadius: BorderRadius.circular(10)
                              ),
                            child: SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  '${ widget.product.description }',
                                  maxLines: 30,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color.fromRGBO(243, 7, 7, 0.856),
                                    fontWeight: FontWeight.w500, fontSize: 22,),
                                  textAlign: TextAlign.justify
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 600,
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 90,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Container(
                        height: 50,
                        width: WIDTH - 30,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            onPressed: () {},
                            child: Text(
                              "Buy Now",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15.0,color:Colors.white),
                            )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
