import 'package:eccomerce/features/products/screens/product_detail_screen.dart';
import 'package:eccomerce/models/arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controller/cart_controller.dart';
import '../../../models/product_model.dart';


class CartProductCard extends ConsumerStatefulWidget {
  final ProductModel cartProduct;
  final String docid;
  const CartProductCard(this.cartProduct,this.docid, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartProductCardState();
}

class _CartProductCardState extends ConsumerState<CartProductCard> {
  bool ischecked = false;
  int quantity = 0;

  changequantity(String type){
    setState(() {
      if(type=='decrement'){
        if(quantity!=0){
          quantity--;
        }
      }else{
        quantity++;
      }
    });
  }


  void removecard(){
    final data = ref.read(cartRemoveProductsListProvider);
    print('cart remove  list $data');
  }

  void deleteCartProduct(){
    ref.read(cartControllerProvider.notifier).deleteCartProduct(ref,context, widget.docid);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap:() {
        final arguments = ProductDetailArguments(product: widget.cartProduct, docid: widget.docid);
        Navigator.of(context).pushNamed(ProductDetail.routeName,arguments: arguments);
      },
      child: Container(
        height:  size.height/6+60,
        child: Row(
          children: [
            Transform.scale(
              scale: 1.5,
              child: Checkbox(value: ischecked, onChanged: (bool){
                setState(() {
                if(ischecked){
                  ref.watch(cartRemoveProductsListProvider.notifier).update((state){
                  List<String> newState = List.from(state);
                  newState.remove(widget.docid);
                  return newState;
                });
                  ischecked = false;
                }else{
                  ref.watch(cartRemoveProductsListProvider.notifier).update((state) => [...state,widget.docid]);
                  ischecked=true;
                }
              });},activeColor: Color.fromARGB(255,1, 15, 137),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),),
            ),
            Container(
              height:  size.height/5+50,
              width: size.width-60,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color.fromARGB(255,250, 244, 240),),
                      height: size.height/5,
                      width: size.width-80,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Stack(children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(margin: EdgeInsets.fromLTRB(10.0,0.0, 0.0, 12.0),height: size.height/8,width: size.width/4+20,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),)),
                                Positioned(
                                  bottom: 45,
                                  child: Image.network(
                                    widget.cartProduct.images[0],
                                    height: size.height/9,
                                    width: size.width/3,
                                    ),
                                )
                            ],),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12.0, 8, 2.0 , 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.cartProduct.name,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 25,color: Color.fromARGB(255,28, 26, 49)),),
                                  Text(widget.cartProduct.size,style: TextStyle(fontWeight: FontWeight.w100,fontSize: 20,color: Color.fromARGB(255,185, 180, 184)),),
                                  SizedBox(height: 5,),
                                  Text(widget.cartProduct.prize,style: TextStyle(fontWeight: FontWeight.w900,fontSize: 28,color: Color.fromARGB(255,2, 22, 152)),),
                                  Container(
                                    width: 140,
                                    height: 40,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.transparent,border: Border.all(width: 2.0,color: Colors.black)),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(onPressed: (){changequantity('decrement');}, icon: Icon(Icons.remove)),                                   
                                        Text('$quantity'),
                                        IconButton(onPressed: (){changequantity('increment');}, icon: Icon(Icons.add))
                                        
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: -0.4,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Color.fromARGB(255,228, 228, 228)),
                      child: Center(
                        child: IconButton(
                          onPressed:(){deleteCartProduct();},
                          icon: Icon(Icons.close,color: Colors.white,)
                         ),
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