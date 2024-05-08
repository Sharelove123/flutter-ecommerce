import 'package:carousel_slider/carousel_slider.dart';
import 'package:eccomerce/features/DashBoard/controller/controller.dart';
import 'package:eccomerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../auth/controller/auth_controller.dart';

class YourCustomersOrders extends ConsumerWidget {
  static const routeName = 'yourcustomersorders-screen';
  const YourCustomersOrders({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userProvider)!.uid;
    return Scaffold(
      body:Column(
        children: [
          Center(child: Text('Set up Sellers Customers'))
        ],
      )
    );
  }
}