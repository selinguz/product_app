import 'dart:convert';

import 'package:http/http.dart' as http;

class Product {
  int id;
  String title;
  String description;
  int price;
  double discountPercentage;
  int stock;
  String brand;
  String category;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.stock,
    required this.brand,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      discountPercentage: json['discountPercentage'],
      stock: json['stock'],
      brand: json['brand'],
      category: json['category'],
    );
  }

  static final String apiUrl = "https://dummyjson.com/products";

  static Future<List<Product>> getProducts() async {
    var response = await http.get(Uri.parse(apiUrl));
    return (json.decode(response.body)['products'] as List)
        .map((e) => Product.fromJson(e))
        .toList();
  }
}
