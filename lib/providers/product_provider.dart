import 'package:flutter/material.dart';
import 'package:flutter_practical_task_nidhi/models/products_model.dart';
import '../services.dart';

class ProductProvider extends ChangeNotifier {
  final _service = Services();
  bool isLoading = false;
  List<Products> _allProducts = [];
  List<Products> _products = [];
  List<Products> get products => _products;
  List<String> _categories = [];
  List<String> get categories => _categories;

  Future<void> getAllProducts() async {
    isLoading = true;
    notifyListeners();
    final response = await _service.getAll();
    _allProducts = response;
    isLoading = false;
    getAllCategories();
    getProductAsperCategory(_allProducts[0].category!);
  }

  void getAllCategories() {
    var seen = Set<String>();
    List<Products> data =
        _allProducts.where((product) => seen.add(product.category!)).toList();
    for (var i = 0; i < data.length; i++) {
      _categories.add(data[i].category!);
    }
    notifyListeners();
  }

  void getProductAsperCategory(String category) {
    _products = [];
    for (var i = 0; i < _allProducts.length; i++) {
      if (_allProducts[i].category == category) {
        _products.add(_allProducts[i]);
      }
    }
    notifyListeners();
  }
}
