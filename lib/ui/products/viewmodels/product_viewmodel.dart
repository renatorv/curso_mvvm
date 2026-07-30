import 'package:curso_mvvm/data/repositories/product/product_repository.dart';
import 'package:curso_mvvm/domain/models/product.dart';
import 'package:curso_mvvm/utils/command.dart';
import 'package:curso_mvvm/utils/result.dart';
import 'package:flutter/foundation.dart';

class ProductViewmodel extends ChangeNotifier {
  final ProductRepository _productRepository;

  ProductViewmodel({required this._productRepository});

  List<Product> _produts = [];
  List<Product> get products => _produts;

  late final load = Command0(_load);

  Future<Result<List<Product>>> _load() async {
    try {
      final result = await _productRepository.getProducts();

      switch (result) {
        case Ok<List<Product>>():
          _produts = result.value;
          return result;
        default:
          return result;
      }
    } finally {
      notifyListeners();
    }
  }
}
