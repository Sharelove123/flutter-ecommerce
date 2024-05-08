import 'product_model.dart';

class OrderModel {
  final String id;
  final List<ProductModel> products;
  final String address;
  final String userId;
  final DateTime orderAt;
  final int status;
  final double totalPrice;
  OrderModel({
    required this.id,
    required this.products,
    required this.address,
    required this.userId,
    required this.orderAt,
    required this.status,
    required this.totalPrice,
  });


  OrderModel copyWith({
    String? id,
    List<ProductModel>? products,
    String? address,
    String? userId,
    DateTime? orderAt,
    int? status,
    double? totalPrice,
  }) {
    return OrderModel(
      id: id ?? this.id,
      products: products ?? this.products,
      address: address ?? this.address,
      userId: userId ?? this.userId,
      orderAt: orderAt ?? this.orderAt,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'address': address,
      'userId': userId,
      'orderAt': orderAt.millisecondsSinceEpoch,
      'status': status,
      'totalPrice': totalPrice,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id']??'',
      products: List<ProductModel>.from((map['products']??[]).map<ProductModel>((x) => ProductModel.fromMap(x as Map<String,dynamic>),),),
      address: map['address'] ??'',
      userId: map['userId'] ??'',
      orderAt: DateTime.fromMillisecondsSinceEpoch(map['time']??0),
      status: map['status'] ??0,
      totalPrice: map['totalPrice']??0.0,
    );
  }
}
