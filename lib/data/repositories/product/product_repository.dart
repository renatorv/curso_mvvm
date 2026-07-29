import 'package:curso_mvvm/domain/models/product.dart';
import 'package:curso_mvvm/utils/result.dart';

abstract class ProductRepository {
  Future<Result<List<Product>>> getProducts();
}
