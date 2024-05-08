import 'package:eccomerce/features/DashBoard/controller/controller.dart';
import 'package:eccomerce/features/auth/controller/auth_controller.dart';
import 'package:eccomerce/models/order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class YourOrder extends ConsumerWidget {
  static const routeName = 'yourorder-screen';
  const YourOrder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userProvider)!.uid;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:Text('Your Order',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 30,color: Colors.grey[350]!),)
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('S.NO')),
            DataColumn(label: Text('TotalAmount')),
            DataColumn(label: Text('OrderId')),
            DataColumn(label: Text('OrderAt')),
            DataColumn(label: Text('Total Product')),
            DataColumn(label: Text('Payment Status')),
            DataColumn(label: Text('Address')),
          ], 
          rows:ref.watch(yourOrderProvider(userId)).when(
            data: (data){
              int count = 0;
              List<DataRow> rows = [];
              for (OrderModel OrderItem in data) {
                String formattedDateTime = DateFormat.yMMMMd().add_jm().format(OrderItem.orderAt);
                count++;
                rows.add(
                  DataRow(
                    cells: [
                    DataCell(Text(count.toString())),
                    DataCell(Text(OrderItem.totalPrice.toString())),
                    DataCell(Text(OrderItem.id)),
                    DataCell(Text(formattedDateTime)),
                    DataCell(Text(OrderItem.products.length.toString())),
                    OrderItem.status==0?
                     DataCell(Text("not payed")):
                     DataCell(Text("Payed")),
                    DataCell(Text(OrderItem.address)),
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