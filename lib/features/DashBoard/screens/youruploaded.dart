import 'package:carousel_slider/carousel_slider.dart';
import 'package:eccomerce/features/DashBoard/controller/controller.dart';
import 'package:eccomerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../auth/controller/auth_controller.dart';

class YourUploads extends ConsumerWidget {
  static const routeName = 'youruploads-screen';
  const YourUploads({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userProvider)!.uid;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:Text('Your Uploads',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 30,color: Colors.grey[350]!),)
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          dataRowMaxHeight: 200,
          columnSpacing: 70,
          columns: [
            DataColumn(label: Text('S.NO')),
            DataColumn(label: Text('author')),
            DataColumn(label: Text('name')),
            DataColumn(label: Text('Uploaded At')),
            DataColumn(label: Text('description')),
            DataColumn(label: Text('prize')),
            DataColumn(label: Text('images')),
          ], 
          rows:ref.watch(yourUploadsProvider(userId)).when(
            data: (data){
              int count = 0;
              List<DataRow> rows = [];
              for (ProductModel Product in data) {
                String formattedDateTime = DateFormat.yMMMMd().add_jm().format(Product.time);
                count++;
                rows.add(
                  DataRow(
                    cells: [
                    DataCell(Text(count.toString())),

                    DataCell(Text(Product.author.toString())),

                    DataCell(Text(Product.name)),

                    DataCell(Text(formattedDateTime)),

                    DataCell(
                      SingleChildScrollView(
                        child: Container(
                          width: 200,
                          child: Text(Product.description.toString())
                        ),
                      )
                    ),

                    DataCell(Text(Product.prize)),

                    DataCell(
                      Container(
                        width: 140,
                        child: CarouselSlider(
                            items: Product.images.map(
                              (i) {
                                return Builder(
                                  builder: (BuildContext context) => Image.network(
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
                          ),
                      )
                    
                    )
                  ]),
                );
              }
              return rows;
            }, 
        
            error: (err,showtrace){
              print(err);
              print(showtrace);
                return [
                  DataRow(
                    cells: [
                    DataCell(Text('')),
                    DataCell(Text('')),
                    DataCell(Text('')),
                    DataCell(Text('')),
                    DataCell(Text('')),
                    DataCell(Text('')),
                    DataCell(Text(''))
                  ]),
              ];
            }, 
            loading:(){
                return [
                    DataRow(
                      cells: [
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text('')),
                      DataCell(Text(''))
                ]),
              ];
            }
            )
        ),
      ),
    );
  }
}