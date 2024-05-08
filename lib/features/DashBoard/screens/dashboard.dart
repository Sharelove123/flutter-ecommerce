import 'package:eccomerce/features/DashBoard/screens/yourcutomersorders.dart';
import 'package:eccomerce/features/DashBoard/screens/yourorder.dart';
import 'package:eccomerce/features/DashBoard/screens/youruploaded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashBoardPage extends ConsumerStatefulWidget {
  static const routeName = 'dashboard-screen';
  const DashBoardPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends ConsumerState<DashBoardPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Dashboard',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 30,color:Colors.white),),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey[200]!, // Light grey
                Colors.grey[800]!, // Dark grey
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey[100]!, // Start color
              Colors.grey[800]!, // End color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            //customer ui
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              child: Text("Your Customer Profile",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w700),),
            ),

            ListTile(
              title: Text('Your Order',style: TextStyle(color: Colors.orange[800],fontWeight: FontWeight.w600,fontSize: 24),),
              trailing: Icon(Icons.arrow_right_alt_outlined,color: Colors.orange[800],),
              onTap: (){
                Navigator.of(context).pushNamed(YourOrder.routeName);
              },
            ),

            //seller ui
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 12.0),
              child: Container(
                width: MediaQuery.of(context).size.width-20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(child: Text("Your Seller Profile",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w700),))),
            ),
            
            ListTile(
              title: Text('Your Uploads',style: TextStyle(color: Colors.orange[800],fontWeight: FontWeight.w600,fontSize: 24),),
              trailing: Icon(Icons.arrow_right_alt_outlined,color: Colors.orange[800],),
              onTap: (){
                Navigator.of(context).pushNamed(YourUploads.routeName);
              },
            ),

            ListTile(
              title: Text('Your Customers Order',style: TextStyle(color: Colors.orange[800],fontWeight: FontWeight.w600,fontSize: 24),),
              trailing: Icon(Icons.arrow_right_alt_outlined,color: Colors.orange[800],),
              onTap: (){
                Navigator.of(context).pushNamed(YourCustomersOrders.routeName);
              },
            ),

          ],
        ),
      ),
    );
  }
}