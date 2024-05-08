import 'dart:io';
import 'package:eccomerce/features/products/widgets/addprodbutton.dart';
import 'package:eccomerce/core/common/widgets/loader.dart';
import 'package:eccomerce/core/utils.dart';
import 'package:eccomerce/features/products/widgets/textfieldforaddproduct.dart';
import 'package:eccomerce/features/products/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';

class AddProduct extends ConsumerStatefulWidget {
  static const routeName = 'addproduct-screen';
  const AddProduct({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddProductState();
}

  

class _AddProductState extends ConsumerState<AddProduct> {
  final TextEditingController name_controller = TextEditingController();
  final TextEditingController discription_controller = TextEditingController();
  String category = '';
  final TextEditingController prize_controller = TextEditingController();
  final TextEditingController size_controller = TextEditingController();
  final _addProductFormKey = GlobalKey<FormState>();

  List<File> images = [];
 
  List<String> furnitureCategories = [
    'Seating Furniture',
    'Table',
    'Storage Furniture',
    'Bedroom Furniture',
    'Outdoor Furniture',
    'Furniture Accessories',
  ];

  void selectCategory(String selectedCategory){
    setState(() {
      category = selectedCategory;
    });
  }


  @override
  void dispose() {
    super.dispose();
    name_controller.dispose();
    discription_controller.dispose();
    prize_controller.dispose();
    size_controller.dispose();

  }

  void selectImages() async {
    var res = await pickImages();
    print("the selected images are $res");
    setState(() {
      images = res;
    });
  }

    void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ListView.builder(
            itemCount: furnitureCategories.length,
            itemBuilder: (BuildContext context,int index){
              return RadioListTile<String>(
                  title: Text(furnitureCategories[index]),
                  value: furnitureCategories[index],
                  groupValue: category,
                  onChanged: (value) {
                    selectCategory(value!);
                    Navigator.pop(context);
                  },
                );
            },
          )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final isloading = ref.watch(productControllerProvider);

    return Scaffold(
      body: isloading? Loader()
      :NestedScrollView(
        headerSliverBuilder:(context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.black,
              title: Text('Add product',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25,color: Colors.white)),
              leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){Navigator.of(context).pop();},),
            )
          ];
        },
        body: Padding(
          padding: EdgeInsets.all(6),
          child: Form(
            key: _addProductFormKey,
            child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  CustomTextField(
                    hintText: 'Enter your product name',
                    controller: name_controller, 
                    maxLine: 1,
                  ),
            
                  SizedBox(height: 5,),
            
                  const SizedBox(height: 20),
            
                  images.isNotEmpty
                      ? CarouselSlider(
                          items: images.map(
                            (i) {
                              return Builder(
                                builder: (BuildContext context) => Image.file(
                                  i,
                                  fit: BoxFit.cover,
                                  height: 200,
                                ),
                              );
                            },
                          ).toList(),
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 200,
                          ),
                        )
                      : GestureDetector(
                          onTap: selectImages,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.folder_open,
                                    size: 40,
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    'Select Product Images',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  
                  const SizedBox(height: 20,),
                  CustomTextField(
                    hintText: 'Enter your product description',
                    controller: discription_controller, 
                    maxLine: 7,
                  ),
            
                  const SizedBox(height: 5,),
            
            
                  OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(minimumSize: Size(MediaQuery.of(context).size.width - 70, 50)),
                  onPressed: (){
                    _showBottomSheet(context);
                  },
                  icon: Icon(Icons.arrow_downward),
                  label: Text('${category == ''?'Enter category':category}')
                  ),
            
                  const SizedBox(height: 5,),
            
            
                  CustomTextField(
                    hintText: 'Enter your product prize',
                    controller: prize_controller, 
                    maxLine: 1,
                  ),
                  
                  const SizedBox(height: 5,),
            
                  CustomTextField(
                    hintText: 'Enter your product size',
                    controller: size_controller, 
                    maxLine: 1,
                  ),

                  const SizedBox(height: 20,),

                  CustomButton(text: 'Add Product', onTap: (){
                    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
                      ref.read(productControllerProvider.notifier).add_products(
                        context,
                        ref,
                        name_controller.text.trim(),
                        discription_controller.text.trim(), 
                        category, 
                        images, 
                        prize_controller.text.trim(), 
                        size_controller.text.trim(), 
                        null,
                        1,
                        null);
                      //add addproduct of produictcontroller
                    }
                  })
                ],
              ),
            ),
        ),

        )
    );
  }
}