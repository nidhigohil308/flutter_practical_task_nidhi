import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/products_model.dart';

class CartProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Products> _cartProducts = [];
  List<Products> get cartProducts => _cartProducts;
  int _price = 0;
  int get price => _price;
  int _quantity = 0;
  int get quantity => _quantity;

  addToCart(Products product) {
    if (_cartProducts != []) {
      bool isAdded = false;
      for (var element in _cartProducts) {
        if (element.id == product.id) {
          isAdded = true;
          element.quantity = element.quantity! + 1;
          _price = price + product.price!;
          break;
        }
      }
      if (!isAdded) {
        _cartProducts.add(product);
        _price = price + product.price!;
      }
    } else {
      _cartProducts.add(product);
      _price = price + product.price!;
    }
    notifyListeners();
  }

  void addQuantity(int index) {
    _cartProducts[index].quantity = _cartProducts[index].quantity! + 1;
    _price = price + _cartProducts[index].price!;
    notifyListeners();
  }

  void removeQuantity(int index) {
    if (_cartProducts[index].quantity! > 1) {
      _cartProducts[index].quantity = _cartProducts[index].quantity! - 1;
      _price = price - _cartProducts[index].price!;
      notifyListeners();
    }
  }

  void removeProductFromCart(Products product) {
    if (product.quantity! > 1) {
      int totalPrice = product.quantity! * product.price!;
      _price = price - totalPrice;
      log(totalPrice.toString() + product.quantity.toString());
      product.quantity = 1;
    } else {
      _price = price - product.price!;
    }
    _cartProducts.remove(product);
    notifyListeners();
  }
}
