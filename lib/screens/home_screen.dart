import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import 'cart_screen.dart';
import 'product_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            right: MediaQuery.of(context).size.width / 2.65,
            child: const ProductScreen()),
        Positioned.fill(
          left: MediaQuery.of(context).size.width / 1.6,
          child: Container(
              decoration: const BoxDecoration(
                  border: Border(left: BorderSide(width: 1))),
              child: const CartScreen()),
        ),
      ],
    );
  }
}
