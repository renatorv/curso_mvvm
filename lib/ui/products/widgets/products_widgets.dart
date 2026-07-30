import 'package:curso_mvvm/ui/products/viewmodels/product_viewmodel.dart';
import 'package:flutter/material.dart';

class ProductsWidgets extends StatefulWidget {
  final ProductViewmodel productViewmodel;
  const ProductsWidgets({super.key, required this.productViewmodel});

  @override
  State<ProductsWidgets> createState() => _ProductsWidgetsState();
}

class _ProductsWidgetsState extends State<ProductsWidgets> {
  @override
  void initState() {
    super.initState();
    widget.productViewmodel.load.execute();
  }

  @override
  Widget build(BuildContext context) {
    final command = widget.productViewmodel.load;
    return ListenableBuilder(
      listenable: command,
      builder: (context, child) {
        if (command.running) {
          return Center(child: CircularProgressIndicator());
        }
        if (command.error) {
          return Center(child: Text('Ocorreu um erro ao buscar os produtos'));
        }
        return child!;
      },
      child: Text('Produtos carregados com sucesso!!!'),
    );
  }
}
