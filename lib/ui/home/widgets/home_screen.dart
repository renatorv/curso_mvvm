import 'package:curso_mvvm/config/dependecies.dart';
import 'package:curso_mvvm/ui/products/viewmodels/product_viewmodel.dart';
import 'package:curso_mvvm/ui/products/widgets/products_widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ProductsWidgets(
        productViewmodel: ProductViewmodel(productRepository: getIt()),
      ),
    );
  }
}
