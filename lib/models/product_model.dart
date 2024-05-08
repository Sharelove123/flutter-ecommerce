import 'dart:convert';

class ProductModel {
  final String docId;
  final String name;
  final String description;
  final String category;
  final List<String> images;
  final String prize;
  final String size;
  final String author;
  final int quantity ;
  final DateTime time;
  ProductModel({
    required this.docId,
    required this.name,
    required this.description,
    required this.category,
    required this.images,
    required this.prize,
    required this.size,
    required this.author,
    required this.quantity,
    required this.time,
  });

  ProductModel copyWith({
    String? docId,
    String? name,
    String? description,
    String? category,
    List<String>? images,
    String? prize,
    String? size,
    String? author,
    int? quantity,
    DateTime? time,
  }) {
    return ProductModel(
      docId: docId ?? this.docId,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      images: images ?? this.images,
      prize: prize ?? this.prize,
      size: size ?? this.size,
      author: author ?? this.author,
      quantity:quantity?? this.quantity,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'name': name,
      'description': description,
      'category': category,
      'images': images,
      'prize': prize,
      'size': size,
      'author': author,
      'quantity':quantity,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      docId: map['docId']?? '',
      name: map['name'] ??'',
      description: map['description']??'',
      category: map['category']??'',
      images: List<String>.from((map['images']??[])),
      prize: map['prize']??'',
      size: map['size']??'',
      author: map['author']??'',
      quantity: map['quantity']??1 ,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
    );
  }


  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

}