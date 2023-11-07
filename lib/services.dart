import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/products_model.dart';

class Services {
  Future<List<Products>> getAll() async {
    const url = 'https://dummyjson.com/products';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    List<Products> productList = [];

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final products = json['products'].map<Products>((e) {
        return Products.fromJson(e);
      }).toList();
      productList = products;
      return productList;
    }
    return productList;
  }
}
