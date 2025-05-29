import 'package:shop_juice/features/catalog_feature/data/models/product_model.dart';
import 'package:shop_juice/features/shopping_cart/data/models/cart_item_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

//Сервис для работы с корзиной
class ShoppingCartService {
  final Database _db;

  ShoppingCartService(this._db);

  //Проверка интернет соединения
  Future<bool> _checkInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  //Получение товаров из локальной бд
  Future<List<CartItemModel>> getItems() async {
    try {
      final List<Map<String, dynamic>> maps = await _db.query('cart');
      return List.generate(maps.length, (i) => CartItemModel.fromJson(maps[i]));
    } catch (e) {
      print('Error getting cart items: $e');
      throw Exception('Error getting cart items: $e');
    }
  }

  //Добавление товара в корзину
  Future<void> addItem(ProductModel product) async {
    try {
      // Проверяем, есть ли уже такой товар в корзине
      final List<Map<String, dynamic>> existingItems = await _db.query(
        'cart',
        where: 'title = ?',
        whereArgs: [product.title],
      );

      if (existingItems.isNotEmpty) {
        // Если товар уже есть, увеличиваем количество
        final currentItem = CartItemModel.fromJson(existingItems.first);
        await _db.update(
          'cart',
          {'quantity': currentItem.quantity + 1},
          where: 'title = ?',
          whereArgs: [product.title],
        );
      } else {
        // Если товара нет, добавляем новый
        await _db.insert('cart', CartItemModel(product: product).toJson());
      }
    } catch (e) {
      print('Error adding item to cart: $e');
      throw Exception('Error adding item to cart: $e');
    }
  }

  //Удаление товара из корзины
  Future<void> removeItem(CartItemModel item) async {
    try {
      if (item.quantity > 1) {
        // Если больше 1 штуки, уменьшаем количество
        await _db.update(
          'cart',
          {'quantity': item.quantity - 1},
          where: 'title = ?',
          whereArgs: [item.product.title],
        );
      } else {
        // Если 1 штука, удаляем товар
        await _db.delete(
          'cart',
          where: 'title = ?',
          whereArgs: [item.product.title],
        );
      }
    } catch (e) {
      print('Error removing item from cart: $e');
      throw Exception('Error removing item from cart: $e');
    }
  }
}