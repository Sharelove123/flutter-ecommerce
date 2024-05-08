import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eccomerce/core/common/widgets/productscard.dart';
import 'package:eccomerce/features/cart/controller/cart_controller.dart';
import 'package:eccomerce/features/products/controller/controller.dart';
import 'package:eccomerce/features/products/delegates/search_product_delegates.dart';
import 'package:eccomerce/models/product_model.dart';
import 'package:eccomerce/utils.dart/product_page_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eccomerce/core/constants/preservescroll.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}


class _HomeScreenState extends ConsumerState<HomeScreen> {
int? _selected_chip_value = 0;
String selectedCategory = 'All';
List<String> furnitureCategories = [
    'All',
    'Seating Furniture',
    'Table',
    'Storage Furniture',
    'Bedroom Furniture',
    'Outdoor Furniture',
    'Furniture Accessories',
  ];

@override
Widget build(BuildContext context) {
  final query = ref.read(productControllerProvider.notifier).get_product_by_category(selectedCategory);
    return  Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(  
        backgroundColor: Colors.transparent,
        actions: [
          ProductIcons(fun: (){}, icon: Icons.notifications,left: false,),
          ProductIcons(fun: (){}, icon: Icons.more_vert,left: false,)
        ],
        leading: ProductIcons(fun: (){}, icon: Icons.filter_list,left: true,),
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
               Padding(
                padding: EdgeInsets.only(left: 10,right: 10,top: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(textAlign: TextAlign.start,'Best Funica',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800))),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                child: Align(alignment: Alignment.topLeft,child: Text('Fueniture in your home',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800),)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10,right: 10,top: 20),
                child: GestureDetector(
                  onTap: (){
                     showSearch(context: context, delegate: SearchProductDelegate(ref));
                  },
                  child: Container(
                    height: 55,
                    decoration:BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.12),
                          offset: Offset(0,3),
                          blurRadius:10,
                          spreadRadius: 8,
                        )
                      ]
                    ),
                    child:const Center(
                      child: Row(
                        children: [
                          Padding(padding: EdgeInsets.only(left: 10)),
                          Icon(Icons.search,color: Colors.black,),
                          SizedBox(width: 4,),
                          Text("search",style: TextStyle(fontSize: 17),),
                        ],
                      )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text('categories',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                  TextButton(onPressed: (){}, child: Text('viewall',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),))
                ],),
              ),

              //chip rwo for choiceing category
              Padding(
                padding: const EdgeInsets.only(right:8.0,left: 8.0,bottom: 8.0,top: 0.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: 
                        List.generate( 
                              3,
                              (int index) {
                                  String label = '';
                                  Widget? avatar; // Define a widget for the avatar
                        
                                  // Assign different labels and avatars to the chips
                                  if (index == 0) {
                                    label = 'All';
                                  } else if (index == 1) {
                                    label = 'Table';
                                    avatar = Icon(Icons.table_bar);
                                  } else if (index == 2) {
                                    label = 'Seating Furniture';
                                    avatar = Icon(Icons.chair);
                                  }
                                // choice chip allow us to
                                // set its properties.
                                return Row(
                                  children: [
                                    ChoiceChip(
                                      labelPadding: EdgeInsets.fromLTRB(6, 3, 0, 6),
                                      padding: EdgeInsets.fromLTRB(18, 14, 18, 14),
                                      // color of background
                                      backgroundColor: Colors.grey.shade50,
                                      // setting shape of border
                                      avatar: avatar,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: _selected_chip_value == index? Colors.green:Colors.grey,
                                          width: 2),
                                        borderRadius: BorderRadius.circular(20)
                                        ),
                                      label: Text(label,style:TextStyle(fontWeight: FontWeight.w600),),
                                      // color of selected chip
                                      selectedColor: Colors.white,
                                      
                                          // selected chip value
                                      selected: _selected_chip_value == index, 
                                          // onselected method
                                      onSelected: (bool selected) { 
                                          setState(() {
                                            _selected_chip_value = selected ? index : null;
                                            selectedCategory = label;
                                                            
                                        });
                                      },
                                    ),
                                    SizedBox(width: 10,)
                                  ],
                                );
                           },
                        ).toList(),
                  ),
                ),
              ),
      
              SizedBox(height: 20,),
              selectedCategory=="All"?Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: furnitureCategories.map((category) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0,bottom: 20.0,top: 0.0),
                      child: Text(
                        category,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      height: 280,
                      child: FirestoreListView(
                        scrollDirection: Axis.horizontal,
                        key: PageStorageKey('${ScrollConstant.homeScreenProductViewListviewPreserveScroll}_$category'),
                        query: ref.read(productControllerProvider.notifier).get_product_by_category(category),
                        itemBuilder: (BuildContext context, snapshot) {
                          final ProductModel product = ProductModel.fromMap(snapshot.data() as Map<String, dynamic>);
                          return Row(
                            children: [
                            ProductCard(
                              addProductToCart: () {
                                addProductToCart(snapshot.id, product);
                              },
                              product: product,
                              docid: snapshot.id,
                              width: 210.0,
                            ),
                            SizedBox(width: 25),
                          ],
                        );
                      },
                                                 ),
                    ),
              
                    SizedBox(height: 30,)
                  ],
              
                );
              }).toList(),
            ):
                
              Container(
                height: 400,
                child: FirestoreListView( 
                  scrollDirection:Axis.vertical,
                //  key: PageStorageKey(ScrollConstant.homeScreenProductViewListviewPreserveScroll),
                  query:query,
                  itemBuilder: (BuildContext context, snapshot) {
                    final ProductModel product = ProductModel.fromMap(snapshot.data() as Map<String, dynamic>);
                    print("snapshotid ${snapshot.id}");
                    print(" product is $product");
                    return Column(
                      children: [
                        Center(child: ProductCard(addProductToCart:(){ addProductToCart(snapshot.id,product);},product: product,docid: snapshot.id,width:selectedCategory=="All"?210.0:MediaQuery.of(context).size.width-40)),
                        SizedBox(height: 15,)
                      ],
                    )
                      ;
                  }),
              )
          
              ],
        ),
      ),
    );
  }

  Query<Object?>? query;


  get_product_by_category(String category){
    setState(() {
      query =  ref.read(productControllerProvider.notifier).get_product_by_category(category);
    });
  }

  addProductToCart(productId,product){
    ref.read(cartControllerProvider.notifier).addProductToCart(context, productId, product);
  }
  
}

