import 'package:eccomerce/features/DashBoard/repository/repositary.dart';
import 'package:eccomerce/models/order.dart';
import 'package:eccomerce/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//seller Providers
final yourUploadsProvider = StreamProvider.family((ref,String uid){
  return ref.watch(productControllerProvider.notifier).get_seller_products(uid);
});



//Customer Providers
final yourOrderProvider = StreamProvider.family((ref,String uid){
  return ref.watch(productControllerProvider.notifier).get_orders_by_uid(uid);
});





final productControllerProvider = StateNotifierProvider<DashBoardController,bool>((ref) {
   final dashboardsrepository = ref.watch(dashBoardRepositoryProvider);
   return DashBoardController(dashboardsrepository: dashboardsrepository);
});

class DashBoardController extends StateNotifier<bool>{
  final DashBoardRepository _dashboardrepository;
  DashBoardController({
    required DashBoardRepository dashboardsrepository,
    }): _dashboardrepository=dashboardsrepository,
        super(false);

    //seller function

    Stream<List<ProductModel>> get_seller_products(String uid){
      return _dashboardrepository.get_seller_products(uid);
    }

    //customer function
    Stream<List<OrderModel>> get_orders_by_uid(String uid){
      return _dashboardrepository.get_orders_by_uid(uid);
    }
}