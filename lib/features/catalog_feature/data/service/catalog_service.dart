import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shop_juice/features/catalog_feature/data/models/product_model.dart';
import 'package:shop_juice/utils/constants/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

//Сервис для работы с продуктами в каталоге

class CatalogService {
  final Dio _dio;
  final Database _db;

  CatalogService(this._dio, this._db);

  //Проверка интернет соединения
  Future<bool> _checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  //Получение продуктов из API или локальной БД
  Future<List<ProductModel>> getProducts() async {
    try {
      // Сначала проверяем локальную БД
      final List<Map<String, dynamic>> dbProducts = await _db.query('products');
      if (dbProducts.isNotEmpty) {
        print('Loading products from local database');
        return dbProducts.map((map) => ProductModel.fromJson(map)).toList();
      }

      // Если в локальной БД нет данных, проверяем интернет
      final hasInternet = await _checkInternetConnection();
      if (!hasInternet) {
        print('No internet connection and no local data available');
        throw Exception('No internet connection available');
      }

      // Если есть интернет, загружаем с API
      print('Loading products from API');
      final response = await _dio.get('/products');
      
      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data['products'];
        final products = productsJson.map((json) => ProductModel.fromJson(json)).toList();
        
        // Сохраняем в локальную БД
        await _db.delete('products');
        for (var product in products) {
          await _db.insert('products', product.toJson());
        }
        
        return products;
      } else {
        print('Error status code: ${response.statusCode}');
        print('Error response: ${response.data}');
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getProducts: $e');
      if (e is DioException) {
        print('DioError type: ${e.type}');
        print('DioError message: ${e.message}');
        print('DioError response: ${e.response?.data}');
      }
      throw Exception('Error fetching products: $e');
    }
  }
  
}