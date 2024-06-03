import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/enviornment.dart';
import 'package:teslo_shop/features/products/domain/domain.dart';
import 'package:teslo_shop/features/products/infrastructure/mappers/product_mapper.dart';

class ProductsDatasourceImpl extends ProductsDatasource {
  late Dio dio;
  String _accessToken;

  ProductsDatasourceImpl({required String accessToken})
      : _accessToken = accessToken {
    _initializeDio();
  }

  void _initializeDio() {
    dio = Dio(BaseOptions(
        baseUrl: Envionment.apiUrl,
        headers: {'Authorization': 'Bearer $_accessToken'}));
  }

  @override
  void updateAccessToken(String newToken) {
    _accessToken = newToken;
    _initializeDio();
  }

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProductsByPage(
      {int limit = 10, int offset = 0}) async {
    final response =
        await dio.get<List>('/products?limit=$limit&offset=$offset');
    final List<Product> products = [];
    for (final product in response.data ?? []) {
      products.add(ProductMapper.jsonToEntity(product));
    }
    return products;
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
  }
}
